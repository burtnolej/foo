
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
from types import ListType, StringType
import struct
import StringIO
import urllib

def strfmtnow(format="%m%d%y"):
    """ return now in a string of the passed format
    :param format : i.e. "%m%d%y
    rtype:string
    """    
    from datetime import datetime
    assert(isinstance(format,StringType),format)
    return str(datetime.now().strftime(format))

def bindiff(file1,file2,returnfulldiff=False):
    """ binary compare 2 files
    :param file1 :string
    :param file2 :string
    :param returnfulldiff : boolean, if False func returns True/False otherwise full diff
    rtype:boolean or list of string
    """
    import sys
    from types import BooleanType
    from misc_utils_process import process_start,process_get_stdout
    from misc_utils import os_file_exists
    
    assert os_file_exists(file1),file1
    assert os_file_exists(file2),file2
    assert isinstance(returnfulldiff,BooleanType)
    
    if sys.platform == "win32":
        cmd = ['fc.exe','/B',file1,file2]
        p = process_start(cmd)
        diff_result = process_get_stdout(p)
        
        if diff_result.split("\n")[1].startswith("FC: no differences encountered"):
            return True
    
        if returnfulldiff:
            return diff_result.split("\n")
        return False
    
class Enum(object):
    def __init__(self,**kwargs):
        for key,value in kwargs.iteritems():
            if hasattr(self,key) == False:
                setattr(self,key,value)
                
def b64encode(str):
    return(base64.b64encode(str))

def b64decode(str):
    return(base64.b64decode(str))

def uuencode(str):
    # C:\\Users\\burtnolej\\foo.txt''''' becomes
    # C%3A%5CUsers%5Cburtnolej%5Cfoo.txt%27%27%27%27%27
    return urllib.quote(str)

def uudecode(str):
    # C%3A%5CUsers%5Cburtnolej%5Cfoo.txt%27%27%27%27%27 becomes
    # C:\\Users\\burtnolej\\foo.txt''''' 
    return urllib.unquote(str)

def encode(str,encoding="uu"):
    if encoding=="uu" or encoding=="uuencode":
        return uuencode(str)
    elif encoding=="base64":
        return b64encode(str)
    else:
        return str

def decode(str,encoding="uu"):
    if encoding=="uu" or encoding=="uuencode":
        return uudecode(str)
    elif encoding=="base64":
        return b64decode(str)
    else:
        return str
    
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

def get_2darray_from_file(filename,replace=[]):
    rows=[]
    rawrows = os_file_to_string(filename)
    for _rawrow in rawrows.split("\n"):
        for _search,_replace in replace:
            _rawrow = _rawrow.replace(_search,_replace)
        rows.append(_rawrow.split("^"))
    return rows

def put_2darray_in_file(filename,rows,encoding="unicode",suffix="",quote=False):
    """ takes an array of arrays and puts into a file rows needs to be of the form [[]]
    default is no encoding
    :param filename: path of output file
    :param rows list of list:
    :param encoding: [unicode|base64|uuencode]
    """
    def _encode(input_str,encoding="unicode",):
        if encoding == "base64":
            return b64encode(str(input_str))
        elif encoding == "uu":
            return uuencode(str(input_str))
        elif encoding == "unicode":
            return str(input_str)
    
    _rows=[]
    for row in rows:
        _rows.append("^".join([_encode(_field,encoding) for _field in row]))
    
    append_text_to_file(filename,suffix+"$$".join(_rows))
        
def write_text_to_file(filename,text):
    fh = open(filename,'w+')
    fh.write(text)
    fh.close

def write_array_to_file(filename,rows):
    fh = open(filename,'w+')
    for _row in rows:   
        fh.write(_row)
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
            
def os_dir_exists(dirpath,dirname=""):
    from os.path import join
    return(os_file_exists(join(dirpath,dirname)))

def os_dir_create(dirpath,dirname,test_exists=False):
    from os.path import join
    from os import mkdir
    
    if test_exists == True:
        if os_dir_exists(dirpath,dirname) == True:
            return
        
    mkdir(join(dirpath,dirname))
        
def os_dir_delete(dirpath,dirname=None,treedel=False):
    """ deletes a directory
    :param dirpath: string, path to directory
    :param optional dirname: string, name of dir, if not provides its assumed that dirpath is the fullpath
    :param treedel: boolean, recursively delete files in dir or not
    """

    assert os_file_exists(dirpath) or os_file_exists(os.path.join(dirpath,dirname))
    from os.path import join
    from os import mkdir, rmdir
    from shutil import rmtree
    
    if dirname != None:
        dirpath= join(dirpath,dirname)
        
    if not treedel:
        rmdir(dirpath)
    else:
        rmtree(dirpath)
    
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
            cls._instances[cls] = super(Singleton, cls).__call__(*args,**kwargs)
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
