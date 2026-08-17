#!/bin/bash

cava -p ~/.config/quickshell/scripts/eq_config | while read -r line; do
    
    IFS=';' read -r -a bars <<< "$line"
    echo "${bars[0]} ${bars[1]} ${bars[2]} ${bars[3]} ${bars[4]} ${bars[5]}"
done
