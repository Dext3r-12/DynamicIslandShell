#!/usr/bin/env fish

cava -p ~/.config/quickshell/services/cava/config | while read -l line
    set -l bars (string split ';' $line)
    echo "$bars[1] $bars[2] $bars[3] $bars[4] $bars[5] $bars[6]"
end
