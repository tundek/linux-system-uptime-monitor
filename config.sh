# Configuration file for Linux System Uptime and Resource Usage Tracker

# Email settings for alerts
ALERT_EMAIL="your_email@example.com"
MAIL_CMD="/usr/bin/mail"  # Command to send email alerts, might vary based on your system

# Thresholds for resource usage (in percentage)
CPU_THRESHOLD=85        # Alert if CPU usage exceeds 85%
MEMORY_THRESHOLD=80     # Alert if memory usage exceeds 80%
DISK_THRESHOLD=90       # Alert if disk usage exceeds 90%

# Log file paths
LOG_FILE="/var/log/system_usage.log"
