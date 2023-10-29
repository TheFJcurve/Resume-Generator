#!/bin/bash

## ./execute.sh (one of create, update, delete, drop_table) (resume-name) (font-size) (document-type)

## Required Arguments: Operation & ResumeName
## Optional Arguments: FontSize & DocumentType 

## Initial executable file that runs all the other programs. It initializes all the commands that 
## other programs will need, and calls other functions as is fit for the situation.

## The operations it can run are as follows:
## CREATE 
## UPDATE
## DELETE
## DROP_RESUME

## ERRORS
## exit 1 -> Less than 2 arguments provided to ./execute.sh
## exit 2 -> Update or Delete or Drop_resume was called with a resume name that does not exist
## exit 3 -> Invalid operation provided.

## SIDE EFFECTS
## None if no errors occur for create, update or delete.
## If drop_resume is called, then a text output followed by an input field will ask for confirmation
## Otherwise, side effects will occur due to errors.

if [ $# -lt 2 ]; then 
    echo Please pass ATLEAST 2 arguments >&2 
    exit 1
fi

operation=$1
resume_name=$2

## Giving defauly values to font_size and letterpaper
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

## Initializing all important variables

## Variables are defined as follows:

## component_template -> folder containing boiler-plate LaTeX code for every resume component
## resume_dir -> a subfolder in ../resumes/ folder, which will store all the output of resume-name
## component_dir -> not the same as template, this is the subfolder in resume_dir that has the 
##      components of that particular resume, with all the edits
## output_dir -> subfolder in resume_dir that has all the output files, including the resume pdf file
## txt_file -> resume-template.txt file in the current folder, it contains a boiler-plate LaTeX code
##      which will be copied to compile the whole resume
## tex_file -> LaTeX file in output_dir that will generate the resume pdf
## header_file -> Heading file from the component_dir, it is treated differently as it is required
##      and always comes before any other component
## component_order -> a text file in output_dir that lists the order in which each component must
##      be compiled.

component_template=../cv-template
resume_dir=../resumes/${resume_name}
component_dir=${resume_dir}/${resume_name}-components
output_dir=${resume_dir}/${resume_name}-output-files
txt_file=resume-template.txt
tex_file=${output_dir}/${resume_name}.tex
header_file=${component_dir}/${resume_name}-heading.tex
component_order=${output_dir}/component-order.txt

## If create is called then resume-directory and component-directory and outout-directory is created if it is not already present. 
## It then calls ./create-component.sh
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

## If update is called, if resume-drectory already exists, then ./update-component.sh is called.
elif [ ${operation} == "update" ]; then
    if [ ! -d ${resume_dir} ]; then 
        echo Enter a Resume Directory that already exists
        exit 2
    fi

    ./update-component.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}

## If delete is called, if resume-drectory already exists, then ./delete-component.sh is called.
elif [ ${operation} == "delete" ]; then
    if [ ! -d ${resume_dir} ]; then 
        echo Enter a Resume Directory that already exists
        exit 2
    fi
    
    ./delete-component.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}

## If drop_resume is called, if resume-drectory already exists, then the resume directory is recursively deleted.
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