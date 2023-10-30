#!/bin/bash

component_order=$1

echo 'Note the numbers before each component, that would be the UNIQUE ID for each component'

original_file_order=""

number=1
while read -r line; do 
    original_file_order+=''${line}' '
    echo ${number} - ${line}; 
    number=$((number + 1))
done < ${component_order}

echo 'Write the order you would like to have IN A LIST WITHOUT COMMAS (example 1 3 4 2)'
read new_order 

new_file_order=""


arr=(${original_file_order})
for i in ${new_order}; do
    index=$((i - 1))
    new_file_order+=''${arr[${index}]}' '
done

rm ${component_order}

for element in ${new_file_order}; do
    echo ${element} >> ${component_order}
done
