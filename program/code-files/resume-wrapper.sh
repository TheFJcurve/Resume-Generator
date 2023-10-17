#!/bin/bash

if [ $# -ne 3 ]; then 
    echo Please pass EXACTLY 3 arguments >&2 
    exit 3
fi

resume_name=$1
font_size=$2
document_type=$3

component_dir=../${resume_name}/${resume_name}-components
output_dir=../${resume_name}/${resume_name}-output-files

txt_file=resume-template.txt
tex_file=${output_dir}/${resume_name}.tex
header_file=${component_dir}/1-${resume_name}-heading.tex

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

for file in ${component_dir}/*; do
    echo \\input{$(realpath ${file})} >> ${tex_file}
done

cat ${txt_file} | tail -n 1 >> ${tex_file}

pdflatex ${tex_file} -output-directory= ${output_dir} &> ${output_dir}/output.log