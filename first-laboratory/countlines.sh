#!/bin/bash

opstring="o:m:"    

help_message="More than one argument, an empty argument or an invalid argument was provided\n
You should pass: \n
1. name_of_the_file.sh -o username_you_want \n
2. name_of_the_file -m month_you_want \n"


while getopts ${opstring} arg; do

    if [ ${#*} -gt 2 ]; then
     echo -e ${help_message}
     exit 1
    fi

    case ${arg} in
        o)
           echo "Looking for files where the owner is: $2"
           filenames=$(find ./* -user $2)
           for file in $filenames; do
            numberOfLines=$(wc -l < ./$file)
            output=$(stat --printf="Name: %n" $file)
            echo "File: $output, Lines: $numberOfLines $file"
           done
            ;;
        m)
           echo "Looking for files where the month is: $2"
           filenames=$(ls -lh | grep $2 | awk '{print $9}')
           for file in $filenames; do
            numberOfLines=$(wc -l < ./$file)
            output=$(stat --printf="Name %n" $file)
            echo "File: $output, Lines: $numberOfLines $file"
           done
           ;;
        ?)
           echo -e ${help_message}
           exit 2
           ;;
     esac
done
