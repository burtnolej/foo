from database_util import Database, tbl_create, tbl_exists, tbl_list
from database_table_util import tbl_query, _quotestrs, tbl_rows_insert, _quotestrs, \
     tbl_cols_get
from misc_utils import  os_file_to_string, write_text_to_file, os_file_exists, \
     append_text_to_file, uuencode, uudecode
from misc_utils_log import Log, logger, PRIORITY
from collections import OrderedDict
import inspect
from datetime import datetime
from excel_utils import ExcelBase
from getopt import getopt, GetoptError, gnu_getopt

import sys
from os import chdir

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    
log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5)
log.config =OrderedDict([('now',12),('type',10),('class',30),('funcname',30),
                         ('module',20),('msg',-1),('today',8)])
        
class DatabaseBase(ExcelBase):
    def __init__(self,database_name,delete_flag=False,**kwargs):

        if kwargs.has_key('runtime_path') == True:
            setattr(self,"runtime_path",kwargs['runtime_path'])
            log.logdir = kwargs['runtime_path']
            log.startlog()
        else:
            setattr(self,"runtime_path",".")
            
        super(DatabaseBase,self).__init__(**kwargs)
        self.database_name = database_name
        self.database = Database(self.runtime_path + "/" + self.database_name + ".sqlite",
                                     delete_flag)
            
    @classmethod   
    def _validate_decode_flag(self):
        self._validate_flag("decode_flag")
        
    @classmethod   
    def _validate_delete_flag(self):
        self._validate_flag("delete_flag")
        
    @classmethod   
    def _validate_field(self,fieldname):
        ''' database_name or table_name '''
        if hasattr(self,fieldname) == False:
            log.log(PRIORITY.FAILURE,msg=fieldname+" name must be passed")   
            return([-1]) 
        else:
            setattr(self,fieldname,uudecode(getattr(self,fieldname)))  
            
    @classmethod   
    def _validate_database_name(self):
        self._validate_field("database_name")
        
    @classmethod   
    def _validate_table_name(self):
        self._validate_field("table_name")
        
    @classmethod   
    def _validate_qry_str(self):
        self._validate_field("qry_str")
        
    @classmethod
    def _validate_columns(self):
        if hasattr(self,"columns") == False:
            log.log(PRIORITY.FAILURE,msg="columns must be passed")   
            return([-1])
        else:
            self.columns = [uudecode(_field) for _field in self.columns.split("$$")]

    @classmethod
    def _validate_column_defns(self):
        if hasattr(self,"column_defns") == False:
            log.log(PRIORITY.FAILURE,msg="column_defns must be passed")   
            return([-1])
        else:
            _column_defns = []
            _field_pairs = [_field for _field in self.column_defns.split("$$")]
            for _field_pair in _field_pairs:
                _name,_type = _field_pair.split("^")
                _column_defns.append((uudecode(_name),uudecode(_type)))
            setattr(self,"column_defns",_column_defns)
                
    @classmethod   
    def _validate_rows(self):
        if hasattr(self,"rows") == False:
            log.log(PRIORITY.FAILURE,msg="rows must be passed")   
            return([-1]) 
        else:
            self.urows = []
            for row in self.rows.split("$$"):
                
                _row = row.split("^")
                if self.decode_flag==False:
                    _urow = _row
                else:
                    _urow = [uudecode(_field) for _field in _row]
                self.urows.append(_urow)
                
        setattr(self,"rows",_quotestrs(self.urows))
    
class DatabaseQueryTable(DatabaseBase):
    @classmethod
    def query(cls,database_name,query_str,delete_flag=False):
        ''' query_str and result are in plain text '''
        cls1 = cls(database_name,delete_flag)
        return(cls1._query_table(query_str))
    
    @classmethod
    def query_encoded(cls,database_name,query_str,delete_flag=False):
        ''' query_str arg is encoded and needs to be decoded '''
        cls1 = cls(database_name,delete_flag)
        return(cls1._query_table(uudecode(query_str)))

    @classmethod
    def query_encoded_by_file(cls,filepath,**kwargs):
        ''' query_str arg is encoded and is passed in a file'''
        cls._parse_input_file(filepath,mandatory_fields=[
                                                     'database_name',
                                                     'qry_str',
                                                     'delete_flag'],
                                       **kwargs)    
        cls1 = cls(cls.database_name,cls.delete_flag,**kwargs)       
        return(cls1._query_table(cls.qry_str,**kwargs))

    def _query_table(self,query_str,**kwargs):
        with self.database:
            _,tbl_rows,_ = tbl_query(self.database,query_str)
            
        if kwargs.has_key('result_file') == True:
            self._create_output_file(kwargs['result_file'],tbl_rows)
            
        return(tbl_rows)

class DatabaseMisc(DatabaseBase):
    
    def __init__(self,filepath,mandatory_fields=[
                       'delete_flag',
                       'database_name',
                       'table_name']):
        self._parse_input_file(filepath,mandatory_fields)    
        DatabaseBase.__init__(self,self.database_name,self.delete_flag) 
        
    @classmethod
    def table_exists_by_file(cls,filepath):        
        cls1 = cls(filepath) 
        _exists = cls1._table_exists(cls.table_name)
        log.log(PRIORITY.INFO,msg="table ["+cls.table_name+"] exists = [" + str(_exists) + "] in db [" + cls.database_name +"]")   
        return(_exists)

    @classmethod
    def get_table_info_by_file(cls,filepath):
        cls1 = cls(filepath) 
        _info = cls1._get_table_info(cls.table_name)
        log.log(PRIORITY.INFO,msg="got table ["+cls.table_name+"] info  [" + str(_info) + "]")   
        return(_info)
    
    @classmethod
    def get_table_list_by_file(cls,filepath):
        cls1 = cls(filepath) 
        _table_list = cls1._get_table_list()
        log.log(PRIORITY.INFO,msg="got table list for db ["+cls.database_name+"]  [" + str(_table_list) + "]")   
        return(_table_list)
    
    @classmethod
    def database_exists_by_file(cls,filepath):
        cls1 = cls(filepath) 
        _exists = cls1._table_exists(filepath)
        log.log(PRIORITY.INFO,msg="db ["+cls.database_name+"] exists = [" + str(_exists) + "]")   
        return(_exists)
    
    def _table_exists(self,table_name):
        with self.database:
            return(tbl_exists(self.database,table_name))
        
    def _get_table_info(self,table_name):
        with self.database:
            return(tbl_cols_get(self.database,table_name))
        
    def _get_table_list(self):
        with self.database:
            return(tbl_list(self.database))

    
