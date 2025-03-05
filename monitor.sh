#!/bin/bash

# Source the configuration file
source ./config.sh

# Get system uptime
UPTIME=$(uptime -p)

# Get CPU usage using mpstat
CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $12}')

# Get Memory usage using free
MEMORY_USAGE=$(free | awk '/Mem/ {print $3/$2 * 100.0}')

# Get Disk usage using df
DISK_USAGE=$(df / | awk '/\// {print $5}' | sed 's/%//')

# Get Network usage using sar
NETWORK_USAGE=$(sar -n DEV 1 1 | awk '/Average/ {print $5}')

# Print the results to the log file
echo "$(date) - Uptime: $UPTIME, CPU Usage: $CPU_USAGE%, Memory Usage: $MEMORY_USAGE%, Disk Usage: $DISK_USAGE%, Network Usage: $NETWORK_USAGE" >> $LOG_FILE

# Function to send email alerts
send_alert() {
    local message=$1
    echo "$message" | $MAIL_CMD -s "System Resource Alert" $ALERT_EMAIL
}

# Check if resource usage exceeds the threshold and send alerts
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    send_alert "CPU Usage is too high! Current usage: $CPU_USAGE%"
fi

if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    send_alert "Memory Usage is too high! Current usage: $MEMORY_USAGE%"
fi

if (( $(echo "$DISK_USAGE > $DISK_THRESHOLD" | bc -l) )); then
    send_alert "Disk Usage is too high! Current usage: $DISK_USAGE%"
fi
