from misc_utils import  os_file_to_string, os_file_exists, append_text_to_file, \
     uudecode
from misc_utils_log import Log, logger, PRIORITY
from collections import OrderedDict
import sys
from os import chdir

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    
log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5)
log.config =OrderedDict([('now',12),('type',10),('class',30),('funcname',30),
                         ('module',20),('msg',-1),('today',8)])

class ExcelBase(object):
    def __init__(self,reponame,**kwargs):

        global log
        
        if sys.platform == "win32":
            logdir = "./"
        else:
            logdir = "/tmp/log"
            
        if kwargs.has_key('runtime_path'):
            logdir = kwargs['runtime_path']
            log.logdir = logdir
            log.startlog()
            
        self.reponame = reponame

    @classmethod
    def reset(cls):
        attrs = [_attr for _attr,_ in inspect.getmembers(cls, lambda a:not(inspect.isroutine(a)))]
        for _attr in attrs:
            if _attr.startswith("__") == False:
                try:
                    delattr(cls,_attr)
                except AttributeError, e:
                    log.log(PRIORITY.INFO,msg="cannot delattr "+_attr+" setting to None")  
                    setattr(cls,_attr,None)
    
    @classmethod   
    def _validate_filename(self,filename):
        if os_file_exists(filename) == False:
            return([-1])

    @classmethod   
    def _validate_field(self,fieldname,decode=True):
        ''' database_name or table_name '''
        if hasattr(self,fieldname) == False:
            log.log(PRIORITY.FAILURE,msg=fieldname+" name must be passed")   
            return([-1]) 
        else:
            if decode==False:
                setattr(self,fieldname,getattr(self,fieldname))
            else:
                setattr(self,fieldname,uudecode(getattr(self,fieldname)))  

    @classmethod   
    def _validate_flag(self,flagname):
        ''' flagtype either decode_flag or delete_flag '''
        if hasattr(self,flagname) == False:
            setattr(self,flagname,True)
        elif uudecode(getattr(self,flagname)) == "True":
            setattr(self,flagname,True)
        else:
            setattr(self,flagname,False)
            
    @classmethod            
    def _parse_input_file(cls,filepath,mandatory_fields=['token',
                                                         'reponame',
                                                         'commit_message',
                                                         'commit_files'],
                                       runtime_path="."):

        if os_file_exists(filepath) == False:
            log.log(PRIORITY.FAILURE,msg="filename ["+filepath+"] not found]")   
            return([-1])

        file_str = os_file_to_string(filepath)

        # this is just for uuencoding; because encoding can create newline characters
        # we can get around this by converting them to + and then to space; which 
        # is treated as the same as a newline
        file_str = file_str.replace("+++"," ")
        lines = file_str.split("\n")

        #need to add a field to the args file that states whether 
        #or not we are passing uuencoded fields or not
        #as cant checkit because not parsed for delims at this point

        try:
            # first load all attributes passed
            for _line in lines:
                _line_split = []

                try:
                    _line_split = _line.split(":")
                except:
                    log.log(PRIORITY.INFO,msg="cannot process line   ["+_line+"] in file [" + filepath + "]") 

                if len(_line_split) == 2:
                    setattr(cls,_line_split[0],_line_split[1])

            # call validate func for each mandatory field
            for _field in mandatory_fields:
                getattr(cls,"_validate_"+_field)()

            # check to see if an explicit runtime path is set for databases and log files
            setattr(cls,"runtime_path",runtime_path)
            log.log(PRIORITY.INFO,msg="setting runtime_path to ["+runtime_path+"]")   

        except TypeError, e:
            log.log(PRIORITY.FAILURE,msg="TypeError uuencode issues? ["+str(e.message)+"]")   
            return([-1])            

        return cls