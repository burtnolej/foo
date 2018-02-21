import sys
from misc_utils_log import Log, logger, PRIORITY
from os.path import basename
from os import listdir, remove
from shutil import move, copy
from collections import OrderedDict

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    
log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5,pidlogname=True,proclogname=False,
          config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),
                               ('module',20),('msg',-1)]))

class MoveFiles(object):
    ''' subclass need to overwrite _target_conv and _source_conv for there specific filename
    convertion functions (see trainerroad implementation)'''
    def __init__(self,sourcedir,targetdir,prefix="",moveflag=False):
        self.sourcedir = sourcedir
        self.targetdir = targetdir
        self.prefix = prefix
        self.moveflag = moveflag
        log.log(PRIORITY.INFO,msg="moveflag set to ["+str(moveflag)+"]")
        log.log(PRIORITY.INFO,msg="loking for files with prefix=["+prefix+"]")   
    
    def _target_conv(self,fname):
        return fname
    
    def _source_conv(self,fname):
        return fname    
    
    def fname_convertor(self,fname,ftype):
        ''' ftype can be either target or source '''
        if ftype not in ['target','source']:
            errmsg = "filename type must be either target or source and got [" + ftype + "]"
            log.log(PRIORITY.FAILURE,msg=errmsg)
            raise Exception(errmsg)
        
        return getattr(self,"_"+ftype+"_conv")(fname)
    
    def move_files(self,f=None):
        '''
        Operate on all the files in sourcedir that have a prefix of prefix.
        Either copy or move to targetdir; if moveflag=False then copy instead of move.
        Return the files that were operated on.
        If specified then move will run for just that file
        '''
        if f != None: 
            files=[f]
        else:
            files = listdir(self.sourcedir)
            
        resultfiles=[]
        for _file in files:
            if _file.startswith(self.prefix):
                
                _target = self.targetdir+"\\"+self.fname_convertor(_file,"target")
                _source = self.sourcedir+"\\"+self.fname_convertor(_file,"source")
                
                try:
                    if self.moveflag == True:
                        move(_source,_target)
                    else:
                        copy(_source,_target)
                    resultfiles.append(_target)
    
                except IOError, e:
                    log.log(PRIORITY.FAILURE,msg="failed to move/copy file ["+_source+"] to ["+_target+"] [" + +e.message + "]")
                else:
                    log.log(PRIORITY.INFO,msg="successfully to moved/copied file ["+_source+"] to ["+_target+"]")        
        return resultfiles