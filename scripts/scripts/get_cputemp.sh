# #!/bin/sh
#
# TEMP_RAW=$(cat /sys/class/thermal/thermal_zone0/temp)
# # TEMP_CEL=$(expr $TEMP_RAW / 1000)
# TEMP_CEL=$(echo "scale=2;$TEMP_RAW / 1000" | bc)
# TEMP_CEL_W_SIGN=temp=${TEMP_CEL}\'C
#
# # print
# echo $TEMP_CEL_W_SIGN

#!/bin/bash

# 1. get temperature

## a. split response
## Core 0:       +143.6°F  (high = +186.8°F, crit = +212.0°F)
IFS=')' read -ra core_temp_arr <<< $(sensors | grep '^Core\s[[:digit:]]\+:') #echo "${core_temp_arr[0]}"

## b. find cpu usage
total_cpu_temp=0
index=0
for i in "${core_temp_arr[@]}"; do :
    temp=$(echo $i | sed -n 's/°C.*//; s/.*[+-]//; p; q')
    let index++
    total_cpu_temp=$(echo "$total_cpu_temp + $temp" | bc)
done
avg_cpu_temp=$(echo "scale=2; $total_cpu_temp / $index" | bc)

## c. build entry
temp_status="CPU: $avg_cpu_temp C"
echo $temp_status

exit 0
