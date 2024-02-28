#!/usr/bin/env bash

subnet=$1
ips=$(ip -4 -o addr show scope global | awk '{gsub(/\/.*/,"",$4); print $4}')
is_in=false
for ip in $ips; do
    output_grepcidr=$(grepcidr "$subnet" <(echo "$ip"))
    if [[ "$output_grepcidr" = "$ip" ]]; then
        is_in=true
    fi
done

[ "$is_in" = true ]
