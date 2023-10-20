#!/bin/bash

if [ $# -ne 4 ]; then 
    echo Please pass EXACTLY 4 arguments >&2 
    exit 1
fi

operation=$1
resume_name=$2
font=$3
document_type=$4

component_template=../cv-template
component_dir=../${resume_name}/${resume_name}-components
output_dir=../${resume_name}/${resume_name}-output-files
txt_file=resume-template.txt
tex_file=${output_dir}/${resume_name}.tex
header_file=${component_dir}/${resume_name}-heading.tex
component_order=${output_dir}/component-order.txt

if [ ${operation} == "create" ]; then
    if [ ! -d ../${resume_name} ]; then 
        mkdir ../${resume_name}
    fi

    if [ ! -d ${component_dir} ]; then 
        mkdir ${component_dir}
    fi

    if [ ! -d ${output_dir} ]; then 
        mkdir ${output_dir}
    else
        rm ${output_dir}/component-order.txt
    fi

    ./create-component.sh ${resume_name} ${font} ${document_type} ${component_template} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
elif [ ${operation} == "update" ]; then
    ./update-component.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
elif [ ${operation} == "delete" ]; then
    ./delete-component.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
else 
    echo Enter a valid operation
    exit 2
fi