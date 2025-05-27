#!/bin/bash
# System Monitor Script

echo "=== MacBook System Monitor ==="
echo "Running: $(date)"
echo ""

echo "--- TOP CPU PROCESSES ---"
ps -A -o %cpu,command | sort -nr | head -10
echo ""

echo "--- TOP MEMORY PROCESSES ---"
ps -A -o %mem,command | sort -nr | head -10
echo ""

echo "--- DISK USAGE ---"
df -h
echo ""

echo "--- MEMORY USAGE ---"
vm_stat
echo ""

echo "--- SYSTEM UPTIME ---"
uptime
echo ""

echo "=== Monitor Complete ==="
