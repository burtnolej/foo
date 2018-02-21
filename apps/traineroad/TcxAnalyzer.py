#!/usr/bin/python

from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, tbl_rows_get, tbl_query, tbl_col_add, tbl_rows_update, _quotestrs
    
from misc_utils_log import Log,logger,PRIORITY
from collections import OrderedDict
from types import DictionaryType
from tcxParser import TcxParser
import datetime

import sys

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"

log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5,pidlogname=True,
          proclogname=False)
log.config=OrderedDict([('now',12),('type',10),('class',15),('funcname',15),
                        ('module',20),('msg',-1)])

DEFAULT_BUCKETS = {'hr':((0,130),(131,140),(141,150),(151,160),(161,0)),
                   'watts':((0,220),(221,260),(261,300),(301,340),(340,0))}

class TcxAnalyzer(object):
    def __init__(self,databasename,buckets = DEFAULT_BUCKETS):
        self.databasename = databasename
        try:
            self.database = Database(self.databasename)
        except Exception,e:
            log.log(PRIORITY.FAILURE,msg="database ["+self.databasename+"] does not exist")
            exit()
            
        if isinstance(buckets,DictionaryType) == False:
            log.log(PRIORITY.FAILURE,msg="buckets need to be a dict of lists of tuples")
            exit()
            
        self.buckets = buckets
        
        log.log(PRIORITY.INFO,msg="TcxAnalyzer instance created [db="+databasename+"] [buckets="+str(buckets)+"]")
        
    def run(self,tskeys,tstypes):
        for _type in tstypes:
            for _file in tskeys:
                tcx_analyzer.get_source_data("data",'id',_type,'filename',"\""+_file+"\"")
                row = tcx_analyzer.get_ts_values()
                tcx_analyzer.persist_ts_values(_file,_type,row)
        
    @staticmethod
    def split_date(filename_date,dt_fmt):
        filename_datestr = filename_date.split("_")[0]
        filename_tr_id = filename_date.split("_")[1]
    
        dt = datetime.datetime.strptime(filename_datestr, '%Y%m%d')
        return(dt.strftime(dt_fmt))
        
        
    def get_source_data(self,tablename,pkcolname,valuecolname,predcolname,
                        predvalue):
        ''' query's the database and sets the following object attributes
        sourceid : list of row indexex and sourcedata : list of values
        also stores the predicates used to build the query '''
        querystr = "select "+pkcolname+","+valuecolname+" from "+tablename+" where "+predcolname+"="+predvalue
        
        try:
            with self.database:
                _,_rows,_ = tbl_query(self.database,querystr)
                if len(_rows[0]) == 0:
                    raise Exception("zero rows retreived for query ["+querystr+"]")
        except Exception,e:
            log.log(PRIORITY.FAILURE,msg="failed to retrieve source data for ["+predcolname+"]=["+ predvalue+"]["+e.message+"]")
            return False
            
        self.sourcepkcolname = pkcolname
        self.sourcevaluecolname = valuecolname
        self.sourcepredvalue = predvalue
        self.sourceid = [data[0] for data in _rows]
        self.sourcedata = [data[1] for data in _rows]
        
        log.log(PRIORITY.SUCCESS,msg="retrieved source data field ["+valuecolname+"] for ["+predvalue+"]")
        
        return True
            
    def get_high_value(self,ts=None):
        if ts == None:
            ts = self.sourcedata
        return max(ts)
    
    def get_low_value(self,ts=None):
        if ts == None:
            ts = self.sourcedata
        return min(ts)
    
    def get_average(self,ts=None):
        if ts == None:
            ts = self.sourcedata
        return sum(ts)/len(ts)
    
    def get_ts_values(self,ts=None):
        if ts == None:
            ts = self.sourcedata
            
        values = [self.get_low_value(),self.get_high_value(),self.get_average()]
        log.log(PRIORITY.SUCCESS,msg="calculated min,max,avg values for ts ["+self.sourcevaluecolname+"] for ["+self.sourcepredvalue+"]")
        
        return values
    
    def persist_ts_values(self,filename,tstype,row):
        
        tablename = self.sourcevaluecolname+"_values"
        col_defn=[("filename","string"),
                  ("min","integer"),
                  ("max","integer"),
                  ("avg","integer")]
        col_names=["filename","min","max","avg"]
        
        row.insert(0,filename)
        row = _quotestrs([row])
        
        with self.database:
            if tbl_exists(self.database,tablename) == False:
                logmsg = "creating ["+tablename+"] in db ["+self.databasename+"]"
                try:
                    tbl_create(self.database,tablename,col_defn)
                except Exception, e:
                    log.log(PRIORITY.FAILURE,msg=logmsg+" ["+e.message+"]")
                else:
                    log.log(PRIORITY.SUCCESS,msg=logmsg)
                    
            logmsg = "inserting row ["+str(row)+"] into table ["+tablename+"]"
            try:
                tbl_rows_insert(self.database,tablename,col_names,row)
            except Exception, e:
                log.log(PRIORITY.FAILURE,msg=logmsg+" ["+e.message+"]")
            else:
                log.log(PRIORITY.SUCCESS,msg=logmsg)
        

