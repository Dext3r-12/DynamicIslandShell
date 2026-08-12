#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <thread>
#include <chrono>
#include <iomanip>
#include <array>
#include <vector>
#include <memory>
#include <cstdio>

// Структура для хранения данных процессора
struct CpuData {
    long long idle;
    long long total;
};

// Функция для чтения сырых данных CPU
CpuData getCpuData() {
    std::ifstream file("/proc/stat");
    std::string line;
    std::getline(file, line);
    std::istringstream iss(line);
    
    std::string cpu;
    long long user, nice, system, idle, iowait, irq, softirq, steal;
    iss >> cpu >> user >> nice >> system >> idle >> iowait >> irq >> softirq >> steal;
    
    long long idleTime = idle + iowait;
    long long totalTime = user + nice + system + idle + iowait + irq + softirq + steal;
    
    return {idleTime, totalTime};
}

// Вычисление нагрузки на CPU в процентах
int getCpuUsage() {
    CpuData start = getCpuData();
    std::this_thread::sleep_for(std::chrono::milliseconds(200));
    CpuData end = getCpuData();
    
    long long totalDiff = end.total - start.total;
    long long idleDiff = end.idle - start.idle;
    
    if (totalDiff == 0) return 0;
    return 100 * (totalDiff - idleDiff) / totalDiff;
}

// Функция для выполнения консольной команды (для Nvidia)
std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, int(*)(FILE*)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) return "";
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    if (!result.empty() && result.back() == '\n') result.pop_back();
    return result;
}

// Получение нагрузки на GPU (AMD, Nvidia, Intel)
std::string getGpuUsage() {
    // 1. Проверка AMD GPU (sysfs)
    for (int i = 0; i < 4; ++i) {
        std::string path = "/sys/class/drm/card" + std::to_string(i) + "/device/gpu_busy_percent";
        std::ifstream file(path);
        if (file.is_open()) {
            std::string val;
            file >> val;
            if (!val.empty()) return val + "%";
        }
    }

    // 2. Проверка Nvidia GPU (nvidia-smi)
    std::string nv = exec("nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null");
    if (!nv.empty()) {
        return nv + "%";
    }

    // 3. Проверка Intel GPU — Метод RC6 (замер времени простоя ядра)
    std::vector<std::string> rc6_paths = {
        "/sys/class/drm/card0/power/rc6_residency_ms",
        "/sys/class/drm/card0/gt/gt0/rc6_residency_ms",
        "/sys/class/drm/card1/power/rc6_residency_ms",
        "/sys/class/drm/card1/gt/gt0/rc6_residency_ms"
    };

    for (const auto& path : rc6_paths) {
        std::ifstream f1(path);
        if (f1.is_open()) {
            long long rc6_1 = 0, rc6_2 = 0;
            f1 >> rc6_1;
            f1.close();

            auto t1 = std::chrono::steady_clock::now();
            std::this_thread::sleep_for(std::chrono::milliseconds(200));
            auto t2 = std::chrono::steady_clock::now();

            std::ifstream f2(path);
            if (f2.is_open()) {
                f2 >> rc6_2;
                f2.close();

                double elapsed_ms = std::chrono::duration<double, std::milli>(t2 - t1).count();
                double rc6_diff = static_cast<double>(rc6_2 - rc6_1);

                if (elapsed_ms > 0) {
                    double busy_pct = 100.0 * (1.0 - (rc6_diff / elapsed_ms));
                    if (busy_pct < 0.0) busy_pct = 0.0;
                    if (busy_pct > 100.0) busy_pct = 100.0;
                    return std::to_string(static_cast<int>(busy_pct)) + "%";
                }
            }
        }
    }

    // 4. Проверка Intel GPU — Запасной метод (оценка по частоте GPU)
    std::vector<std::string> card_paths = {
        "/sys/class/drm/card0",
        "/sys/class/drm/card1",
        "/sys/class/drm/card0/gt/gt0",
        "/sys/class/drm/card1/gt/gt0"
    };

    for (const auto& base : card_paths) {
        std::ifstream f_cur(base + "/gt_cur_freq_mhz");
        if (!f_cur.is_open()) f_cur.open(base + "/act_freq_mhz");

        std::ifstream f_min(base + "/gt_min_freq_mhz");
        if (!f_min.is_open()) f_min.open(base + "/min_freq_mhz");

        std::ifstream f_max(base + "/gt_max_freq_mhz");
        if (!f_max.is_open()) f_max.open(base + "/max_freq_mhz");

        if (f_cur.is_open() && f_min.is_open() && f_max.is_open()) {
            int cur = 0, min_f = 0, max_f = 0;
            f_cur >> cur;
            f_min >> min_f;
            f_max >> max_f;

            if (max_f > min_f) {
                int pct = (cur - min_f) * 100 / (max_f - min_f);
                if (pct < 0) pct = 0;
                if (pct > 100) pct = 100;
                return std::to_string(pct) + "%";
            }
        }
    }

    return "N/A";
}

// Получение занятой ОЗУ в гигабайтах с десятыми долями (напр. 4.2)
double getRamUsageGB() {
    std::ifstream file("/proc/meminfo");
    std::string line, key, unit;
    long long total = 0, free = 0, buffers = 0, cached = 0, sreclaimable = 0, value = 0;
    
    while (std::getline(file, line)) {
        std::istringstream iss(line);
        iss >> key >> value >> unit;
        if (key == "MemTotal:") total = value;
        else if (key == "MemFree:") free = value;
        else if (key == "Buffers:") buffers = value;
        else if (key == "Cached:") cached = value;
        else if (key == "SReclaimable:") sreclaimable = value;
    }
    
    long long used = total - free - buffers - cached - sreclaimable;
    return used / (1024.0 * 1024.0);
}

int main() {
    int cpuUsage = getCpuUsage();
    std::string gpuUsage = getGpuUsage();
    double ramUsageGB = getRamUsageGB();

    std::cout << cpuUsage << "% | " 
              << gpuUsage << " | " 
              << std::fixed << std::setprecision(1) << ramUsageGB << "G" 
              << std::endl;

    return 0;
}
