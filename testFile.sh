virusesFile=$1
countriesFile=$2

#typechecking ints
if [ $3 -lt 0 ]
then
  echo "Invalid num of lines"
  exit
else
  numLines=$3
fi

if [ $4 -lt 0 ]
then
   echo "Invalid num for duplicates"
   exit;
else
  duplicatesAllowed=$4
fi

#creating array with numLines countries
num_countries=0
set countries
while read line; do
  countries[num_countries]=$line
  num_countries=$((num_countries+1))
done < $countriesFile

#creating array with numLines viruses
num_viruses=0
set viruses
while read line;
do
  viruses[num_viruses]=$line
  num_viruses=$((num_viruses+1))
done < $virusesFile

#creating inputFile
touch inputFile.txt

#writing records in inputFile
i=0
while [ $i -lt $numLines ]
do
   # generating random data for an entry

   if [ $duplicatesAllowed == 0 ]
   then # no duplicates
     id=$($i + 1)              # getting ids serially to prevent duplicates
   else # duplicates
      id=$RANDOM        # getting random ids
   fi

    first_name=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1)
    last_name=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1)
    country=${countries[$RANDOM % $num_countries]}
    age=$(($RANDOM % 121))
    virus=${viruses[$RANDOM % $num_viruses]}
    vaccinated=$(($RANDOM % 2))

    #print data in file
    echo "$id $first_name $last_name $country $age $virus $vaccinated" >> inputFile.txt

    i=$(($i + 1))
done

echo "Input file ready"
