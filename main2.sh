wget -N -q http://static.cricinfo.com/rss/livescores.xml
s="$1"
l2=' '
while true
do
    while IFS= read -r line; do
        if [[ $line == *$s* ]] && [[ $line == *title* ]]
        then
            line=${line//"<title>"/}
            line=${line//"&amp;"/&}
            line=${line//"</title>"/}
            if [[ $l2 != "$line" ]]
            then
                echo "$line"
                notify-send "$line"
                l2="$line"
            fi
        fi
    done < livescores.xml
    sleep 10s
    wget -N -q http://static.cricinfo.com/rss/livescores.xml
done
