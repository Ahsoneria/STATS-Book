s="db.csv"
echo -e "\nWelcome to STATS-Book\n"
while true; do
    echo "Choices"
    echo "1 -- add info"
    echo "2 -- search"
    echo "3 -- exit"
    echo ""
    printf "choice: "
    read choice
    echo ""
    if [[ $choice == "1" ]]
    then
        ./addinfo.sh "$s"
    elif [[ $choice == "2" ]]
    then
        ./search.sh "$s"
    elif [[ $choice == "3" ]]
    then
        break
    else
        echo -e "invalid choice\n"
    fi
done
