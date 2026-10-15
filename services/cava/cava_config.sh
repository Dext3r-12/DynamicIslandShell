#!/usr/bin/env fish

# Получаем количество колонок из первого аргумента, по умолчанию 6
set -l num_bars (string match -r '^\d+$' $argv[1]; or echo 6)

cava -p ~/.config/quickshell/services/cava/config | while read -l line
    set -l bars (string split ';' $line)
    
    # Динамически собираем строку вывода в зависимости от заданного числа колонок
    set -l output
    for i in (seq 1 $num_bars)
        set -a output $bars[$i]
    end
    
    echo "$output"
end
