#!/bin/bash

## ./create-component.sh (resume-name) (font-size) (document-type) (component-directory) (output-directory) 
##                          (text-file) (.tex-file) (header-file) (component-order)

## Required Arguments: All of the operations are required.

## Given a resume-name with all its components fully formed/edited/deleted, it takes the tex file and compiles
## it to form the final pdf that you would wish to have. The location of PDF will be 
## ../resumes/resume-name/resume-name-output-files/resume-name.pdf

## ERRORS
## exit 7 -> Exactly 9 commands were not passed to ./resume-wrapper.sh command
## exit 8 -> No components exist in the resume project when ./resume-wrapper.sh was executed
## exit 9 -> Header file does not exist in the resume project.

## SIDE EFFECTS
## None if no errors occur for create, update or delete.
## If drop_resume is called, then a text output followed by an input field will ask for confirmation
## Otherwise, side effects will occur due to errors.

if [ $# -ne 9 ]; then 
    echo Please pass EXACTLY 9 arguments >&2 
    exit 7
fi

## Defining all the necessary variables
## Definition for all the following are given in ./execute.sh
resume_name=$1
font=$2
document_type=$3 
component_dir=$4
output_dir=$5
txt_file=$6
tex_file=$7
header_file=$8 
component_order=$9

## Check for components
if [ ! -d ${component_dir} ] || [ ! -f ${component_dir/*} ]; then
    echo Please create some components before executing the program >&2 
    exit 8
fi

## Check for Header
if [ ! -f  ${header_file} ]; then
    echo Please create the header file before executing the program >&2
    exit 9
fi

## Write LaTeX code in the final .tex-file
echo \\documentclass[${font_size}, ${document_type}]{article} > ${tex_file}

cat ${txt_file} | head -n 8 | tail -n 7 >> ${tex_file}

## Adding all the component files according to the order in component-order text file
for file in $(cat ${component_order}); do
    echo \\input{$(realpath ${component_dir}/${file})} >> ${tex_file}
done

cat ${txt_file} | tail -n 1 >> ${tex_file}

## Generating the pdf, and directing all the output to output-directory
pdflatex '-output-directory='${output_dir} &> ${output_dir}/output.log ${tex_file} 