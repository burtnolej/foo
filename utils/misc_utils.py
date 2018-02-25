
# Filesystem 
# ----------------------------------
# get_2darray_from_file   (filename)
# put_2darray_in_file     (filename,rows,uuencodeflag=True)
# write_text_to_file      (filename,text):
# append_text_to_file     (filename,text):
# os_file_touch           (fpath, fname):
# os_file_delete          (os_file_name):
# os_file_get_wildcard    (dir,pattern):
# os_file_to_string       (filename,remove=None):
# os_file_to_list         (filename,remove=None,strip=False):
# os_dir_exists           (dirpath,dirname):
# os_dir_create           (dirpath,dirname,test_exists=False):     
# os_dir_delete           (dirpath,dirname):

# thisfuncname            (cls=None,stackdelta=0):
# thisfuncsclassname      (funcname):
# nxnarraycreate          (maxrows,maxcols,args={}):
# write_pickle            (object,filename=None):
# read_pickle             (filename):

# uuencode                (str):
# uudecode                (str):
    
# Classes
# ----------------------------------
# Enumerate               (object):
# Singleton               (type):
# IDGenerator             (object):

from random import randint
import sys
from collections import OrderedDict
import sys
from types import *
from inspect import stack, getmro
from os.path import basename
from os import listdir, remove
from shutil import move, copy
import base64
from types import ListType
import struct

def uuencode(str):
    return(base64.b64encode(str))

def uudecode(str):
    return(base64.b64decode(str))


def write_binary_file(filename,bytestring):
    # b'\x07\x08\x07'
    with open(filename, 'wb') as f:
        f.write(bytestring)

def write_binary_file_struct(filename,binary)     :   
    #binary = [1234, 5678, -9012, -3456]
    with open(filename, 'wb') as f:
        for b in binary:
            f.write(struct.pack('h', b)) #or whatever format you need
                
    
class Enumerate(object):
    def __init__(self, names):
        for number, name in enumerate(names.split(",")):
            setattr(self, name, number)

def isint(value):
    try:
        num = int(value)
        return True
    except:
        return False

def isintarray(value,lt=-1):
    ''' are all values in a list integers '''
    if isarray(value) == True:
        for _value in value:
            if isint(_value) == False:
                return False
            elif lt!=-1:
                if _value >= lt:
                    return False
    else:
        return False

    return True

def isarray(value):
    ''' is argument a list '''
    if isinstance(value,ListType) == False:
        return False
    return True

    
def get_2darray_from_file(filename):
    rows=[]
    rawrows = os_file_to_string(filename)
    for _rawrow in rawrows.split("\n"):
        rows.append(_rawrow.split("^"))
    return rows

def put_2darray_in_file(filename,rows,uuencodeflag=True,suffix=""):
    ''' takes an array of arrays and puts into a file
    rows needs to be of the form [[]]
    default is to uuencode '''
    def _encode(input_str,uuencodeflag=True):
        if uuencodeflag == True:
            return uuencode(str(input_str))
        return str(input_str)
    
    _rows=[]
    for row in rows:
        _rows.append("^".join([_encode(_field,uuencodeflag) for _field in row]))
    
    append_text_to_file(filename,suffix+"$$".join(_rows))
        
def write_text_to_file(filename,text):
    fh = open(filename,'w+')
    fh.write(text)
    fh.close
    
def append_text_to_file(filename,text):
    fh = open(filename,'a+')
    fh.write(text)
    fh.close
                
def os_file_touch(fpath, fname):
    from os import utime
    from os.path import exists,join
    
    fpname = join(fpath,fname)
    if exists(fpname):
        utime(fpname, None)
    else:
        open(fpname, 'w').close()
        
    return fpname
            
def os_dir_exists(dirpath,dirname):
    from os.path import join
    return(os_file_exists(join(dirpath,dirname)))

def os_dir_create(dirpath,dirname,test_exists=False):
    from os.path import join
    from os import mkdir
    
    if test_exists == True:
        if os_dir_exists(dirpath,dirname) == True:
            return
        
    mkdir(join(dirpath,dirname))
        
