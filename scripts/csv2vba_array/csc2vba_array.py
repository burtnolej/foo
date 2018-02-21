from misc_utils import os_file_to_list, os_file_exists
import sys

if len(sys.argv) == 1:
    print "usage : xsv2vba_array [filepath]"
    exit()
elif os_file_exists(sys.argv[1]) == False:
    print "file not found",sys.argv[1]
    exit()
    
vba_array_str = ""
lines = os_file_to_list(sys.argv[1])

for linecount in range(0,len(lines)):

    _line = lines[linecount]
    _line = _line.replace("\n","")
    _line = _line.replace("\"","")
    
    errno,errdescr = tuple(_line.split(","))
    
    if linecount == 0:
        vba_array_str = "\""+errno+"\",\""+errdescr+"\""
    else:
        vba_array_str = vba_array_str +";" +  "\n" + "\""+errno+"\",\""+errdescr+"\""
    
print vba_array_str
    
