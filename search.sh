s="$1"
printf "Name or Team: "
read name
echo ""
echo "Search results:"
count="$(grep -i -c $name "$s")"
if [[ $count == "0" ]]
then
    echo -e "\nNo such entry exists"
    echo -e ""
else
    while IFS='\n' read lines; do
        IFS=',' read -ra a <<< "$lines" # a is array created by taking ',' as separator
        y1=( ${a[1]} )
        y2=( ${a[2]} )
        printf "Name: $a, Team: $y1, Avg: $y2\n"
    done <<< "$(grep -i $name "$s")" #note here <<< used for read to take input as string
    if [[ $count == "1" ]]
    then
        echo -e "\nChoices"
        echo "a -- Remove entry"
        echo "b -- Edit entry"
        echo "c -- don't remove or edit"
        echo ""
        printf "choice: "
        read ans
        echo ""
        if [[ $ans == "a" ]]
        then
            lines2="$(grep -i -v $name "$s")"
            echo "$lines2" > "$s"
        elif [[ $ans == "b" ]]
        then
            echo "New information: "
            printf "Name: "
            read name2
            printf "Team: "
            read team2
            printf "Batting Avg: "
            read avg2
            echo ""
            lines2="$(grep -i -v $name "$s")"
            echo "$lines2" > "$s"
            echo "$name2,$team2,$avg2" >> "$s"
        fi
    else
        echo -e "\nMultiple such entries exists, do you want to remove any specific entries? please select from the choices"
        echo -e ""
        echo "Choices"
        echo "a -- Remove All"
        echo "b -- Remove/Edit a specfic entry"
        echo "c -- Remove None"
        echo ""
        printf "choice: "
        read mul
        echo ""
        if [[ $mul == "a" ]]
        then
            lines3="$(grep -i -v $name "$s")"
            echo "$lines3" > "$s"
        elif [[ $mul == "b" ]]
        then
            echo "please state more specific information about the entry to be removed"
            ./search.sh "$s"
        fi
    fi
fi
