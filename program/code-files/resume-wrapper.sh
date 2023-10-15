#!/bin/bash

component_dir='cv'
output_dir='output-files'
file_name='software-developer-resume'
header_file='heading.tex'
font_size=9pt
document_type='letterpaper'

txt_file=${file_name}.txt
tex_file=../${output_dir}/${file_name}.tex

if [ ! -d ../${component_dir} ]; then
    echo Please create some components before executing the program >&2 
    exit 4
fi

if [ ! -f ../${component_dir}/${header_file} ]; then
    echo Please create the header file before executing the program >&2
    exit 5
fi

echo \\documentclass[${font_size}, ${document_type}]{article} > ${tex_file}

cat ${txt_file} | head -n 8 | tail -n 7 >> ${tex_file}

echo \\input{../${component_dir}/${header_file}} >> ${tex_file}

for file in ../${component_dir}/*; do
    if [ ${file} != ../${component_dir}/${header_file} ]; then
        echo \\input{${file}} >> ${tex_file}
    fi
done

cat ${txt_file} | tail -n 1 >> ${tex_file}

pdflatex ../${output_dir}/${resume_name}.tex > .