import sys
from misc_utils import Singleton, Enumerate
from time import time, sleep
from inspect import stack, isclass, ismethod, isfunction
from os.path import basename
from datetime import datetime
from threading import currentThread
from collections import OrderedDict
import os
import os.path
from types import *

PRIORITY = Enumerate("FATAL,ERROR,FAILURE,INFO,SUCCESS,e5,e6,DEBUG,x8,x9,x0,INFUNC,OUTFUNC")

def logger(log):
    
    def decorator(func):
        def wrapper(*args, **kw):
            stime = time()
            log.log(PRIORITY.INFUNC,fargs=args,fkw=kw,funcname=func.__name__)
            result = func(*args, **kw)
            etime = round(time()-stime,4)
            log.log(PRIORITY.OUTFUNC,etime=etime,result=result,funcname=func.__name__)
            return result
        return wrapper
    return decorator
    

class Log():
    __metaclass__ = Singleton
    
    def __init__(self,logdir=".",pidlogname=False,proclogname=False,
                 cacheflag=False,verbosity=5,symlink="current",stats={},
                 pad=True,logname="python_log.txt",config=None,echoflag=False):
        '''
        logdir     : sets the path where the log gets written too
        pidlogname : if TRUE then appends the process id to the log file
        cacheflag  : if TRUE maintains all log messages in memory (self.cache)
        pad        : if FALSE then ignore any config padding specifications when formatting log
        logname    : prefix to log filename
        echoflag   : if TRUE then writes to STDOUT as well as the logs
        proclogname: if TRUE then appends the executable name to the log file
        symlink    : if not None then automatically symlinks the last file to value symlink is set to
        verbosity  : <5 is BASIC, < 10 is DEBUG, < 20 is VERBOSE which includes INFUNC and OUTFUNC
        '''
        
        self.logdir = logdir
        self.logname = logname
        self.symlink = symlink
        self.verbosity = verbosity
        self.pidlogname = pidlogname
        self.proclogname = proclogname
        self.cache = []
        self.cacheflag = cacheflag
        self.stats = stats
        self.config = config
        self.echoflag = echoflag
        self.pad = pad
        
        # set the defaulf config if one is not set.
        if self.config ==None:
            # add any new fields to the end so as not to break tests
            self.config = OrderedDict([('now',12),('thread',6),
                                       ('type',20),('module',20), 
                                       ('funcname',50),('etime',6),
                                       ('result',30),('fargs',30), 
                                       ('fkw',20),('logmesg',-1),('linenum',5)])
        '''
        # add the PID to the log filename
        if self.pidlogname == True:
            self.logname = self.logname + "." + str(self._getpid())
        
        # add the calling process to the log file name
        if self.proclogname == True:
            self.logname = self.logname + "." + basename(stack()[2][1])
        '''
        self.startlog()
    
    def startlog(self):
        fileattr = "a"

        # add the PID to the log filename
        if self.pidlogname == True:
            self.logname = self.logname + "." + str(self._getpid())
        
        # add the calling process to the log file name
        if self.proclogname == True:
            self.logname = self.logname + "." + basename(stack()[1][1])
            
        self.logfullpath = os.path.join(self.logdir,self.logname)
        
        if os.path.exists(self.logfullpath) == False:
            fileattr = "w"
        
        self.logfile = open(self.logfullpath,fileattr)
        
    @property
    def logdir(self):
        return self.__logdir
    
    @logdir.setter
    def logdir(self,val):
        self.__logdir = val
        
    @property
    def logname(self):
        return self.__logname
    
    @logname.setter
    def logname(self,val):
        self.__logname = val
        
    @property
    def logfullpath(self):
        return self.__logfullpath
    
    @logfullpath.setter
    def logfullpath(self,val):
        self.__logfullpath = val
    
    @property
    def symlink(self):
        return self.__symlink
    
    @symlink.setter
    def symlink(self,val):
        self.__symlink = val
        
    @property
    def verbosity(self):
        return self.__verbosity
    
    @verbosity.setter
    def verbosity(self,val):
        self.__verbosity = val
        
    @property
    def proclogname(self):
        return self.__proclogname
    
    @proclogname.setter
    def proclogname(self,val):
        self.__proclogname = val
        
    @property
    def cache(self):
        return self.__cache
    
    @cache.setter
    def cache(self,val):
        self.__cache = val

    @property
    def cacheflag(self):
        return self.__cacheflag
    
    @cacheflag.setter
    def cacheflag(self,val):
        self.__cacheflag = val
        
    @property
    def config(self):
        return self.__config
    
    @config.setter
    def config(self,val):
        self.__config = val

    @property
    def echoflag(self):
        return self.__echoflag
    
    @echoflag.setter
    def echoflag(self,val):
        self.__echoflag = val
      
    @property
    def pad(self):
        return self.__pad
    
    @pad.setter
    def pad(self,val):
        self.__pad = val
        
    def _getpid(self):
        thread = currentThread().name
        if thread == 'MainThread':
            return(os.getpid())
        return(thread)
        
    def __repr__(self):
        return ('log')
    
    def log_cache_reset(self):
        self.cache=[]
        
    def log_cat(self,grepargs=[]):
        from misc_utils_process import process_start, process_get_stdout
        
        self.logfile.close()        

        cmd = ["cat",self.logpath]
        p = misc_utils_process.process_start(cmd)
        logfile = misc_utils_process.process_get_stdout(p) 
        
        print        
        if grepargs <> []:
            cmd = ['grep'] + grepargs      
            p = misc_utils_process.process_start(cmd,stdin=True)
            
            for line in misc_utils_process.process_stdin(p,logfile):
                print line
        else:
            print logfile
          
    def _args_readable(self,args):
        ''' if the args contain fill object names like <module 'os' from '/usr/local/lib/python2.7/os.pyc'>
        make it more readable like os.pyc '''
        if type(args) is TupleType:
            for arg in args:
                if type(arg) not in [TupleType, StringType, IntType,DictionaryType,ListType, FloatType]:
                    newarg = arg.__class__.__name__
                    args = list(args)
                    args.remove(arg)
                    args.insert(0,newarg)
        
        elif type(args) is DictType:
            for k,v in args.iteritems():
                if type(v) not in [TupleType, StringType, IntType,DictionaryType,ListType, FloatType]:
                    if type(v) in [FunctionType,MethodType]:
                        newarg = v.__name__
                        args[k] = newarg
                    else:
                        try:
                            newarg = v.__name__
                        except:
                            newarg = v.__class__.__name__
                            
                        args[k] = newarg
                        
        return(args)
        
    def log(self,priority,**kwargs):
        # is this message of a sufficient priority to make it to the log instance
        if priority < self.verbosity or priority >= 100:
            
            logmesg = OrderedDict()
        
            # get the thread PID
            logmesg['thread'] = str(self._getpid())   
            logmesg['module'] = basename(stack()[1][1])
            
            # determine if caller was a instance method and get parent class or use the module name
            # remove self from the passed args if is an instancemethod
            _f_locals = stack()[1][0].f_locals
            if _f_locals.has_key('self'): 
                logmesg['class'] = _f_locals["self"].__class__.__name__
                _f_locals.pop('self')
            else:
                logmesg['class'] = ""
            
            # if funcname is passed in explicitly use that (its probably from the decorator logger)
            # this is a different level in the stack than if log.log called from a method
            if kwargs.has_key('funcname') == True:
                logmesg['funcname'] = kwargs['funcname']
            else:    
                logmesg['funcname'] = stack()[1][0].f_code.co_name
            
           # get the line num that created the log
            logmesg['linenum'] = stack()[1][2]

            # set the passed in args and values
            logmesg['args'] = str(_f_locals)
            if kwargs.has_key('msg') == True:
                logmesg['msg'] = kwargs['msg']
            else:
                logmesg['msg'] = ""
            
            # set up stats for this PID and create a ref to use
            if self.stats.has_key(logmesg['thread']) == False:
                _stats = self.stats[logmesg['thread']] = dict(etime=0)
            else:
                _stats = self.stats[logmesg['thread']]

            now = datetime.now().strftime("%H:%M:%S")
            today = datetime.now().strftime("%d%m%y")
                
            # setup stats for this given function if not called before
            if _stats.has_key(logmesg['funcname']) == False:
                _stats[logmesg['funcname']] = dict(no=0,etime=0)

            if priority == 11: # decorator start of function
                logmesg['type'] = "INFUNC"
                
                # pull out the args passed to the function
                fkw =kwargs['fkw']
                fargs = self._args_readable(kwargs['fargs'])
                
                # make them readable and put on to the output logmesg
                logmesg['fkw'] = str(zip(map(str,fkw.keys()),map(str,fkw.values())))
                logmesg['fargs'] = ",".join(map(str,fargs))
                
                # remove spaces to make output more searchable/testable
                logmesg['fargs'] =  logmesg['fargs'].replace(" ","").strip()
                logmesg['fkw'] =  logmesg['fkw'].replace(" ","")
                
                # remove of kwargs leaving only other info that needs to go to the log
                kwargs.pop('fkw')
                kwargs.pop('fargs')    

            elif priority == 12: # decorator end of function
                
                # add stats and build mesg
                _stats['etime'] += kwargs['etime']
                _stats[logmesg['funcname']]['etime'] += kwargs['etime']
                _stats[logmesg['funcname']]['no'] += 1
                
                logmesg['type'] = "OUTFUNC"
                logmesg['etime'] = str(kwargs['etime'])
                logmesg['result'] = str(kwargs['result'])
                
                # remove of kwargs leaving only other info that needs to go to the log
                kwargs.pop('etime')
                kwargs.pop('result')
            else:

                if priority in [0]:
                    logmesg['type'] = "FATAL"
                elif priority in [1]:
                    logmesg['type'] = "ERROR"      
                elif priority in [2]:
                    logmesg['type'] = "FAILURE"
                elif priority in [3]:
                    logmesg['type'] ="INFO"
                elif priority in [4]:
                    logmesg['type'] ="SUCCESS"                

                elif priority in [7]:
                    logmesg['type'] ="DEBUG"

                elif priority in [11]:
                    logmesg['type'] = "INFUNC"
                elif priority in [12]:
                    logmesg['type'] = "OUTFUNC"
                    
                else:
                    logmesg['type'] ="UNKNOWN"

            logmesg['now'] = ":".join(map(str,[now,datetime.now().microsecond/1000]))
            logmesg['today']=today
            kwargs = self._args_readable(kwargs)
            logmesg['logmesg'] = str(zip(map(str,kwargs.keys()),map(str,kwargs.values())))

            # build log mesg as specified in config
            output = []
            for name,size in self.config.iteritems():
                if logmesg.has_key(name):
                    
                    # set to -1 to not pad
                    if self.pad ==False: size = -1
                    
                    if size != -1:
                        if logmesg[name] <> None:
                            s = self.shrink(str(logmesg[name]),size)
                            output.append(s.ljust(size))
                        else:
                            output.append("None".ljust(size))
                    else:
                        output.append(logmesg[name])
                else:
                    output.append("".ljust(size))
            
            # keep copy of log messages in memory if specified
            if self.cacheflag == True:
                self.cache.append(output)
            
            # in case the file has been closed
            try:
                self.logfile = open(self.logfullpath,"a")
            except IOError:
                pass

            self.logfile.write("|".join(map(str,output))+"\n")
            self.logfile.flush()
            
            if self.echoflag ==True:
                print "|".join(output)+"\n"
            
            if logmesg['type'] == "FATALERROR":
                print "FATAL ERROR, exiting; check logs"
                exit()
                
            
    def shrink(self,s,size):
        ''' pull out middle chars to fit into desired width of log field '''
        if len(s) > size:
            _len = size/2
            s = s[:_len-1] + "*" +s[len(s)-_len:]
        return(s)

    def log_get_session_content(self):
        return(self.cache)
    
    def log_delete(self):
        os.remove(self.logpath)
            
    def log_clean(self):
        self.log_null()
        self.log_cache_reset()
        
    def log_null(self):
        from misc_utils_process import process_start
        try:
            self.logfile = open(self.logpath,"a")
        except IOError:
            pass
        
        cmd = ["nullfile.sh",self.logpath]
        p = misc_utils_process.process_start(cmd)  
        
        self.logfile.close()
        
    def logexists(self):
        return(os_file_exists(self.logpath))

    def log_get_session_num_entries(self):
        return(len(self.cache))
    
    def log_file_length(self):
        try:
            self.logfile = open(self.logpath,"r")
        except IOError:
            pass
        for i,l in enumerate(self.logfile):
            pass
        self.logfile.close()
        return(i)
    
    def close(self):
        self.cache = []
        self.stats={}
        self.logfile.close()
        
    def reset(self):
        Singleton._instances={}

    def __del__(self):
        self.logfile.close()
