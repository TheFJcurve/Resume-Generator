#!/bin/bash

if [ $# -ne 3 ]; then 
    echo Please pass EXACTLY 3 arguments >&2 
    exit 3
fi

resume_name=$1
font=$2
document_type=$3

if [ ! -d ../${resume_name} ]; then 
    mkdir ../${resume_name}
fi

component_template=../cv-template
component_dir=../${resume-name}/${resume_name}-components
output_dir=../${resume_name}/${resume_name}-output-files

if [ ! -d ${component_dir} ]; then 
    mkdir ${component_dir}
fi

if [ ! -d ${output_dir} ]; then 
    mkdir ${output_dir}
fi

echo Create the Header File

scp ${component_template}/heading.tex ${component_dir}/${resume_name}-heading.tex
vim ${component_dir}/${resume_name}-heading.tex

while [ true ]; do 
    echo Select the component you wish to create
    echo '(achievements, certificates, competitions, education, experience, interests, languages, projects, skills)'

    read component_to_add

    if [ ! -f ${component_template}/${component_to_add} ]; then
        echo Please input a valid file name >&2
        exit 1
    fi

    scp ${component_template}/${component_to_add}.tex ${component_dir}/${resume_name}-${component_to_add}.tex
    vim ${component_dir}/${resume_name}-${component_to_add}.tex
done

# ./resume-wrapper ${resume_name} ${font} ${document_type}
