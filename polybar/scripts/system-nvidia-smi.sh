#!/usr/bin/env sh

if [ -f '/usr/bin/nvidia-smi' ]; then
    nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F "\"*,\"*" '{ print "GPU",""$1"", "%", ""$2"", "°C"}'
else
    echo "No Nvidia"
fi