#!/usr/bin/python

from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, tbl_rows_get
from misc_utils import os_file_exists
from misc_utils_file import MoveFiles
import xml.etree.ElementTree as xmltree
from datetime_util import MyDT
from os import listdir, environ
from os.path import join, splitext, split
from misc_utils import thisfuncname
from misc_utils_log import Log, logger, PRIORITY
from collections import OrderedDict

from types import IntType,StringType, FloatType
import sys

ns={'tcx':'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2',
    'ns3':'http://www.garmin.com/xmlschemas/ActivityExtension/v2'}   

__version__ = '0.1'
DOWNLOAD_DIR = "C:\\Users\\burtnolej\\Downloads"
#INPUT_FILE_DIR = environ["PYTHONAPPS"] + "\\apps\\trainerroad\\tcx_files"
INPUT_FILE_DIR = "C:\\Users\\burtnolej\\Documents\\GitHub\\hungrycrayon\\apps\\traineroad\\tcx_files"

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    
log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5,pidlogname=True,
          proclogname=False)
log.config=OrderedDict([('now',12),('type',10),('class',15),('funcname',15),
                        ('module',20),('msg',-1)])
class TcxParser(object):
    
    def __init__(self,input_files_dir,databasename="trainerroad",
                 tablename="trainerroad",verbosity=5):
        self.files = {}
        self.input_files_dir = input_files_dir
        self.databasename =databasename
        self.tablename =tablename
        log.verbosity = verbosity
        log.log(PRIORITY.INFO,msg="tcxParser istance created [db="+databasename+"] [input_dir="+input_files_dir+"]")
        
    def _get_secs(self,timestr):
        mydt = MyDT.str('US/Eastern',dt_str=timestr,dt_str_fmt='%Y-%m-%dT%H:%M:%SZ')
        return(mydt.secs)
    
    @logger(log)
    def mavg(self,arr,size,info=""):
        _arr = []
        
        end_range = len(arr)
        if len(arr) < size:
            end_range = size = len(arr)
            
        for i in range(size,end_range+1):
            _arr.append(sum(arr[i-size:i])/size)
                
        log.log(PRIORITY.SUCCESS,msg="calculated moving average for timeseries ["+info+"]")
        return _arr
    
    @logger(log)
    def avg(self,arr,size,info=""):
        _arr = []
        
        end_range = len(arr)
        if len(arr) < size:
            end_range = size + 1
            
        for i in range(0,end_range,size):
            
            if (i+size) > end_range:
                # if the last bucket is not exactly 'size' in size
                _arr.append(sum(arr[i:i+size])/(end_range-i))
            else:    
                _arr.append(sum(arr[i:i+size])/size)
        log.log(PRIORITY.SUCCESS,msg="calculated average for timeseries ["+info+"]")        
        return _arr
    
    @logger(log)
    def parse_tcx(self,filen, ns):
        
        try:
            trackpoints = xmltree.parse(filen).findall('.//tcx:Trackpoint',ns)
        except IOError, e:
            log.log(PRIORITY.FAILURE,msg="file not found: "+filen)
            return(-1)
            
        # get the time in secs of first Trackpoint so can calculate # of secs from start
        time = trackpoints[0].find('tcx:Time',ns)    
        start_time = self._get_secs(time.text) -1
    
        watts = []
        hr=[]
        
        for trackpoint in trackpoints:
            
            tpdict = {}
            heartratebpmvalue = distance = cadence = _watts = speed = -1
            
            distance = trackpoint.find('tcx:DistanceMeters',ns)
        
            cadence = trackpoint.find('tcx:Cadence',ns)
            if cadence != None:cadencevalue = int(cadence.text)
                                      
            heartratebpm = trackpoint.find('tcx:HeartRateBpm',ns)
            if heartratebpm != None: 
                heartratebpmvalue = int(heartratebpm.find('tcx:Value',ns).text)
            else:
                heartratebpmvalue = -1
                #log.log(PRIORITY.FAILURE,msg="could not find an element for HR [" + filen +"] setting to -1")
            
            _watts = trackpoint.find('.//ns3:Watts',ns)
            if _watts != None: 
                wattsvalue = int(_watts.text)
            else:
                wattsvalue  = -1
                #log.log(PRIORITY.FAILURE,msg="could not find an element for Watts in file [" + filen +"] setting to -1")
            
            speed = trackpoint.find('.//ns3:Speed',ns)
            if speed != None: speedvalue = round(float(speed.text),1)
            
            time = trackpoint.find('tcx:Time',ns)    
            mydt = MyDT.str('US/Eastern',dt_str=time.text,dt_str_fmt='%Y-%m-%dT%H:%M:%SZ')
            
            time_secs = self._get_secs(time.text)
            
            watts.append(wattsvalue)
            hr.append(heartratebpmvalue)
       
        log.log(PRIORITY.SUCCESS,msg="parsed TCX file ["+split(filen)[-1]+"] : ["+str(len(watts)) +"] trackpoints")
            
        return(watts,hr)
    
    @staticmethod
    def time_to_seconds(time):
        elements = time.split(":")
    
        hour=0
        # if the limit goes above an hour then the time is specified as HH:MM:SS instead
        # of MM:SS
        if len(elements) == 3: hour = elements.pop(0)
    
        min,sec =tuple(elements)

        return((int(min)*60)+int(sec)+(int(hour)*60*60))
        
    @logger(log)
    def get_limits_from_db(self,tablename):
        database = Database(self.databasename,testexists=True)  
        with database:
            _,rows,_ = tbl_rows_get(database,tablename)   
        
        self.limits = {}
        for _row in rows:
            start_hour = 0
            end_hour = 0
            
            new_file_name = _row[2]

            self.limits[new_file_name] = {}
            self.limits[new_file_name]['start'] = self.time_to_seconds(_row[0])
            self.limits[new_file_name]['end'] = self.time_to_seconds(_row[1])
            
        log.log(PRIORITY.SUCCESS,msg="limits retreived from database ["+self.databasename+"[ for files ["+",".join(self.limits.keys())+"]")
        
        return self.limits
    
    @logger(log)
    def process_files(self,bucket_size=10,summation_type="mavg",limits={}):
        
        for f in listdir(self.input_files_dir):
            self.files[f] = {}
            watts,hr = self.parse_tcx(self.input_files_dir+"\\"+f,ns)
            
            # limits database uses filename without extension as a key
            _f = f.split(".")[0]
            if limits.has_key(_f):
                start = limits[_f]['start']
                end= limits[_f]['end']
                
                watts = watts[start:end]
                hr = hr[start:end]
                
                log.log(PRIORITY.SUCCESS,msg="watts & hr ts limited to start=["+str(start)+"] and end=["+str(end)+"] for f ["+_f+"]")
                
            else:
                log.log(PRIORITY.FAILURE,msg="no limits found for file ["+_f+"]")

            if summation_type == None:
                pass
            else:
                self.files[f]['watts'+summation_type] = getattr(self,summation_type)(watts,bucket_size,info=f+":watts")
                self.files[f]['hr'+summation_type] = getattr(self,summation_type)(hr,bucket_size,info=f+":hr")
                
            self.files[f]["watts"] = watts
            self.files[f]["hr"] = hr
            
    def dump(self,f=None,summation_type="avg"):
        '''summation_type="" will dump all the trackpoints'''

        dumparr=[]
        idcount=0
        def _dump(f,idcount):
            if self.files.has_key(f) == False:
                log.log(PRIORITY.FAILURE,msg="file ["+f+"] does not exist in self.files")
                return -1
            elif self.files[f].has_key('watts'+summation_type) == False:
                log.log(PRIORITY.FAILURE,msg="timeseries [watts"+summation_type+"] does not exist in self.files["+f+"]")
                return -1
            elif self.files[f].has_key('hr'+summation_type) == False:
                log.log(PRIORITY.FAILURE,msg="timeseries [hr"+summation_type+"] does not exist in self.files["+f+"]")
                return -1
                
            watts = self.files[f]['watts'+summation_type]
            hr = self.files[f]['hr'+summation_type]
            
            for i in range(0,len(watts)):
                dumparr.append([str(idcount),str(i),str(watts[i]),str(hr[i]),
                                "\""+splitext(f)[0]+"\""])
                idcount += 1
                
            return idcount
        
        if f==None:
            filelist = listdir(self.input_files_dir)
        else:
            filelist = [f]
            
        for _f in filelist:
            idcount = _dump(_f,idcount)
            if idcount != -1:
                log.log(PRIORITY.SUCCESS,msg="retreived data for file ["+_f+"] with summation type["+summation_type+"]")
                
        return dumparr
    
    @logger(log)        
    def persist(self,f=None,
                column_defn=[("id","integer"),("bucket","integer"),("watts","integer"),
                             ("hr","integer"),("filename","text")],
                column_names=["id","bucket","watts","hr","filename"]
                ):
        
        database = Database(self.databasename)
        
        _rows = self.dump(f)
        
        with database:
            if tbl_exists(database,self.tablename) == False:
                tbl_create(database,self.tablename,column_defn)
                
            try:
                tbl_rows_insert(database,self.tablename,column_names,_rows)     
            except Exception,e:
                log.log(PRIORITY.FAILURE,msg="timseries persistence failed in db [" + database.name +"] ["+e.message+"]")
            else:   
                log.log(PRIORITY.SUCCESS,msg="persisted timseries in db [" + database.name +"]")

    @logger(log)
    def move_files(self,download_dir,input_file_dir,prefix,moveflag=False):
        tcx_move_files = TcxMoveFiles(DOWNLOAD_DIR,INPUT_FILE_DIR,"burtnolejusa-",moveflag=moveflag)
        tcx_move_files.move_files()
                
class TcxMoveFiles(MoveFiles):
    def _target_conv(self,fname):
        if len(fname.split("-")) != 8:
            log.log(PRIORITY.INFO,msg="do not recognize file name format using source name")
            _newfname = fname
        else:
            _,y,m,d,_,_,_,_id = fname.split("-")
            _newfname = y+m+d+"_"+_id
        return _newfname
    def _source_conv(self,fname):
        return fname  
    
if __name__ == "__main__":


    ''' make sure tcx_files dir is empty before running; app will only parse files that are in the
    download directory '''
    
    kwargs={}
    if len(sys.argv) == 2:
        kwargs['f'] = sys.argv[1]
        
    tcx_move = TcxMoveFiles(DOWNLOAD_DIR,INPUT_FILE_DIR,prefix="burtnolejusa-",
                            moveflag=True)
    tcx_move.move_files(**kwargs)
    
    tcxparser = TcxParser(INPUT_FILE_DIR,databasename="trainerroad",tablename="data")
    
    limits = tcxparser.get_limits_from_db('metadata')
    tcxparser.process_files(summation_type="avg",bucket_size=10,limits=limits)
    tcxparser.persist()
    
    


