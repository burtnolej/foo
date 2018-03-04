from misc_utils import  os_file_to_string, os_file_exists, append_text_to_file, \
     uudecode, write_array_to_file, write_text_to_file
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
    '''
    the ExcelBase class is dynamic and the class attributes are set by 
    values found in the input file that is being passed from excel.
    this class knows how to parse the file and validate the fields '''
    def __init__(self,**kwargs):

        global log
        
        # this 
        if sys.platform == "win32":
            self.logdir = "./"
        else:
            self.logdir = "/tmp/log"
            
        # force the logfile to be written into the runtime directory
        if kwargs.has_key('runtime_path'):
            self.logdir = kwargs['runtime_path']
            
        log.logdir = self.logdir
        log.startlog()
        setattr(self,"runtime_path",self.logdir)
        

    @classmethod
    def reset(cls):
        """ because the class attribute persist throughout a python session,
        when testing we need to be able to delete dynamic attributes and start again.
        this is probably not the right way to do it....
        """
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
        """ check if filename exists
        :param filename:string
        :rtype : -1 on failure or None
        """
        if os_file_exists(filename) == False:
            return([-1])

    @classmethod   
    def _validate_field(self,fieldname,decode=True):
        """ check the a raw value for the field has been set
        :param filename:string
        :param decode: boolean, does the field need to be decoded from b64
        :rtype : -1 on failure or None
        """
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
        """ check the a raw flag exists and update attr to be boolean value
        :param flagname:string
        :rtype : -1 on failure or None
        """
        if hasattr(self,flagname) == False:
            setattr(self,flagname,True)
        elif uudecode(getattr(self,flagname)) == "True":
            setattr(self,flagname,True)
        else:
            setattr(self,flagname,False)
            
    def _create_output_file(self,filepath,input_rows):
        outstr = "$$".join(["^".join(map(str,_row)) for _row in input_rows])
        write_text_to_file(filepath,outstr)
        
    @classmethod            
    def _parse_input_file(cls,filepath,mandatory_fields,
                                       runtime_path=".",**kwargs):
        """ take a key,value pair param text file and create class attributes of the name
        key with the value, value
        :param filepath:string, full path of the param text file
        :param mandatory_fields: list, all the fields that must be present in this file
        rtype : -1 on failure or None
        """
        if os_file_exists(filepath) == False:
            log.log(PRIORITY.FAILURE,msg="filename ["+filepath+"] not found]")   
            return([-1])

        file_str = os_file_to_string(filepath)

        # this is just for uuencoding; because encoding can create newline characters
        # we can get around this by converting them to + and then to space; which 
        # is treated as the same as a newline
        file_str = file_str.replace("+++"," ")
        lines = file_str.split("\n")

        # todo:
        # need to add a field to the args file that states whether 
        # or not we are passing uuencoded fields or not
        # as cant checkit because not parsed for delims at this point

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