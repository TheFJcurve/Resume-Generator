#!/bin/bash

## ./component-in-LaTeX.sh (resume-name) (component-directory) (component-name-to-create)

## Required Arguments: All the arguments are required.

## Given a component to create, this function calls functions that create LaTeX code for the component
## accepts arguments to personalize the resume with ease.

## The functions it can run are as follows:
## achievements()
## certificates()
## competitions()
## education()
## experience()
## heading()
## interests()
## languages()
## projects()
## skills()

## SIDE EFFECTS
## Adds a file to ../resumes/${resume_name}/${resume_name}-components/${resume_name}-${component_name}.tex

achievements() {
    echo 'How many achievements would you like to list? '
    read count
    output='\\textbf{Achievement} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{itemize} \n'

    for ((i=1; i<=${count};i++)); do
        echo 'Details of Achievement' ${i}
        echo ''
        echo 'Competition Name: '
        read competition
        echo 'Location: '
        read location
        echo 'Year: '
        read year
        echo 'Description: '
        read description
        output+='\\item {'${competition}' \\\ \n
                '${location}' \\hfill '${year}' \\\ \n 
                '${description}'} \n'
    done
    
    output+='\\end{itemize}'
}

certificates() {
    echo 'How many Certificates do you wish to add? '
    read count 
    output='\\textbf{Certificates} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{enumerate} \n'

    for ((i=1;i<=${count};i++)); do
        echo 'Details of Certificate' ${i}
        echo ''
        echo 'Certificate Name: '
        read name
        echo 'Issuing Authority: '
        read auth
        echo 'Year: '
        read year
        echo 'Brief Description: '
        read desc

        output+='\\item  {'${name}' \\\ \n
                            '${auth}' \\hfill '${year}' \\\ \n
                            '${desc}'} \n'
    done

    output+='\\end{enumerate}'
}

competitions() {
    echo 'How many Competitions do you wish to add? '
    read count
    output='\\textbf{Competitions} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{enumerate} \n'

    for ((i=1;i<=${count};i++)); do
        echo 'Details of Competition' ${i}
        echo ''
        echo 'Competition Name: '
        read name
        echo 'Position: '
        read position
        echo 'A Brief Description: '
        read desc
        output+='\\item {'${name}' | '${position}' \\\ \n
                    '${desc}'} \n'
    done

    output+='\\end{enumerate}'
}

education() {
    echo 'How many Education Institutes do you wish to add? '
    read count
    output='\\textbf{Education} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n'
    
    
    for ((i=1; i<=${count};i++)); do
        echo 'Details for Institute' ${i}
        echo ''
        echo 'University Name: '
        read name
        echo 'Graduation Year: '
        read grad
        echo 'Program: '
        read program
        echo 'Relavent Courses List: '
        read relcourses


        output='\\textbf{'${name}'} \\hfill {'${grad}'} \\\ \n
                '${program}' \\\ \n
                {Relavent Courses} - {'${relcourses}'} \\\'
    done    
}

experience() {
    echo 'How many Experiences would you like to include? '
    read count 

    output='\\textbf{Experience} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n'

    for ((i=1;i<=${count}; i++)); do
        echo 'Details for Experience' ${i}
        echo ''

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

        output='
                {\\textbf{'${name}'}, \\textnormal{\\textit{'${position}'} | '${location}'}} \\hfill {'${sdate}' - '${edate}'} \n
                {\\begin{itemize} \n
                        \\item {'${desc}'} \n
                    \\end{itemize}}'
    done

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
    echo 'How many Languages would you like to input? '
    read count

    output='\\textbf{Competitions} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{itemize} \n'

    for ((i=1;i<=${count};i++)); do
        echo 'Details about Language' ${i}
        echo ''
        echo 'Language: '
        read name 
        echo 'Proficiency Level: '
        read proficiency
        output+='\\item {'${name}': '${proficiency}'} \n'
    done

    output+='\\end{itemize}''
}

projects () {
    echo 'How many projects would you like to include? '
    read count

    output='\\textbf{Projects} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n

            \\begin{itemize} \n'
    
    for ((i=1; i<=${count}; i++)); do
        echo 'Details of Project' ${i}
        echo ''
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
        output+='\\item {\\textbf{'${name}'} \\hfill \\faGithub \\hspace{.5pt} \\href{'${github}'}{GitHub} \\\ \n
                        '${under}' \\hfill {'${sdate}' - '${edate}'} \n
                        { \n
                            \\begin{itemize} \n 
                                \\item {'${description}'} \n
                            \\end{itemize} \n
                        }} \n'
    done 
    
    output+='\\end{itemize}'
}

skills() {
    echo 'How many skill categories would you like to add? '
    read count

    output='\\textbf{Skills} \n

            \\par\\noindent\\rule{\\textwidth}{0.2pt} \n'

    for ((i=1; i<=${count}; i++)); do
        echo 'Details about Skill Category' ${i}
        echo ''
        echo 'Category: '
        read category
        echo 'List of Skills: '
        read skills
        output+='\\noindent \n
                {\\textbf{'${category}'} : {'${skills}'}} \n'
    done
}

resume_name=$1
component_dir=$2
component_name=$3
function_name=${component_name}
${function_name}
echo -e ${output} > ${component_dir}/${resume_name}-${component_name}.tex
exit