
from app.quad.utils.data_utils import *
from utils.excel.excel_utils import ExcelBase
from utils.misc_basic.misc_utils import os_dir_exists, encode, decode, os_file_exists
from utils.misc_basic.xml_utils import xmlstr2dict
from utils.database.database_util import Database
from utils.database.database_table_util import _quotestrs

import sys
from os import path
from collections import OrderedDict
from getopt import getopt, GetoptError, gnu_getopt

from utils.misc_basic.misc_utils_log import Log, logger, PRIORITY
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
    def __init__(self,database_name,**kwargs):
        super(DataStoredProcBase,self).__init__(**kwargs)
        self.database_name = database_name
        self.database = Database(self.database_name + ".sqlite",False)
        
    @classmethod
    def _validate_database_name(self,encoding="unicode"):
        self._validate_field("database_name",encoding)

    @classmethod   
    def _validate_header_flag(self,encoding="unicode"):
        self._validate_flag("header_flag",encoding)
        
    @classmethod   
    def _validate_runtime_dir(self,encoding="unicode"):
        self._validate_filename("runtime_dir",encoding)
    
    @classmethod   
    def _validate_result_file(self,encoding="unicode"):
        self._validate_filename("result_file",encoding,mustexist=False)
        
    @classmethod   
    def _validate_delete_flag(self,encoding="unicode"):
        self._validate_flag("delete_flag",encoding)
        
    @classmethod    
    def _validate_sp_name(self,encoding="unicode"):
        """purpose: make sure the sp_name matches a function in data_utils modules and 
        store the func name a member attribute (sp_func_name)"""
        
        assert hasattr(self,'sp_name'), sp_name
        from sys import modules
        from utils.misc_basic.module_utils import _getmembers
        
        module = modules['app.quad.utils.data_utils']
        module_members = _getmembers(module)
        
        if self.sp_name.startswith("insert_") == False and self.sp_name.startswith("delete_") == False and self.sp_name.startswith("update_") == False:
            sp_func_name = "get_" + self.sp_name
        else:
            sp_func_name = self.sp_name
            
        if hasattr(module,sp_func_name) == False:
            return [-1]
        setattr(self,'sp_name',sp_func_name)
        setattr(self,'sp_module','app.quad.utils.data_utils')
        
        log.log(PRIORITY.INFO,msg="located qry function; member attr sp_name set to ["+sp_func_name+"]")
            
        return True
    
    @classmethod    
    def _validate_sp_args(self,encoding="unicode"):
        """purpose: parse nvp's that need to be passed to the sp_func_name """
        assert hasattr(self,'sp_args'), sp_args
        import xml.etree.ElementTree as xmltree
        valid_args = ['days','periods','teacchers','students']
        
        sp_args_dict = xmlstr2dict(decode(self.sp_args,encoding),doublequote=True)
        
        for arg in sp_args_dict.keys():
            if arg not in valid_args:
                return [-1]
                
        setattr(self,'sp_args',sp_args_dict)
        log.log(PRIORITY.INFO,msg="validated sp args, set member attr sp_arg to ["+str(sp_args_dict)+"]")
        return True

    # DUPLICATE CODE - need to reuse code from excel_database_util
    # BUT NEED TO ADD TO SP_ARGS 
    
    @classmethod
    def _validate_list(self,listname,encoding="unicode"):
        if hasattr(self,listname) == False:
            log.log(PRIORITY.FAILURE,msg=listname + " must be passed")   
            return([-1])
        else:
            if encoding == "base64":
                setattr(self,listname,[b64decode(_field) for _field in getattr(self,listname).split("$$")])
            else:
                setattr(self,listname,[_field for _field in getattr(self,listname).split("$$")])

        if hasattr(self,"sp_args") == False:
            setattr(self,"sp_args",{})
                    
        sp_args_dict = getattr(self,'sp_args')
        sp_args_dict[listname] = getattr(self,listname)
        setattr(self,'sp_args',sp_args_dict)
    
    @classmethod
    def _validate_columns(self,encoding="unicode"):
        self._validate_list("columns",encoding)
        '''if hasattr(self,"columns") == False:
            log.log(PRIORITY.FAILURE,msg="columns must be passed")   
            return([-1])
        else:
            if encoding == "base64":
                self.columns = [b64decode(_field) for _field in self.columns.split("$$")]
            else:
                self.columns = [_field for _field in self.columns.split("$$")]

        if hasattr(self,"sp_args") == False:
            setattr(self,"sp_args",{})
                    
        sp_args_dict = getattr(self,'sp_args')
        sp_args_dict['columns'] = self.columns
        setattr(self,'sp_args',sp_args_dict)'''
        
    @classmethod
    def _validate_row(self,encoding="unicode"):
        self._validate_list("row",encoding)
        
    @classmethod
    def _validate_column_defns(self,encoding="unicode"):
        if hasattr(self,"column_defns") == False:
            log.log(PRIORITY.FAILURE,msg="column_defns must be passed")   
            return([-1])
        else:
            if column_defns == []: # allows method to be called statically
                column_defns = self.column_defns
                
            _column_defns = []
            _field_pairs = [_field for _field in self.column_defns.split("$$")]
            for _field_pair in _field_pairs:
                _name,_type = _field_pair.split("^")
                if encoding == "base64":
                    _column_defns.append((b64decode(_name),b64decode(_type)))
                else:
                    _column_defns.append((_name,_type))
            setattr(self,"column_defns",_column_defns)

        if hasattr(self,"sp_args") == False:
            setattr(self,"sp_args",{})
                
        sp_args_dict = getattr(self,'sp_args')
        sp_args_dict['column_defns'] = self.column_defns
        setattr(self,'sp_args',sp_args_dict)

    @classmethod   
    def _validate_rows(self,encoding="unicode"):
        if hasattr(self,"rows") == False:
            log.log(PRIORITY.FAILURE,msg="rows must be passed")   
            return([-1]) 
        else:
            self.urows = []
            for row in self.rows.split("$$"):
                _row = row.split("^")
                if encoding == "base64":
                    try:
                        tmp = [b64decode(_field) for _field in _row]
                    except TypeError, e:
                        raise Exception("rows are not base64 encoded")

                self.urows.append(_row)
                
        setattr(self,"rows",_quotestrs(self.urows))

        if hasattr(self,"sp_args") == False:
            setattr(self,"sp_args",{})
            
        sp_args_dict = getattr(self,'sp_args')
        sp_args_dict['rows'] = self.rows
        setattr(self,'sp_args',sp_args_dict)
        
class DataStoredProc(DataStoredProcBase):
    
    def __init__(self,database,**kwargs):
        super(DataStoredProc,self).__init__(database,**kwargs)
        # sp_args member attr is required even if empty
        if hasattr(self,"sp_args") == False:
            setattr(self,"sp_args",{})
        
    @classmethod
    def stored_proc_by_file(cls,filepath,**kwargs):
        ''' query_str arg is encoded and is passed in a file'''        
        encoding = cls._get_file_encoding(filepath)
        cls._parse_input_file(filepath,mandatory_fields=['database_name','sp_name','delete_flag'],encoding=encoding,**kwargs)    
        cls1 = cls(cls.database_name,**kwargs)       
        return(cls1._exec_stored_proc(encoding=encoding,**kwargs))
    
    def _exec_stored_proc(self,encoding="unicode",**kwargs):
        from sys import modules
        module = modules[self.sp_module]
        
        func = getattr(module,self.sp_name)
        columns,results = func(self.database,**self.sp_args)
                    
        _result_file =self._get_parse_result_file(**kwargs)

        if hasattr(self,"header_flag"):
            if getattr(self,"header_flag") == True:
                results.insert(0,columns)
                
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