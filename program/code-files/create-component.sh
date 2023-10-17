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
component_dir=../${resume_name}/${resume_name}-components
output_dir=../${resume_name}/${resume_name}-output-files

if [ ! -d ${component_dir} ]; then 
    mkdir ${component_dir}
fi

if [ ! -d ${output_dir} ]; then 
    mkdir ${output_dir}
fi

echo 'Do you wish to copy the header file from any other resume project (Y/N)'

read response

if [ ${response} == 'Y' ] || [ ${response} == 'y' ]; then 
    echo 'Write the name of project to import from'
    
    for directory in ../*; do
        if [ ${directory} == '../code-files' ] || [ ${directory} == '../cv-template' ] || [ ${directory} == ../${resume_name} ]; then
            continue
        fi
        echo ${directory}
    done

    read response 

    scp ../${response}/${response}-components/1-${response}-heading.tex ${component_dir}/1-${resume_name}-heading.tex
    vim ${component_dir}/1-${resume_name}-heading.tex
else
    echo Create the Header File
    scp ${component_template}/heading.tex ${component_dir}/1-${resume_name}-heading.tex
    vim ${component_dir}/1-${resume_name}-heading.tex
fi

index=2

while [ true ]; do 
    echo Select the component you wish to create
    echo '(achievements, certificates, competitions, education, experience, interests, languages, projects, skills, quit)'

    read component_to_add

    if [ ${component_to_add} == 'quit' ] || [ ${component_to_add} == 'q' ]; then
        break
    fi

    if [ ! -f ${component_template}/${component_to_add}.tex ]; then
        echo Please input a valid file name >&2
        exit 1
    fi

    scp ${component_template}/${component_to_add}.tex ${component_dir}/${index}-${resume_name}-${component_to_add}.tex
    vim ${component_dir}/${index}-${resume_name}-${component_to_add}.tex

    index=$((index + 1))
done

./resume-wrapper.sh ${resume_name} ${font} ${document_type}
