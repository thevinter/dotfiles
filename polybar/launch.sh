#!/usr/bin/env bash
killall -q polybar
echo "---" | tee -a /tmp/polybar1.log 
polybar bottom >> /tmp/polybar1.log 2>&1 &
echo "Launched"

