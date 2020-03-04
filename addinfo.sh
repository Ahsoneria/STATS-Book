s="$1"
echo "New Entry to be Added"
printf "Name: "
read name
printf "Team: "
read team
printf "Batting Avg: "
read avg
echo ""
count="$(grep -i -c $name "$s")"
if [[ $count == "1" ]]
then
    echo "Name already exists, what would you like to do?"
    echo ""
    echo "Choices"
    echo "a -- Replace it"
    echo "b -- Add anyways"
    echo "c -- don't add or replace"
    echo ""
    printf "choice: "
    read ans
    echo ""
    if [[ $ans == "a" ]]
    then
        lines="$(grep -i -v $name "$s")"
        echo "$lines" > "$s"
        echo "$name,$team,$avg" >> "$s"
    elif [[ $ans == "b" ]]
    then
        echo "$name,$team,$avg" >> "$s"
    fi
elif [[ $count == "0" ]]
then
    echo "$name,$team,$avg" >> "$s"
else
    echo -e "\nMultiple such entries exists, do you want to remove any specific entries? please select from the choices\n"
    echo "Choices"
    echo "a -- Replace All"
    echo "b -- Replace a specfic entry"
    echo "c -- Don't Replace any and don't add"
    echo "d -- Add anyways"
    echo ""
    printf "choice: "
    read mul
    echo ""
    if [[ $mul == "a" ]]
    then
        lines3="$(grep -i -v $name "$s")"
        echo "$lines3" > "$s"
        echo "$name,$team,$avg" >> "$s"
    elif [[ $ans == "d" ]]
    then
        echo "$name,$team,$avg" >> "$s"
    elif [[ $mul == "b" ]]
    then
        echo "$name,$team,$avg" >> "$s"
        echo -e "\nplease try searching by stating more specific information about the entry to be removed\n"
        ./search.sh "$s"
    fi
fi
