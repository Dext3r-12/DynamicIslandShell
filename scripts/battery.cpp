#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>
#include <vector>
#include <cmath>

namespace fs = std::filesystem;

// Чтение первой строки из файла
std::string read_file(const fs::path& path) {
    std::ifstream file(path);
    std::string content;
    if (file && std::getline(file, content)) {
        // Удаляем символы перевода строки и пробелы в конце
        while (!content.empty() && (content.back() == '\n' || content.back() == '\r' || content.back() == ' ')) {
            content.pop_back();
        }
        return content;
    }
    return "";
}

// Проверка типа корпуса через DMI (SMBIOS)
bool is_laptop_chassis() {
    std::string chassis_str = read_file("/sys/class/dmi/id/chassis_type");
    if (chassis_str.empty()) return false;

    try {
        int chassis = std::stoi(chassis_str);
        // Коды типов корпусов для ноутбуков и портативных устройств по стандарту SMBIOS:
        // 8: Portable, 9: Laptop, 10: Notebook, 11: Hand Held, 14: Sub Notebook, 31: Convertible, 32: Detachable
        switch (chassis) {
            case 8: case 9: case 10: case 11: case 14: case 31: case 32:
                return true;
            default:
                return false;
        }
    } catch (...) {
        return false;
    }
}

// Определение заряда батареи ноутбука (в процентах)
// Возвращает -1, если системная батарея не найдена
int get_battery_percentage() {
    const fs::path power_supply_dir = "/sys/class/power_supply";
    if (!fs::exists(power_supply_dir)) return -1;

    long long total_now = 0;
    long long total_full = 0;
    int count = 0;
    int single_capacity_sum = 0;

    for (const auto& entry : fs::directory_iterator(power_supply_dir)) {
        fs::path dir = entry.path();
        
        std::string type = read_file(dir / "type");
        if (type != "Battery") continue;

        // Исключаем периферийные устройства (мыши, клавиатуры и т.д.)
        std::string scope = read_file(dir / "scope");
        if (scope == "Device") continue;

        // Попытка 1: Считывание готового значения capacity (0-100)
        std::string cap_str = read_file(dir / "capacity");
        if (!cap_str.empty()) {
            try {
                single_capacity_sum += std::stoi(cap_str);
                count++;
                continue;
            } catch (...) {}
        }

        // Попытка 2: Расчет по energy_now / energy_full
        std::string e_now = read_file(dir / "energy_now");
        std::string e_full = read_file(dir / "energy_full");

        // Попытка 3: Расчет по charge_now / charge_full
        if (e_now.empty() || e_full.empty()) {
            e_now = read_file(dir / "charge_now");
            e_full = read_file(dir / "charge_full");
        }

        if (!e_now.empty() && !e_full.empty()) {
            try {
                long long now = std::stoll(e_now);
                long long full = std::stoll(e_full);
                if (full > 0) {
                    total_now += now;
                    total_full += full;
                    count++;
                }
            } catch (...) {}
        }
    }

    if (count == 0) return -1;

    // Если считали готовые проценты
    if (single_capacity_sum > 0 && total_full == 0) {
        return single_capacity_sum / count;
    }

    // Если рассчитывали суммарную емкость (для систем с несколькими аккумуляторами)
    if (total_full > 0) {
        return static_cast<int>(std::round((static_cast<double>(total_now) / total_full) * 100.0));
    }

    return -1;
}

int main() {
    int battery_percentage = get_battery_percentage();

    if (battery_percentage >= 0 || is_laptop_chassis()) {
        if (battery_percentage >= 0) {
            std::cout << battery_percentage << "%" << std::endl;
            return 0;
        }
    }

    std::cout << "computer" << std::endl;
    return 0;
}
