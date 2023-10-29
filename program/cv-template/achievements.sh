#!/bin/bash

count=$1
shift

echo '%-------------------------------------------------------------------------------'
echo '%	ACHIEVEMENTS'
echo '%-------------------------------------------------------------------------------'    

echo '\textbf{Achievement}'

echo '\par\noindent\rule{\textwidth}{0.2pt} % This is the horizontal line' 

echo '\begin{itemize}'

for ((i=1; i<=${count}; i++)); do
    echo '\item {' {$1} '\\ % Achievement Title'
    shift
    echo {$1} '\hfill % Achievement Location'
    shift
    echo {$1} '\\ % Achievement Year'
    shift 
    echo {$1} '} % Description of the Achievement'
    shift
done

echo '\end{itemize}'

echo '%-------------------------------------------------------------------------------'