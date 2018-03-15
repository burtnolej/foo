
from data_utils import *

class DataStoredProcBase(ExcelBase):
    def __init__(self,database_name,delete_flag=False,**kwargs):
        super(DataBase,self).__init__(**kwargs)
        self.database_name = database_name
        self.database = Database(self.runtime_path + "/" + self.database_name + ".sqlite",delete_flag)

    @classmethod   
    def _validate_sp_name(self,encoding="unicode"):
        """purpose: make sure the sp_name matches a function in data_utils and 
        store the func name a member attribute (sp_func_name)"""
        pass
        
    @classmethod   
    def _validate_sp_args(self,encoding="unicode"):
        """purpose: parse nvp's that need to be passed to the sp_func_name """
        pass
        
class DataStoredProc(DataBase):
    @classmethod
    def stored_proc_by_file(cls,filepath,**kwargs):
        ''' query_str arg is encoded and is passed in a file'''        
        encoding = cls._get_file_encoding(filepath)
        cls._parse_input_file(filepath,mandatory_fields=['database_name','sp_name','delete_flag'],encoding=encoding,**kwargs)    
        cls1 = cls(cls.database_name,cls.delete_flag,**kwargs)       
        return(cls1._exec_stored_proc(cls.qry_str,encoding=encoding,**kwargs))

    def _exec_stored_proc(self,query_str,encoding="unicode",**kwargs):
        results = self.sp_func_name(self.database,**self.sp_args)

        if hasattr(self,'result_file'):
            _result_file = getattr(self,'result_file') 
            if isinstance(_result_file, ListType):
                if len(_result_file) == 1:
                    _result_file = _result_file[0]
                else:
                    log.log(PRIORITY.INFO,msg="cant use file not a list of len one")
                
            self._create_output_file(_result_file,results)
            
        return(tbl_rows)

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