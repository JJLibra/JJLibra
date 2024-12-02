#!/bin/bash

INTERNAL_IP="192.168.13.142"
SLEEP_INTERVAL=600  # 10 分钟
SECOCLIENT_PATH="/usr/local/SecoClient/SecoClient"
CONNECTION_NAME="school-pppoe"
LOG_FILE="$HOME/check_vpn_connection.log"

restart_network() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - 正在重启网络连接: $CONNECTION_NAME" | tee -a "$LOG_FILE"

    nmcli connection down "$CONNECTION_NAME"
    sleep 5
    nmcli connection up "$CONNECTION_NAME"

    if [ $? -eq 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 网络连接 $CONNECTION_NAME 已成功重启" | tee -a "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 网络连接 $CONNECTION_NAME 重启失败" | tee -a "$LOG_FILE"
    fi
}

restart_seco_client() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - VPN 连接断开，正在重启 SecoClient" | tee -a "$LOG_FILE"

    restart_network
    sudo killall -I 'SecoClient' 2>/dev/null
    sleep 2
    "$SECOCLIENT_PATH" &

    if [ $? -eq 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - SecoClient 已成功重启" | tee -a "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 重启 SecoClient 失败" | tee -a "$LOG_FILE"
    fi
}

restart_at_night() {
    CURRENT_HOUR=$(date '+%H')
    if [ "$CURRENT_HOUR" -eq 02 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 正在进行每日重启操作" | tee -a "$LOG_FILE"
        restart_seco_client
    fi
}

while true; do
    CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

    if ping -c 4 -W 1 "$INTERNAL_IP" > /dev/null 2>&1; then
        echo "$CURRENT_TIME - VPN 连接正常" | tee -a "$LOG_FILE"
    else
        restart_seco_client
    fi

    restart_at_night

    sleep "$SLEEP_INTERVAL"
done
