#!/bin/bash

opstring=":om"


while getopts ${opstring} arg; do
    case ${arg} in
        o)
          # Verificar que los files le pertenezcan a ese owner, hacer lo mismo para month
          # Validar argumentos incorrectos
          filenames=$(ls ./*)
           for file in $filenames; do
            numberOfLines=$(wc -l < ./$file)
            output=$(stat --printf="Name: %n" $file)
           echo "File: $output, Lines: $numberOfLines $file"
           done
            ;;
        m)
            echo "Option m was choosen"
            ;;
        :)
            echo "$0: Must supply ang argument tp -$OPTARG." >&2
            exit 1
            ;;
        ?)
            echo "Invalid option: -${OPTARG}."
            exit 2
            ;;
     esac
done


#filenames=$(ls ./*)


#for file in $filenames; do
#   numberOfLines=$(wc -l < ./$file)
#    echo "$file has $numberOfLines lines"
#done



