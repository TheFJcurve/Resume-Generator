#!/bin/bash

## ./create-component.sh (resume-name) (font-size) (document-type) (component-template-directory) (component-directory) 
##                       (output-directory) (text-file) (.tex-file) (header-file) (component-order)

## Required Arguments: All the arguments are required.

## Run by ./execute.sh when create command is called. Creates the resume-name folder in ../resumes/, and 
## creates its components in component-directory. Lists the order of the components in component-order, 
## and creates .tex-file both in the output-directory. In the end, calls ./resume-wrapper.sh to 
## compile the LaTeX code and create the pdf.

## While running the program and creating the components, on every step you have the option to either create the 
## component from scratch (modify boiler-plate code) or import from any other resume directory that you have 
## already worked on. 

## ERRORS
## exit 4 -> Exactly 10 were not passed to ./create-component.sh
## exit 5 -> Invalid directory name provided to input_file function response
## exit 6 -> Invalid component name provided to add to file

if [ $# -ne 10 ]; then 
    echo Please pass EXACTLY 10 arguments >&2 
    exit 4
fi

## Defining all the necessary variables
## Definitions are given in ./execute.sh file.
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

## Defining Functions

## create_file() takes an argument component_to_add, copies that from the component-template and gives it for the user to 
## edit on their own.

## SIDE EFFECTS: 
##      Prints on the screen
##      Copies and pastes files from another directory 
##      Opens file for the user to edit on a text editor
##      May modify component-order.txt

## create_file(): string -> void
create_file () {
    component_to_add=$1

    echo Create the ${component_to_add} File

    scp ${component_template}/${component_to_add}.tex ${component_dir}/${resume_name}-${component_to_add}.tex
    vim ${component_dir}/${resume_name}-${component_to_add}.tex

    echo ${resume_name}-${component_to_add}.tex >> ${component_order}
}

## input_file() takes an argument component_to_add, copies that from another existing resume project and gives the user
## the ability to edit that file. In case the file doesn't exist in other resume projects, it calls create_file() function

## SIDE EFFECTS:
##      Prints on the screen
##      Copies and pastes files from another directory 
##      Opens file for the user to edit on a text editor
##      May modify component-order.txt

## input_file(): string -> void
input_file () {
    component_to_add=$1

    echo 'Write the name of resume to import from'
        
    for directory in ../resumes/*; do
        if [ $(basename ${directory}) == ${resume_name} ]; then
            continue
        elif [ -f ${directory}/$(basename ${directory})-components/$(basename ${directory})-${component_to_add}.tex ]; then
            echo $(basename ${directory})
        fi
    done

    read response 

    if [ ${response} == 'q' ] || [ ${response} == 'quit' ]; then 
        create_file ${component_to_add}
    elif [ ! -d ../resumes/${response} ]; then 
        echo Enter a valid directory
        exit 5
    else
        scp ../resumes/${response}/${response}-components/${response}-${component_to_add}.tex ${component_dir}/${resume_name}-${component_to_add}.tex
        vim ${component_dir}/${resume_name}-${component_to_add}.tex

        echo ${resume_name}-${component_to_add}.tex >> ${component_order}   
    fi
}

## input_or_create_file() takes an argument component_to_add and calls either input_file() or create_file() based on the situation.

## SIDE EFFECTS:
##      Prints on the screen
##      Takes input from the user
##      Calls other functions

## input_or_create_file(): string -> void
import_or_create_file () {
    component_to_add=$1

    echo Do you wish to copy the ${component_to_add} file from any other resume project '(Y/N)'
    read response

    if [ ${response} == 'Y' ] || [ ${response} == 'y' ]; then 
        input_file ${component_to_add}
    else
        create_file ${component_to_add}
    fi
}

## Creating the header file for the project. 
## Giving the option to import the file from other project. It reads the response, prints all the options, 
## reads the response again and executes as the user prefers.
if [ -f ${component_order} ];then 
    rm ${component_order}
fi
import_or_create_file heading

## While the user wants to add a component, that component is either imported or created here.
while [ true ]; do 
    echo Select the component you wish to create
    echo '(achievements, certificates, competitions, education, experience, interests, languages, projects, skills, quit)'

    read component_to_add

    if [ ${component_to_add} == 'quit' ] || [ ${component_to_add} == 'q' ]; then
        break
    fi

    if [ ! -f ${component_template}/${component_to_add}.tex ]; then
        echo Please input a valid file name >&2
        exit 6
    fi

    import_or_create_file ${component_to_add}

done

## Calls the wrapper function that will generate the pdf
./resume-wrapper.sh ${resume_name} ${font} ${document_type} ${component_dir} ${output_dir} ${txt_file} ${tex_file} ${header_file} ${component_order}
