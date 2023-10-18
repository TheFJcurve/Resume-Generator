#!/bin/bash

if [ $# -ne 3 ]; then 
    echo Please pass EXACTLY 3 arguments >&2 
    exit 1
fi

resume_name=$1
font=$2
document_type=$3

component_template=../cv-template
component_dir=../${resume_name}/${resume_name}-components
output_dir=../${resume_name}/${resume_name}-output-files

txt_file=resume-template.txt
tex_file=${output_dir}/${resume_name}.tex
header_file=${component_dir}/${resume_name}-heading.tex
component_order=${output_dir}/component-order.txt

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