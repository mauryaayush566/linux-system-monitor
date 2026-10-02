#!/bin/bash

LOG_FILE="monitor.log"

echo "======================================"
echo "       LINUX SYSTEM MONITOR"
echo "======================================"

echo "Date & Time : $(date)"
echo "Hostname   : $(hostname)"
echo "User       : $(whoami)"
echo "Uptime     : $(uptime -p)"

echo ""
echo "----- CPU -----"
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage  : ${CPU}%"

echo ""
echo "----- MEMORY -----"
free -h

echo ""
echo "----- DISK -----"
df -h /

echo ""
echo "----- TOP PROCESSES -----"
ps aux --sort=-%cpu | head -6

echo ""
echo "----- NETWORK -----"
if ping -c 1 google.com > /dev/null 2>&1
then
    echo "Network Status : Connected"
else
    echo "Network Status : Disconnected"
fi

echo ""
echo "======================================"

{
    echo "[$(date)] CPU: ${CPU}% | Uptime: $(uptime -p)"
} >> "$LOG_FILE"
