#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTFILE="ir_snapshot_$TIMESTAMP.txt"

echo "Incident Response Snapshot - $TIMESTAMP" > "$OUTFILE"
echo "=======================================" >> "$OUTFILE"

echo -e "\n[System Info]" >> "$OUTFILE"
uname -a >> "$OUTFILE"

echo -e "\n[Logged in users]" >> "$OUTFILE"
who >> "$OUTFILE"

echo -e "\n[Network connections]" >> "$OUTFILE"
netstat -tunapl 2>/dev/null | head -50 >> "$OUTFILE"

echo -e "\n[Running processes]" >> "$OUTFILE"
ps aux | head -50 >> "$OUTFILE"

echo -e "\n[Open listening ports]" >> "$OUTFILE"
ss -tuln 2>/dev/null >> "$OUTFILE"

echo -e "\n[Last 20 auth log entries]" >> "$OUTFILE"
if [ -f /var/log/auth.log ]; then
    tail -n 20 /var/log/auth.log >> "$OUTFILE"
fi

echo "Snapshot saved to $OUTFILE"
