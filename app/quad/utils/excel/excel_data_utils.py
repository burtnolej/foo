
from data_utils import *
from excel_utils import ExcelBase
from misc_utils import os_dir_exists, encode, decode
from xml_utils import xmlstr2dict
from database_util import Database
import sys
from os import path
from collections import OrderedDict

from misc_utils_log import Log, logger, PRIORITY
ROOTDIR = path.dirname(path.realpath(__file__))

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    
log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5)
log.config =OrderedDict([('now',12),('type',10),('class',30),('funcname',30),
                         ('module',20),('msg',-1),('today',8)])

__all__ = ['DataStoredProcBase','DataStoredProc']

class DataStoredProcBase(ExcelBase):
    def __init__(self,database_name,delete_flag=False,**kwargs):
        super(DataStoredProcBase,self).__init__(**kwargs)
        self.database_name = database_name
        self.database = Database(self.database_name + ".sqlite",delete_flag)

    @classmethod
    def _validate_database_name(self,encoding="unicode"):
        self._validate_field("database_name",encoding)
      
    @classmethod   
    def _validate_delete_flag(self,encoding="unicode"):
        self._validate_flag("delete_flag",encoding)
        
    @classmethod    
    def _validate_sp_name(self,encoding="unicode"):
        """purpose: make sure the sp_name matches a function in data_utils modules and 
        store the func name a member attribute (sp_func_name)"""
        
        assert hasattr(self,'sp_name'), sp_name
        from sys import modules
        from module_utils import _getmembers
        
        module = modules['data_utils']
        module_members = _getmembers(module)
        
        sp_func_name = "get_" + self.sp_name
        if hasattr(module,sp_func_name) == False:
            return [-1]
        setattr(self,'sp_name',sp_func_name)
        setattr(self,'sp_module','data_utils')
        
        log.log(PRIORITY.INFO,msg="located qry function; member attr sp_name set to ["+sp_func_name+"]")
            
        return True
    
    @classmethod    
    def _validate_sp_args(self,encoding="unicode"):
        """purpose: parse nvp's that need to be passed to the sp_func_name """
        assert hasattr(self,'sp_args'), sp_args
        import xml.etree.ElementTree as xmltree
        valid_args = ['days','periods','teacherid','studentid']
        
        sp_args_dict = xmlstr2dict(decode(self.sp_args,encoding),doublequote=True)
        
        for arg in sp_args_dict.keys():
            if arg not in valid_args:
                return [-1]
                
        setattr(self,'sp_args',sp_args_dict)
        log.log(PRIORITY.INFO,msg="validated sp args, set member attr sp_arg to ["+str(sp_args_dict)+"]")
        return True
        
class DataStoredProc(DataStoredProcBase):
    @classmethod
    def stored_proc_by_file(cls,filepath,**kwargs):
        ''' query_str arg is encoded and is passed in a file'''        
        encoding = cls._get_file_encoding(filepath)
        cls._parse_input_file(filepath,mandatory_fields=['database_name','sp_name','delete_flag'],encoding=encoding,**kwargs)    
        cls1 = cls(cls.database_name,cls.delete_flag,**kwargs)       
        return(cls1._exec_stored_proc(encoding=encoding,**kwargs))
    
    def _exec_stored_proc(self,encoding="unicode",**kwargs):
        from sys import modules
        module = modules[self.sp_module]
        
        func = getattr(module,self.sp_name)
        results = func(self.database,**self.sp_args)

        _result_file =self._get_parse_result_file(**kwargs)
        
        if _result_file != -1:
            self._create_output_file(_result_file,results)

        return(results)

    def parse_args(argv):
        
        mandatory_flags = ['--input_filename']
        
        try:
            opts, args = getopt(argv[1:], "i:r:f:", ["input_filename=","result_file=","runtime_path=","="])
            for flag in mandatory_flags:
                if flag not in dict(opts).keys():
                    raise GetoptError(flag,"needs to be present")
                
            man_config = {} # mandatory flaags, hold the resulting, parsed flags
            opt_config = {} # optional flags
            
            for flag, value in opts:
                if flag in ("-i", "--input_filename") or flag in ("-r", "--runtime_path"):
                    if os_file_exists(value) == False:
                        raise GetoptError(flag + "cannot find file" + value)
                elif flag in ("-f", "--result_file"):
                    pass
                else:
                    assert GetoptError(flag + " unhandled option")
                    
                if flag in mandatory_flags:
                    man_config[flag.replace("--","")] = value
                else:
                    opt_config[flag.replace("--","")] = value
                        
        except GetoptError as err:
            print err
            usage()
            sys.exit(2)
            
        return man_config,opt_config
    
if __name__ == "__main__":
    
    config,opt_config = parse_args(sys.argv)
    log.log(PRIORITY.INFO,msg="executing with mandatory ["+str(config)+"] and [" +str(opt_config)+ "]")
    
    try:    
        _query =  DataStoredProc.stored_proc_by_file(config['input_filename'],**opt_config)
    except Exception,e:
        linenum = str(sys.exc_info()[-1].tb_lineno)
        log.log(PRIORITY.FAILURE,msg="an error occurred ["+linenum+"] ["+e.__class__.__name__+"] [" + e.message+"]")