#!/bin/bash

resume_name=$1
font=$2
document_type=$3
component_dir=$4 
output_dir=$5
txt_file=$6
tex_file=$7
header_file=$8
component_order=$9

echo Which file to delete?

for file in ${component_dir}/*; do
    echo $(basename ${file})
done

read file_name

file_to_delete=${component_dir}/${file_name}

rm ${file_to_delete}

sed -i "/${file_name}/d" ${component_order}

./resume-wrapper.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}