#!/usr/bin/env bash
{
    echo "==== $(date) ===="

    echo "[zxtn] OneDrive - Start"
    rclone sync onedrive: /zpool/zxtn/onedrive
    echo "[zxtn] OneDrive - Complete"

    echo "[zxtn] GitHub - Start"
    for d in /zpool/zxtn/github/* ; do (cd "$d" && git remote update); done
    echo "[zxtn] GitHub - Complete"

# Redirect output to log file
} > $HOME/.backup/logs.txt

sudo shutdown -h 10