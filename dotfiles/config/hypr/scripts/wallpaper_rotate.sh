#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/background"
INTERVAL=3600

# Ensure hyprpaper is running
if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
    sleep 1
fi

while true; do
    if [ -d "$WALLPAPER_DIR" ]; then
        # Find all images
        PICS=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \)))
        
        if [ ${#PICS[@]} -gt 0 ]; then
            # Select random image
            RANDOM_PIC=${PICS[$RANDOM % ${#PICS[@]}]}
            
            echo "Switching to $RANDOM_PIC"
            
            # Preload the new wallpaper
            hyprctl hyprpaper preload "$RANDOM_PIC"
            
            # Get all monitors
            MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
            
            # Set wallpaper for each monitor
            for mon in $MONITORS; do
                hyprctl hyprpaper wallpaper "$mon,$RANDOM_PIC"
            done
            
            # Unload unused wallpapers to save memory
            hyprctl hyprpaper unload all
        fi
    fi
    
    sleep $INTERVAL
done
