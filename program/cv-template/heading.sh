#!/bin/bash

echo '%-------------------------------------------------------------------------------'
echo '%	HEADING'
echo '%-------------------------------------------------------------------------------'

echo '\begin{center}'
echo    '\textbf{\Huge \scshape' {$1} '} \\ \vspace{3pt} % Your Name'
shift
echo        '\small'
echo    '\faMobile \hspace{.5pt} \href{tel:' {$1} '}{' {$1} '} % Your Mobile Number'
shift
echo        '$|$'
echo    '\faAt \hspace{.5pt} \href{mailto:' {$1} '}{' {$1} '} % Your Mail'
shift
echo        '$|$'
echo    '\faLinkedinSquare \hspace{.5pt} \href{' {$1} '}{LinkedIn} % Your LinkedIn'
shift
echo        '$|$'
echo    '\faGithub \hspace{.5pt} \href{' {$1} '}{GitHub} % Your GitHub'
shift
echo        '$|$'
echo     '\faGlobe \hspace{.5pt} \href{' {$1} '}{Portfolio} % Your Portfolio Website'
shift
echo '\end{center}'
echo '%-------------------------------------------------------------------------------'
