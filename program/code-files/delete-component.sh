#!/bin/bash

## ./delete-component.sh (resume-name) (font-size) (document-type)(component-directory) (output-directory) (text-file) 
##                          (.tex-file) (header-file) (component-order)

## Required Arguments: All the arguments are required.

## Run by ./execute.sh when update command is called. Updates one component from ../resumes/resume-name/resume-name-components/

## While running the program and creating the components, on every step you have the option to either create the 
## component from scratch (modify boiler-plate code) or import from any other resume directory that you have 
## already worked on. 

## ERRORS
## exit 12 -> Exactly 9 commands were not passed to ./delete-component.sh
## exit 13 -> The component requested to delete doesn't exist in the component-directory

if [ $# -ne 9 ]; then 
    echo Please pass EXACTLY 9 arguments >&2 
    exit 12
fi

## Defining all the necessary variables
## Defitions for all the following are given in ./execute.sh
resume_name=$1
font=$2
document_type=$3
component_dir=$4 
output_dir=$5
txt_file=$6
tex_file=$7
header_file=$8
component_order=$9

## Choosing which file to edit
echo Which file to delete?

for file in ${component_dir}/*; do
    file_name=$(basename ${file})
    file_name=${file_name//${resume_name}-/}
    echo ${file_name//.tex/}
done

read file_name

file_to_delete=${component_dir}/${resume_name}-${file_name}.tex

if [ ! -f ${file_to_delete} ]; then 
    echo You can only delete a file that exists >&2
    exit 13
fi

## Removing file from component-directory
rm ${file_to_delete}

## Removing the mention of file from component-order text file. This is important, otherwise the program will crash
sed -i "/${file_name}/d" ${component_order}

## Compiling the changes and re-creating the resume pdf.
./resume-wrapper.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}