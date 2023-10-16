#!/bin/bash

if [ $# -ne 3 ]; then 
    echo Please pass EXACTLY 3 arguments >&2 
    exit 3
fi

resume_name=$1
font=$2
document_type=$3

component_template=../cv-template
component_dir=../${resume_name}-components
output_dir=../${resume_name}-output-files

if [ ! -d ${component_dir} ]; then 
    mkdir ${component_dir}
fi

if [ ! -d ${output_dir} ]; then 
    mkdir ${output_dir}
fi

echo Create the Header File

scp ${component_template}/heading.tex ${component_dir}/${resume_name}-heading.tex

vim ${component_dir}/${resume_name}-heading.tex

# ./resume-wrapper ${resume_name} ${font} ${document_type}
