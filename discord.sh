#!/bin/bash

update_discord () {
    curl -L "https://discord.com/api/download?platform=linux&format=tar.gz" -o "/tmp/$new_version.tar.gz"
    if [ -d ~/.local/bin/Discord ]; then
        rm -rf ~/.local/bin/Discord
    fi
    if [ ! -d ~/.local/bin ]; then
            mkdir -p ~/.local/bin
    fi
    tar -xf "/tmp/$new_version.tar.gz" -C ~/.local/bin
    rm "/tmp/$new_version.tar.gz"
    echo "$new_version" > ~/.discordv
}

# script starts here
cd ~
if [ -f ~/.discordv ]; then
    installed_version=$(cat ~/.discordv)    
    filename=$(basename "$(curl -s -L -I "https://discord.com/api/download?platform=linux&format=tar.gz" | grep -i "location" | awk '{print $2}' | tr -d '\r')")
    new_version=$(echo "$filename" | grep -oP '(?<=discord-)[0-9.]+')
    
    if [[ "$new_version" > "$installed_version" ]]; then
        notify-send "New version available: $new_version. Installing.."
        update_discord
        cd ~/.local/bin/Discord
        ./Discord --no-sandbox --disable-gpu-sandbox &
        exit 0

    else
        notify-send "No new version available. Lauching Discord..."
        cd ~/.local/bin/Discord
        ./Discord --no-sandbox --disable-gpu-sandbox &
        exit 0
    fi

else
    echo "The ~/.discordv file does not exist. Cannot check for updates."
    if [ ! -d ~/.local/bin/Discord ]; then
    notify-send "Discord not installed. Downloading Discord..."
        filename=$(basename "$(curl -s -L -I "https://discord.com/api/download?platform=linux&format=tar.gz" | grep -i "location" | awk '{print $2}' | tr -d '\r')")
        new_version=$(echo "$filename" | grep -oP '(?<=discord-)[0-9.]+')
        update_discord
        cd ~/.local/bin/Discord
        ./Discord --no-sandbox --disable-gpu-sandbox &
        exit 0
    fi
fi




