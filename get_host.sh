#!/usr/bin/env bash

host=$(hostname)
case $host in
    "ammerapad")
        host="t480"
        ;;
    "ilmpad")
        host="t480"
        ;;
    *)
        ;;
esac
echo $host