class TcxAnalyzerAddDerivedData(TcxAnalyzer):
    
    def add(self,
            source_tablename, # source data table 
            source_id_column, # source unique row id 
            source_value_column, # source data column in data table
            source_pred_column, # column name to limit data
            source_pred_value, # value to limit source data
            target_tablename,
            target_column,
            target_column_type, # integer or text
            **kwargs): # key word args to pass to derived calc func
        
        ''' if a value of rows is passed in kwargs, use that rather than calculating
        source data separately'''
        rows = []
        if kwargs.has_key('rows') == False:
            result = self.get_source_data(source_tablename,source_id_column,
                                 source_value_column,source_pred_column,source_pred_value)
            if result == True:
                rows  = self.create_values(**kwargs)
                
        else:
            rows = kwargs['rows']
            self.sourcepkcolname = source_id_column
            log.log(PRIORITY.INFO,msg="rows argument passed so suppressing create_value calc ["+str(rows)+"]")
            
            
        if rows != []:
            self.add_column_to_table(target_tablename,target_column,
                                     target_column_type,rows)

    def create_values(self,**kwargs):
        ''' to be overwritten; this is just a stub that creates copy of original data'''
        bucket_ts=[]
        for i in range(0,len(self.sourcedata)):
            _data = self.sourcedata[i]
            bucket_ts.append((self.sourceid[i],_data))
        return bucket_ts
        
    def add_column_to_table(self,table_name,column_name,column_type,rows,pkname=None):
        
        if pkname!=None:
            self.sourcepkcolname = pkname
        
        logmsg = "adding column ["+column_name+"] to table ["+table_name+"]"
        try:
            with self.database:
                tbl_col_add(self.database,table_name,column_name,column_type)
        except Exception,e :
            log.log(PRIORITY.FAILURE,msg=logmsg+" ["+e.message+"]")
        else:
            log.log(PRIORITY.SUCCESS,msg=logmsg)
                    
        with self.database:
            for i in range(0,len(rows)):
                
                if column_type == "string":
                    value = "\""+rows[i][1]+"\""
                else:
                    value = str(rows[i][1])
                    
                field = column_name            
                pkvalue = "\""+str(rows[i][0])+"\""
                pkfield = self.sourcepkcolname
            
                logmsg=" updating ["+field+"] to  ["+str(value)+"] where ["+pkfield+"] = ["+pkvalue+"]"
                
                try:
                    _,result = tbl_rows_update(self.database,table_name,[field,value,pkfield,pkvalue])
                except Exception, e:
                    log.log(PRIORITY.FAILURE,msg=logmsg+" ["+e.message+"]")
                else:
                    log.log(PRIORITY.SUCCESS,msg=logmsg)
    
