#!/bin/bash

resume_name=$1 
component_template=$2
variable_dir=$3
component_dir=$4 
component_to_add=$5

command_list=()

DONE=false
until $DONE ;do
    read || DONE=true
    command_list+=(${REPLY})
done

./${component_template}/${component_to_add}.sh ${command_list} > ${component_dir}/${resume_name}-${component_to_add}.tex
