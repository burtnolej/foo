'''
CREATE TABLE "adult" (name text,__timestamp text,__id text, 'code' TEXT, 'prep' TEXT, 'enum' TEXT);
CREATE TABLE student (name text,__timestamp text,__id text, 'code' TEXT, 'prep' TEXT, 'enum' TEXT);
CREATE TABLE period (name text,__timestamp text,__id text, 'code' TEXT, 'enum' TEXT);
CREATE TABLE dow (code text,name text,__timestamp text,__id text, 'enum' TEXT);
CREATE TABLE lessontype (code text,name text,__timestamp text,__id text, 'enum' TEXT, 'objtype' TEXT, 'userobjid' TEXT);
CREATE TABLE "subject" (name text,__timestamp text,__id text,lessontype TEXT,code TEXT, 'enum' TEXT);
CREATE TABLE "session" (dow text,period integer,subject text,teacher text,capacity text,__timestamp text,__id text,teacher2 TEXT,notes TEXT,fgcolor TEXT,code TEXT,type TEXT,enum TEXT, 'prep' TEXT);
CREATE TABLE recordtype (code text,enum integer,name text,__timestamp text,__id text);
CREATE TABLE lesson (dow text,lessontype text,objtype text,period text,prep text,saveversion text,schedule text,session text,student text,subject text,teacher text,userobjid text,__timestamp text,__id text);
'''

import sys

for line in sys.stdin:
    
    # separate "CREATE TABLE <tablename>" from the colm defn
    s1,s2 = line.split("(")
    
    s1 = s1.rstrip()
    _,_,tablename = s1.split(" ")
    tablename = tablename.replace("\"","")
    print
    print "table:",tablename
    
    # remove trailing ");"
    s2 = s2[:-3]
    
    for _s2 in s2.split(","):
        _s2 = _s2.lstrip().rstrip()
        _s2 = _s2.replace("'","")
        
        x,y = _s2.split(" ")
        print x.rjust(15),y