def os_dir_delete(dirpath,dirname):
    from os.path import join
    from os import mkdir, rmdir
    
    rmdir(join(dirpath,dirname))
    
def thisfuncname(cls=None,stackdelta=0):
    funcname = stack()[1 + stackdelta][3]
    #module = basename(stack()[1 + stackdelta][1])
    
    if cls <> None:
        clsname = cls.__class__.__name__
        funcname = clsname + "." + funcname
    
    #return("^".join([module,funcname]))
    return(funcname)

def thisfuncsclassname(funcname):
    for cls in getmro(funcname):
        if funcname in cls.__dict__: 
            return cls.__name__
    return None
    
def nxnarraycreate(maxrows,maxcols,args={}):
    ''' creates a n x n array containing args; args can be none, args can be dict, list, string'''
    grid=[]
    for row in range(maxrows):
        row=[]
        for col in range(maxcols):
            # if its a dict make a copy
            try:
                argcopy = args.copy()
            except AttributeError:
                argcopy = args
                
            row.append(argcopy)
        grid.append(row)
    return(grid)

class Singleton(type):
    _instances = {}
    def __call__(cls,*args,**kwargs):
        
        if kwargs.has_key('reset') == True:
            cls._instances = {}
            kwargs.pop('reset')
                
        if cls not in cls._instances:
            #print "info: singleton object being created"
            cls._instances[cls] = super(Singleton, cls).__call__(*args,**kwargs)
        else:
            #print "info: singleton already instantiated",cls._instances[cls]
            pass
        return cls._instances[cls]
    
def attr_get_keyval(obj):
    from inspect import getmembers
    return[(k,v) for k,v in getmembers(obj) if not k.startswith('__')]

def os_file_exists(os_file_name):
    from os.path import exists
    
    if exists(os_file_name):
        return(True)
    else:
        return(False)

def os_file_delete(os_file_name):
    remove(os_file_name)
    
def os_file_get_wildcard(dir,pattern):
    import os, re
    return([f for f in os.listdir(dir) if re.search(pattern, f)])
       
    #os.remove(os.path.join(dir, f))

def os_file_to_string(filename,remove=None):
    
    s=""
    fh = open(filename, 'r+')

    for line in fh:
        if remove <> None:
            for _str in remove:
                line = line.replace(_str,"")
        s+=line
       
    fh.close()
    return s

def os_file_to_list(filename,remove=None,strip=False):
    
    fh = open(filename, 'r+')

    if strip==True:
        l = [line.strip() for line in fh] 
    else:
        l = [line for line in fh] 
        
    fh.close()
    return l

def write_pickle(object,filename=None):
    import pickle
    with open(filename, 'w') as f:
        pickle.dump(object, f)

    return(filename)

def read_pickle(filename):
    import pickle
    with open(filename, 'r') as f:
        object = pickle.load(f)

    return(object)

class IDGenerator(object):
    __metaclass__ = Singleton

    idfile = ".id.dat"
    usedids = []
    size = 8
        
    def __init__(self):
        from os import path as ospath
        if ospath.exists(self.idfile) == True:
            self.usedids = read_pickle(self.idfile)
        
    def getid(self):        
        from os import path as ospath

        return(self._next())
            
    def num_ids(self):
        return(len(self.usedids))

    def reset(self):
        import os
        self.usedids = []

        try:
            os.remove(self.idfile)
        except OSError:
            pass
        
    def _next(self):
        count = 1
        
        maxid = pow(10,self.size)
        unique=False
        retry=0
        
        while unique==False:
            uniqueid = randint(1,maxid)
            uniqueid = hex(uniqueid).upper()[2:].rjust(self.size,"0")
            
            if not uniqueid in self.usedids: 
                unique=True
            else:
                retry+=1
                
            if retry>10: 
                self.write()
                raise Exception("max retry")
            count += 1
        self.usedids.append(uniqueid)
        #print "adding",uniqueid
        #self.write()
        return(uniqueid)
        
    def write(self):
        write_pickle(self.usedids,self.idfile)
    
    def __del__(self):
        self.write()
