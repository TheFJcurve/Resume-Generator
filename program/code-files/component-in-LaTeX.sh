#!/bin/bash

achievements() {
    echo 'Competition Name: '
    read competition
    echo 'Location: '
    read location
    echo 'Year: '
    read year
    echo 'Description: '
    read description
    
    
    output='\\textbf{Achievement} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{itemize} \n
                \\item {'${competition}' \\\ \n
                        '${location}' \\hfill '${year}' \\\ \n 
                        '${description}'} \n
            \\end{itemize}'
}

certificates() {
    echo 'Certificate Name: '
    read name
    echo 'Issuing Authority: '
    read auth
    echo 'Year: '
    read year
    echo 'Brief Description: '
    read desc

    output='\\textbf{Certificates} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n


            \\begin{enumerate} \n
                \\item  {'${name}' \\\ \n
                        '${auth}' \\hfill '${year}' \\\ \n
                        '${desc}'}\n
            \\end{enumerate}'
}

competitions() {
    echo 'Competition Name: '
    read name
    echo 'Position: '
    read position
    echo 'A Brief Description: '
    read desc

    output='\\textbf{Competitions} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{enumerate} \n
            \\item {'${name}' | '${position}' \\\ \n
                '${desc}'} \n
            \\end{enumerate}'
}

education() {
    echo 'University Name: '
    read name
    echo 'Graduation Year: '
    read grad
    echo 'Program: '
    read program
    echo 'Relavent Courses List: '
    read relcourses


    output='\\textbf{Education} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n


            \\textbf{'${name}'} \\hfill {'${grad}'} \\\ \n
            '${program}' \\\ \n
            {Relavent Courses} - {'${relcourses}'} \\\'
}

experience() {
    echo 'Company Name: '
    read name 
    echo 'Position: '
    read position
    echo 'Location: '
    read location 
    echo 'Start Date: '
    read sdate
    echo 'End Date: '
    read edate
    echo 'Job Description: '
    read desc

    output='\\textbf{Experience} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            {\\textbf{'${name}'}, \\textnormal{\\textit{'${position}'} | '${location}'}} \\hfill {'${sdate}' - '${edate}'} \n
            {\\begin{itemize} \n
                    \\item {'${desc}'} \n
                \\end{itemize}}'
}

heading() {
    echo 'Name: '
    read name
    echo 'Phone: '
    read phone
    echo 'Mail: '
    read mail 
    echo 'LinkedIn Url: '
    read linkedin
    echo 'GitHub Url: '
    read github
    echo 'Personal Portfolio Url: '
    read website

    output='\\begin{center} \n
                \\textbf{\\Huge \\scshape '${name}'} \\\ \\vspace{3pt}  \n
                    \\small \n
                \\faMobile \\hspace{.5pt} \\href{tel:'${phone}'}{'${phone}'} \n
                    $|$ \n
                \\faAt \\hspace{.5pt} \\href{mailto:'${mail}'}{'${mail}'} \n
                    $|$ \n
                \\faLinkedinSquare \\hspace{.5pt} \\href{'${linkedin}'}{LinkedIn} \n
                    $|$ \n
                \\faGithub \\hspace{.5pt} \\href{'${github}'}{GitHub} \n
                    $|$ \n
                    \\faGlobe \\hspace{.5pt} \\href{'${website}'}{Portfolio} \n
            \\end{center}'
}

interests() {
    echo 'Interest: '
    read name
    echo 'Brief Description: '
    read desc

    output='\\textbf{Interests} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{itemize} \n
                \\item {'${name}' - '${desc}'} \n
            \\end{itemize}'
}

languages() {
    echo 'Language: '
    read name 
    echo 'Proficiency Level: '
    read proficiency

    output='\\textbf{Competitions} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n


            \\begin{itemize} \n
                \\item {'${name}' \n
                        '${proficiency}'} \n
            \\end{itemize}'
}

projects () {
    echo 'Project Name: '
    read name
    echo 'Organisation or Self: '
    read under
    echo 'Start Date: '
    read sdate 
    echo 'End Date (In case ongoing, leave blank): '
    read edate
    echo 'GitHub Url: '
    read github
    echo 'Description of Project: '
    read description

    output='\\textbf{Projects} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{itemize}
                \\item {\\textbf{'${name}'} \\hfill \\faGithub \\hspace{.5pt} \\href{'${github}'}{GitHub} \\\ \n
                        '${under}' \\hfill {'${sdate}' - '${edate}'} \n
                        { \n
                            \\begin{itemize} \n 
                                \\item {'${description}'} \n
                            \\end{itemize} \n
                        }} \n 
            \\end{itemize}'
}

skills() {
    echo 'Category: '
    read category
    echo 'List of Skills: '
    read skills

    output='\\textbf{Skills} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\noindent \n
            {\\textbf{'${category}'} : {'${skills}'}}'
}

resume_name=$1
component_dir=$2
component_name=$3
function_name=${component_name}
${function_name}
echo -e ${output} > ${component_dir}/${resume_name}-${component_name}.tex
exit