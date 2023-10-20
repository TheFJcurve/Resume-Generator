#!/bin/bash

if [ $# -ne 10 ]; then 
    echo Please pass EXACTLY 10 arguments >&2 
    exit 4
fi

resume_name=$1
font=$2
document_type=$3 
component_template=$4 
component_dir=$5 
output_dir=$6
txt_file=$7 
tex_file=$8
header_file=$9 
component_order=${10}

echo 'Do you wish to copy the header file from any other resume project (Y/N)'

read response

if [ ${response} == 'Y' ] || [ ${response} == 'y' ]; then 
    echo 'Write the name of project to import from'
    
    for directory in ../resumes/*; do
        if [ $(basename ${directory}) == ${resume_name} ]; then
            continue
        fi
        echo $(basename ${directory})
    done

    read response 

    scp ../${response}/${response}-components/${response}-heading.tex ${component_dir}/${resume_name}-heading.tex
    vim ${component_dir}/${resume_name}-heading.tex


    echo ${resume_name}-heading.tex > ${output_dir}/component-order.txt
else
    echo Create the Header File
    scp ${component_template}/heading.tex ${component_dir}/${resume_name}-heading.tex
    vim ${component_dir}/${resume_name}-heading.tex


    echo ${resume_name}-heading.tex > ${output_dir}/component-order.txt
fi

while [ true ]; do 
    echo Select the component you wish to create
    echo '(achievements, certificates, competitions, education, experience, interests, languages, projects, skills, quit)'

    read component_to_add

    if [ ${component_to_add} == 'quit' ] || [ ${component_to_add} == 'q' ]; then
        break
    fi

    if [ ! -f ${component_template}/${component_to_add}.tex ]; then
        echo Please input a valid file name >&2
        exit 5
    fi

    echo Do you wish to copy the ${component_to_add} file from any other resume project '(Y/N)'

    read response

    if [ ${response} == 'Y' ] || [ ${response} == 'y' ]; then 
        echo 'Write the name of project to import from'
        
        for directory in ../*; do
            if [ $(basename ${directory}) == ${resume_name} ]; then
                continue
            fi
            echo $(basename ${directory})
        done

        read response 

        scp ../${response}/${response}-components/${response}-${component_to_add}.tex ${component_dir}/${resume_name}-${component_to_add}.tex
        vim ${component_dir}/${resume_name}-${component_to_add}.tex


        echo ${resume_name}-${component_to_add}.tex >> ${output_dir}/component-order.txt
    else
        echo Create the ${component_to_add} File
        scp ${component_template}/${component_to_add}.tex ${component_dir}/${resume_name}-${component_to_add}.tex
        vim ${component_dir}/${resume_name}-${component_to_add}.tex


        echo ${resume_name}-${component_to_add}.tex >> ${output_dir}/component-order.txt
    fi

done

./resume-wrapper.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
