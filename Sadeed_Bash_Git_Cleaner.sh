#!/bin/bash

# By Abdullah As-Sadeed

terminal_ansi_color_green="\033[0;32m"
terminal_ansi_color_reset="\033[0m"

# Get the target directory from CLI argument or use the current directory
target_dir=${1:-"."}

cd "$target_dir" || exit 1

count=0

for dir in */; do
    if [ -d "$dir/.git" ]; then
        echo -e "${terminal_ansi_color_green}Running Git commands in repository: $dir${terminal_ansi_color_reset}"
        (cd "$dir" && git remote prune origin && git repack && git prune-packed && git reflog expire --expire=1.day.ago && git gc --aggressive)
        echo -e "\n\n"
        ((count++))
    fi
done

echo "Git commands have been executed in $count repositories."
