#!/bin/bash

file_name='resume-template.tex'
component_dir='cv'
font_size=11px


if [ ! -d ${component_dir} ]; then
    echo Please create some components before executing the function >&2 
    exit 5
fi

echo \\documentclass[${font_size}, letterpaper]{article} > ${file_name}

# ./execute.sh