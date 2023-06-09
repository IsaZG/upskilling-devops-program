#!/bin/bash

countlines(){

opstring="o:m:"    

help_message="More than one argument, an empty argument or an invalid argument was provided\n
You should pass one of this options: \n
1. name_of_the_file.sh -o username_you_want \n
2. name_of_the_file -m month_you_want \n"

#Validate when no arguments are passed
if [ ${#*} -eq 0 ]; then
    echo -e ${help_message}
fi

#Validate when more that 2 arguments are passed
if [ ${#*} -gt 2 ]; then
    echo -e ${help_message}
    exit 1
fi

while getopts ${opstring} arg; do
    case ${arg} in
        o)
           echo "Looking for files where the owner is: $2"
           filenames=$(find . -maxdepth 1 -type f -user $2)
           for file in $filenames; do
            numberOfLines=$(wc -l < ./$file)
            output=$(stat --printf="Name: %n" $file)
            echo "File: $output, Lines: $numberOfLines $file"
           done
           ;;
        m)
           echo "Looking for files where the month is: $2"
           filenames=$(ls -l | grep -v "^d"  | grep $2 | awk '{print $9}')
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

}

#Calling the function and passing all arguments
countlines $@ 
