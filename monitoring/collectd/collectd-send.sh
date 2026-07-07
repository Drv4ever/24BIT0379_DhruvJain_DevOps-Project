#!/bin/sh
GRAPHITE_HOST="graphite"
CARBON_PORT=2003
HOSTNAME="docker-host"
INTERVAL=10

while true; do
  TIMESTAMP=$(date +%s)

  CPU_LINE=$(head -1 /host/proc/stat)
  CPU_USER=$(echo "$CPU_LINE" | awk '{print $2}')
  CPU_SYSTEM=$(echo "$CPU_LINE" | awk '{print $4}')

  MEM_TOTAL=$(grep MemTotal /host/proc/meminfo | awk '{print $2}')
  MEM_AVAIL=$(grep MemAvailable /host/proc/meminfo | awk '{print $2}')
  MEM_USED=$((MEM_TOTAL - MEM_AVAIL))
  MEM_FREE=$(grep MemFree /host/proc/meminfo | awk '{print $2}')

  LOAD=$(cat /host/proc/loadavg)
  LOAD1=$(echo "$LOAD" | awk '{print $1}')
  LOAD5=$(echo "$LOAD" | awk '{print $2}')
  LOAD15=$(echo "$LOAD" | awk '{print $3}')

  cat > /tmp/metrics.txt <<EOF
collectd.${HOSTNAME}.cpu.user ${CPU_USER} ${TIMESTAMP}
collectd.${HOSTNAME}.cpu.system ${CPU_SYSTEM} ${TIMESTAMP}
collectd.${HOSTNAME}.memory.total ${MEM_TOTAL} ${TIMESTAMP}
collectd.${HOSTNAME}.memory.used ${MEM_USED} ${TIMESTAMP}
collectd.${HOSTNAME}.memory.free ${MEM_FREE} ${TIMESTAMP}
collectd.${HOSTNAME}.memory.available ${MEM_AVAIL} ${TIMESTAMP}
collectd.${HOSTNAME}.load.shortterm ${LOAD1} ${TIMESTAMP}
collectd.${HOSTNAME}.load.midterm ${LOAD5} ${TIMESTAMP}
collectd.${HOSTNAME}.load.longterm ${LOAD15} ${TIMESTAMP}
EOF

  cat /tmp/metrics.txt | nc -w 5 "$GRAPHITE_HOST" "$CARBON_PORT"
  sleep "$INTERVAL"
done