class DatabaseCreateTable(DatabaseBase):
    @classmethod
    def create(cls,database_name,tbl_name,col_defn,delete_flag=False,
               tbl_pk_defn=[],runtime_path="."):

        cls1 = cls(database_name ,delete_flag,runtime_path=runtime_path)
        cls1._create_table(tbl_name,col_defn,tbl_pk_defn)
        
    
    def _create_table(self,tbl_name,col_defn,tbl_pk_defn=[]):
        with self.database:
            tbl_create(self.database,tbl_name,col_defn,tbl_pk_defn)
            
    @classmethod
    def create_encoded_by_file(cls,filepath,**kwargs):
        #if kwargs.has_key('runtime_path') == True:
        #    setattr(cls,"runtime_path",kwargs['runtime_path'])
        #else:
        #    setattr(cls,"runtime_path",".")
        #if hasattr(cls,"runtime_path") == False:
        #    setattr(cls,"runtime_path",".")
            
        cls._parse_input_file(filepath,mandatory_fields=[
                                                 'delete_flag',
                                                 'database_name',
                                                 'table_name',
                                                 'column_defns'],
                                       **kwargs)    
            
        cls1 = cls(cls.database_name,cls.delete_flag,**kwargs)
        return(cls1._create_table(cls.table_name,cls.column_defns))
        
class DatabaseInsertRows(DatabaseBase):
    @classmethod
    def insert(cls,database_name,tbl_name,tbl_col_name,tbl_rows,
               delete_flag=False):
        cls1 = cls(database_name,delete_flag)
        return cls1._insert_rows(tbl_name,tbl_col_name,tbl_rows)
    
    @classmethod
    def insert_encoded_by_file(cls,filepath,**kwargs):
        rows = []

        cls._parse_input_file(filepath,
                              mandatory_fields=[
                                  'delete_flag',
                                  'decode_flag',
                                  'database_name',
                                  'table_name',
                                  'columns',
                                  'rows'],
                              **kwargs)
    
        cls1 = cls(cls.database_name,cls.delete_flag,**kwargs)
        return(cls1._insert_rows(cls.table_name,cls.columns,cls.rows))
    
    def _insert_rows(self,tbl_name,tbl_col_name,tbl_rows):
        with self.database:
            _,result = tbl_rows_insert(self.database,tbl_name,tbl_col_name,tbl_rows)
            return result
        
def usage():
    print 
    print "usage:"
    print "excel_database_util.py --accesstype      =create|insert|table_exists|table_list|table_info"
    print "                       --input_filename  =fullpath of config file"
    print "optional               --output_filename =fullpath of output file"
    print "optional               --runtime_path    =fullpath of runtime dir"

def parse_args(argv):
    
    mandatory_flags = ['--access_type','--input_filename']
    access_types = ['query','create','insert','table_exists','table_list','table_info','database_exists']
    
    try:
        opts, args = getopt(argv[1:], "aiorf", ["access_type=", "input_filename=","output_filename=","runtime_path=","result_file="])
        for flag in mandatory_flags:
            if flag not in dict(opts).keys():
                raise GetoptError(flag,"needs to be present")
            
        man_config = {} # mandatory flaags, hold the resulting, parsed flags
        opt_config = {} # optional flags
        
        for flag, value in opts:
            if flag in ("-a", "--access_type"):
                if value not in access_types:
                    raise GetoptError(flag + " value not in " + str(access_types))
            elif flag in ("-i", "--input_filename") or flag in ("-r", "--runtime_path"):
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
        
        if config['access_type'] == "query":
            _query =  DatabaseQueryTable.query_encoded_by_file(config['input_filename'],**opt_config)
            print "$$".join(["^".join(_row) for _row in _query])
        elif config['access_type']== "create":
            print DatabaseCreateTable.create_encoded_by_file(config['input_filename'],**opt_config)
        elif config['access_type'] == "insert":
            print DatabaseInsertRows.insert_encoded_by_file(config['input_filename'],**opt_config)
        elif config['access_type'] == "table_exists":
            print DatabaseMisc.table_exists_by_file(config['input_filename'])
        elif config['access_type'] == "table_list":
            print DatabaseMisc.get_table_list_by_file(config['input_filename'])
        elif config['access_type'] == "table_info":
            _table_info = DatabaseMisc.get_table_info_by_file(config['input_filename'])
            print "$$".join([attr+"^"+val for attr,val in _table_info])
        elif config['access_type'] == "database_exists":
            print DatabaseMisc.table_exists_by_file(config['input_filename'])
        else:
            log.log(PRIORITY.FAILURE,msg="flag ["+ config['access_type'] +"] not recognized")
            
    except Exception,e:
        log.log(PRIORITY.FAILURE,msg="an error occurred ["+e.__class__.__name__+"] [" + e.message+"]")