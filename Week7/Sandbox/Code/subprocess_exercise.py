import subprocess

p = subprocess.Popen(["echo", "I'm talkin' to you, bash!"], 
        stdout = subprocess.PIPE, 
        stderr = subprocess.PIPE)

stdout, stderr = p.communicate()
stderr # b''
stdout # b"I'm talkin' to you, bash!\n"

# encode and print
print(stdout.decode()) # "I'm talkin' to you, bash!"

## Try something else
p = subprocess.Popen(["ls", "-l"], stdout = subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

## Call python itself from bash
p = subprocess.Popen(["python3", "../../../Week1/boilerplate.py"], stdout = subprocess.PIPE, stderr = subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

## Compile a latex document
# using pdflatex
# something like
# subprocess.os.system("pdflatex yourlatexdoc.tex")

## Handing directory and file paths
# use subprocess.os to make code OS independent

subprocess.os.path.join("directory", "subdirectory", "file") # result 
# would be appropriately different on Windows

## Running R
# see TestR.py in ../../Code/