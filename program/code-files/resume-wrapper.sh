#!/bin/bash

if [ $# -ne 9 ]; then 
    echo Please pass EXACTLY 9 arguments >&2 
    exit 3
fi

resume_name=$1
font=$2
document_type=$3 
component_dir=$4
output_dir=$5
txt_file=$6
tex_file=$7
header_file=$8 
component_order=$9

if [ ! -d ${component_dir} ] || [ ! -f ${component_dir/*} ]; then
    echo Please create some components before executing the program >&2 
    exit 4
fi

if [ ! -f  ${header_file} ]; then
    echo Please create the header file before executing the program >&2
    exit 5
fi

echo \\documentclass[${font_size}, ${document_type}]{article} > ${tex_file}

cat ${txt_file} | head -n 8 | tail -n 7 >> ${tex_file}

for file in $(cat ${component_order}); do
    echo \\input{$(realpath ${component_dir}/${file})} >> ${tex_file}
done

cat ${txt_file} | tail -n 1 >> ${tex_file}

pdflatex '-output-directory='${output_dir} &> ${output_dir}/output.log ${tex_file} 