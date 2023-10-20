Using LaTeX ahd Bash scripting to make resume creating process much simpler, as it should be. Create multiple resumes with the same or mildly changed components!

Running on bash command line:

cd program/code-files

./execute.sh [create|update|delete|drop_resume] [resume-name] [font-size] (OPTIONAL) [document-type] (OPTIONAL)

Note: If running ./execute.sh script says permission denied, run 'chmod a+x \*'

CREATE

Start by executing the command './execute.sh create [resume-name] [font-size] (OPTIONAL) [document-type] (OPTIONAL)'. This will create a subfolder
in ..\resumes\ folder with the name [resume-name].

1. For every component of the resume, choose if you wish to import this from any other resume you have create earlier.
2. If yes, the same file will be imported for you, and you can make edits on.
3. If no, a new LaTeX template will be provided for you, in which you can customize anything you wish.
4. Once you have added all the components you wished for, enter 'q' or 'quit' to exit the program.
5. The pdf file will be automatically generated, and will be found in the folder resume/[resume-name]/[resume-name]-output-files.

UPDATE

Start by executing the command './execute.sh update [resume-name] [font-size] (OPTIONAL) [document-type] (OPTIONAL)'. This will edit one component file in the
resumes subfolder, [resume-name].

1. Existing components will be listed for you, select the one you would like to edit (WITH the .tex extension).
2. Once you edit the file, save it, the changes will be automatically updated in the pdf file.

DELETE

Start by executing the command '/execute.sh delete [resume-name]'. This will delete one component from the [resume-name].

1. Existing components will be listed for you, select the one that you would like to delete (WITH the .tex extension).
2. Once you delete the component, the changes will be automatically updated in the pdf file.

DROP_RESUME

Start by executing the command './execute.sh drop_resume [resume-name]'.

WARNING: This function is extremely dangerous if you don't know what you are doing.

This will delete the whole resume directory with the name [resume-name], and all the components in it.
