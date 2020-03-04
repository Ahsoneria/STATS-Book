wget -N -q http://www.espncricinfo.com/india/content/player/country.html?country=6
grep -i "/india/content/player/" "country.html?country=6" > file.csv
grep -i "td" "file.csv" > file2.csv
sed -i 's/<td class="divider"><a href="\/india\/content\/player\///g' file2.csv
sed -i 's/<td><a href="\/india\/content\/player\///g' file2.csv
sed -i 's/">/,/g' file2.csv
sed -i 's/<\/a><\/td>//g' file2.csv
sed -i '1,60d' file2.csv
head -n 30 file2.csv > file.csv
sed -i 's/<\/a> <\/td>//g' file.csv
tr -s '[:blank:]' ',' <file.csv> file2.csv
printf "" > db.csv
while  IFS='\n' read lines; do
    IFS=',' read -ra a <<< "$lines" # a is array created by taking ',' as separator
    y1=( ${a[1]} )
    y2=( ${a[2]} )
    y3=( ${a[3]} )
    wget -N -q http://www.espncricinfo.com/india/content/player/"$y1"
    grep -A10 -m1 -e '<b>ODIs</b>' $y1 > file6.csv
    sed -i '1,6d' file6.csv
    head -n 1 file6.csv > file5.csv
    tr -s '[:blank:]' ',' <file5.csv> file6.csv
    sed -i 's/,<td,nowrap="nowrap">//g' file6.csv
    sed -i 's/,<td,class="padDp2",nowrap="nowrap">//g' file6.csv
    sed -i 's/<\/td>//g' file6.csv
    read var < file6.csv
    #echo $var
    echo "$y2 $y3,India,$var" >> db.csv
    rm $y1
done < file2.csv
rm "country.html?country=6"
rm file2.csv
rm file.csv
rm file5.csv
rm file6.csv