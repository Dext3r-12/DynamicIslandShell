#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <thread>
#include <chrono>
#include <iomanip>
#include <memory>
#include <array>
#include <filesystem>

namespace fs = std::filesystem;

// --- CPU ---
struct CpuStats {
    unsigned long long idle;
    unsigned long long total;
};

CpuStats getCpuRaw() {
    std::ifstream file("/proc/stat");
    std::string line;
    if (!file.is_open()) return {0, 0};

    std::getline(file, line);
    std::istringstream ss(line);
    std::string cpu;
    unsigned long long user, nice, system, idle, iowait, irq, softirq, steal;
    ss >> cpu >> user >> nice >> system >> idle >> iowait >> irq >> softirq >> steal;

    unsigned long long idleTime = idle + iowait;
    unsigned long long totalTime = user + nice + system + idle + iowait + irq + softirq + steal;

    return {idleTime, totalTime};
}

float getCpuUsage(CpuStats& prev) {
    CpuStats curr = getCpuRaw();
    unsigned long long totalDiff = curr.total - prev.total;
    unsigned long long idleDiff = curr.idle - prev.idle;

    prev = curr;

    if (totalDiff == 0) return 0.0f;
    return (1.0f - static_cast<float>(idleDiff) / totalDiff) * 100.0f;
}

// --- RAM (Использование в Гигабайтах) ---
float getRamUsageGb() {
    std::ifstream file("/proc/meminfo");
    std::string line;
    unsigned long long memTotal = 0, memAvailable = 0;

    while (std::getline(file, line)) {
        if (line.find("MemTotal:") == 0) {
            std::istringstream ss(line);
            std::string key;
            ss >> key >> memTotal;
        } else if (line.find("MemAvailable:") == 0) {
            std::istringstream ss(line);
            std::string key;
            ss >> key >> memAvailable;
        }
    }

    if (memTotal == 0 || memAvailable > memTotal) return 0.0f;
    
    unsigned long long memUsed = memTotal - memAvailable;
    return static_cast<float>(memUsed) / (1024.0f * 1024.0f);
}

// --- GPU ---
std::string getGpuUsage() {
    try {
        if (fs::exists("/sys/class/drm")) {
            for (const auto& entry : fs::directory_iterator("/sys/class/drm")) {
                std::string path = entry.path().string() + "/device/gpu_busy_percent";
                if (fs::exists(path)) {
                    std::ifstream f(path);
                    std::string val;
                    if (f >> val && !val.empty()) return val;
                }
            }
        }
    } catch (...) {}

    try {
        if (fs::exists("/sys/class/drm")) {
            for (const auto& entry : fs::directory_iterator("/sys/class/drm")) {
                std::string actPath = entry.path().string() + "/gt/gt0/rps_act_freq_mhz";
                std::string maxPath = entry.path().string() + "/gt/gt0/rps_max_freq_mhz";
                
                if (!fs::exists(actPath)) {
                    actPath = entry.path().string() + "/gt_act_freq_mhz";
                    maxPath = entry.path().string() + "/gt_max_freq_mhz";
                }

                if (fs::exists(actPath) && fs::exists(maxPath)) {
                    std::ifstream fAct(actPath), fMax(maxPath);
                    int act = 0, max = 0;
                    if ((fAct >> act) && (fMax >> max) && max > 0) {
                        int pct = static_cast<int>((static_cast<float>(act) / max) * 100.0f);
                        return std::to_string(pct);
                    }
                }
            }
        }
    } catch (...) {}

    std::array<char, 128> buffer;
    std::string result = "";
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen("nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null", "r"), pclose);
    if (pipe) {
        if (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
            result = buffer.data();
            result.erase(result.find_last_not_of(" \n\r\t") + 1);
            if (!result.empty()) return result;
        }
    }

    return "N/A";
}

int main(int argc, char* argv[]) {
    // Настройка задержки (по умолчанию 2 секунды)
    double delaySeconds = 2.0;

    if (argc > 1) {
        try {
            delaySeconds = std::stod(argv[1]);
            if (delaySeconds <= 0) delaySeconds = 2.0; // защита от отрицательных чисел
        } catch (...) {
            // Если ввели текст вместо числа, игнорируем и оставляем 2.0
        }
    }

    CpuStats prevCpu = getCpuRaw();

    while (true) {
        // Переводим секунды в миллисекунды для точной паузы
        std::this_thread::sleep_for(std::chrono::milliseconds(static_cast<int>(delaySeconds * 1000)));

        float cpu = getCpuUsage(prevCpu);
        float ramGb = getRamUsageGb();
        std::string gpu = getGpuUsage();

        std::cout << std::fixed << std::setprecision(2)
                  << cpu << " | "
                  << gpu << " | "
                  << ramGb << std::endl;
    }

    return 0;
}
