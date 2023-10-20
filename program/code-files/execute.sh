#!/bin/bash

if [ $# -lt 2 ]; then 
    echo Please pass ATLEAST 2 arguments >&2 
    exit 1
fi

operation=$1
resume_name=$2

if [ $# -lt 4 ]; then
    document_type=letterpaper
    if [ $# -lt 3 ]; then 
        font=11pt
    else
        font=$3
    fi
else
    document_type=$4
fi

component_template=../cv-template
resume_dir=../resumes/${resume_name}
component_dir=${resume_dir}/${resume_name}-components
output_dir=${resume_dir}/${resume_name}-output-files
txt_file=resume-template.txt
tex_file=${output_dir}/${resume_name}.tex
header_file=${component_dir}/${resume_name}-heading.tex
component_order=${output_dir}/component-order.txt

if [ ${operation} == "create" ]; then
    if [ ! -d ${resume_dir} ]; then 
        mkdir ${resume_dir}
    fi

    if [ ! -d ${component_dir} ]; then 
        mkdir ${component_dir}
    fi

    if [ ! -d ${output_dir} ]; then 
        mkdir ${output_dir}
    fi

    ./create-component.sh ${resume_name} ${font} ${document_type} ${component_template} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
elif [ ${operation} == "update" ]; then
    if [ ! -d ${resume_dir} ]; then 
        echo Enter a Resume Directory that already exists
        exit 2
    fi

    ./update-component.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
elif [ ${operation} == "delete" ]; then
    if [ ! -d ${resume_dir} ]; then 
        echo Enter a Resume Directory that already exists
        exit 2
    fi
    
    ./delete-component.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
elif [ ${operation} == "drop_resume" ]; then
    if [ ! -d ${resume_dir} ]; then 
        echo Enter a Resume Directory that already exists
        exit 2
    fi

    echo Are you sure you wish to delete this folder '(Y/N)'?
    read response
    if [ ${response} == 'y' ] || [ ${response} == 'Y' ]; then
        rm -r ${resume_dir}
    fi 

else 
    echo Enter a valid operation
    exit 3
fi