class MyTcxDerived_Seconds(TcxAnalyzerAddDerivedData):
    def create_values(self,**kwargs):
        bucket_ts=[]
        for i in range(0,len(self.sourcedata)):
            _time = self.sourcedata[i]
            secs = TcxParser.time_to_seconds(_time)
            bucket_ts.append((self.sourceid[i],secs))
            
        return bucket_ts
    
class MyTcxDerived_Buckets(TcxAnalyzerAddDerivedData):
    def create_values(self,**kwargs):
        if kwargs.has_key('ts') == False:
            ts = self.sourcedata
        else:
            ts =  kwargs['ts'] 
            
        bucket_ts=[]
        #for datapoint in ts:
        for i in range(0,len(self.sourcedata)):
            
            if self.buckets.has_key(kwargs['tstype']) == False:
                log.log(PRIORITY.FAILURE,msg="could not find ts ["+kwargs['tstype']+"] for ts ["+self.sourcepredvalue+"]")
                continue
                
            for values in self.buckets[kwargs['tstype']]:
                minval,maxval = tuple(values)
                if minval == 0: minval = 0
                if maxval == 0: maxval = 1000
                if int(ts[i])>=minval and int(ts[i])<=maxval:
                    _id = self.sourceid[i]
                    bucket_ts.append((_id,"\""+"_".join(map(str,values))+"\""))
                    break
                
            log.log(PRIORITY.SUCCESS,msg="calculated ["+kwargs['tstype']+"] buckets for ts ["+self.sourcepredvalue+"]")
            
        return bucket_ts

        
if __name__ == "__main__":
    
    types = ['watts','hr']
    
    dbname = "trainerroad"
    database = Database(dbname)
    tcx_analyzer = TcxAnalyzer(dbname)
    
    #data_filenames = ['20180126_10638564']
    #metadata_filenames = ['20180126_10638564']
    
    #UNCOMMENT THIS IF WANT TO REFRESH ALL _VALUES DATA
    # get all distinct filenames
    with database:
        _,data_filenames,_ = tbl_query(database,"select distinct filename from data")
    data_filenames = [_filename[0] for _filename in data_filenames]
    
    # get all filenames that have a meta record
    with database:
        _,metadata_filenames,_ = tbl_query(database,"select distinct filename from metadata")
    metadata_filenames = [_filename[0] for _filename in metadata_filenames]
    
    # create hr_values and watts_values tables and data
    tcx_analyzer.run(metadata_filenames,types)
       
    #  adds duration in seconds columns to the metadata tables  
    tcx_add_col = MyTcxDerived_Seconds(dbname)
    for filename in metadata_filenames:
        tcx_add_col.add('metadata','filename','start','filename',"\""+filename+"\"",
                        'metadata','start_secs','integer')
        tcx_add_col.add('metadata','filename','end','filename',"\""+filename+"\"",
                        'metadata','end_secs','integer')
    
    #  adds buckets for hr and watts to the _values tables  
    tcx_add_col = MyTcxDerived_Buckets(dbname)
    for filename in data_filenames:
        tcx_add_col.add('watts_values','filename','avg','filename',"\""+filename+"\"",
                        'watts_values','watt_avg_bucket','integer',tstype='watts')
        tcx_add_col.add('hr_values','filename','avg','filename',"\""+filename+"\"",
                        'hr_values','hr_avg_bucket','integer',tstype='hr')
        
    # adds date component fields to the metadata table
    tcx_add_col = TcxAnalyzerAddDerivedData(dbname)
    date_config = {'month':'%B','year':'%Y','day':'%d'}
    for coln_name,dt_fmt in date_config.iteritems():
        results=[]
        for filename in metadata_filenames:        
            results.append([filename,tcx_add_col.split_date(filename,dt_fmt)])
        tcx_add_col.add_column_to_table('metadata',coln_name,'string',results,pkname='filename')
    