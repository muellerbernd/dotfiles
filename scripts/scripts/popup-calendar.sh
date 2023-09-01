#! /bin/bash

send_notification() {
    TODAY=$(date '+%-d')
    HEAD=$(cal "$1" | head -n1)
    BODY=$(cal "$1" | tail -n7 | sed -z "s|$TODAY|<u><b>$TODAY</b></u>|1")
    WEEK=$(date '+%V')
    FOOT="\n<i>KW:"$WEEK" ~ calendar</i>  "
    dunstify -h string:x-canonical-private-synchronous:calendar \
        "$HEAD" "$BODY$FOOT" -u NORMAL
}

# send_notification() {
#     echo $1 $2
#     TODAY=$(date '+%-d')
#     echo $(cal $1 $2)
#     HEAD=$(cal $1 $2 | head -n1)
#     BODY=$(cal $1 $2 | tail -n7 | sed -z "s|$TODAY|<u><b>$TODAY</b></u>|1")
#     WEEK=$(date '+%V')
#     FOOT="\n<i>KW:"$WEEK" ~ calendar</i>  "
#     dunstify -h string:x-canonical-private-synchronous:calendar \
#         "$HEAD" "$BODY$FOOT" -u NORMAL
# }

handle_action() {
    echo "$DIFF" > "$TMP"
    if [ "$DIFF" -ge 0 ]; then
        send_notification "+$DIFF months"
        # VAR="`echo "$MONTH" | sed 's/^0*//'`"
        # echo "$VAR"
        # echo "$DIFF"
        # NEWMONTH="`expr $VAR + $DIFF`"
        # echo "$NEWMONTH"
        # NEWMONTH="`printf %02d $NEWMONTH`"
        # send_notification $NEWMONTH $YEAR
    else
        send_notification "$((-DIFF)) months ago"
        # VAR="`echo "$MONTH" | sed 's/^0*//'`"
        # echo "$VAR"
        # echo "$DIFF"
        # NEWMONTH="`expr $VAR - $DIFF`"
        # echo "$NEWMONTH"
        # NEWMONTH="`printf %02d $NEWMONTH`"
        # send_notification $NEWMONTH $YEAR
    fi
}

TMP=${XDG_RUNTIME_DIR:-/tmp}/"$UID"_calendar_notification_month
touch "$TMP"

DIFF=$(<"$TMP")
case $1 in
    "curr") DIFF=0;;
    "next") DIFF=$((DIFF+1));;
    "prev") DIFF=$((DIFF-1));;
esac
echo $DIFF
MONTH=$(date '+%m')
YEAR=$(date '+%Y')
echo $YEAR
echo $MONTH
handle_action
