from misc_utils import  os_file_to_string, os_file_exists, append_text_to_file, \
     uudecode
from misc_utils_log import Log, logger, PRIORITY
from git_utils import GitCommitHelper, GitRepoHelper
from collections import OrderedDict
from excel_utils import ExcelBase
import sys
from os import chdir

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    
log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5)
log.config =OrderedDict([('now',12),('type',10),('class',30),('funcname',30),
                         ('module',20),('msg',-1),('today',8)])

class GitExcelBase(ExcelBase):
    @classmethod   
    def _validate_reponame(self):
        return self._validate_field("reponame")

    @classmethod   
    def _validate_token(self):
        return self._validate_field("token",decode=False)
        
    @classmethod   
    def _validate_commit_message(self):
        return self._validate_field("commit_message")
    
    @classmethod   
    def _validate_commit_files(self):
        files=[]
        if hasattr(self,"commit_files") == False:
            log.log(PRIORITY.FAILURE,msg="commit_files must be passed")   
            return([-1]) 
        else:
            for _filename in self.commit_files.split("$$"):
                if self._validate_filename(uudecode(_filename)) != [-1]:
                    files.append(uudecode(_filename))
        setattr(self,"commit_files",files)
        
class GitExcelHelper(GitExcelBase):
    
    @classmethod
    def commit(cls,filepath,**kwargs):
        cls._parse_input_file(filepath,mandatory_fields=['token','reponame','commit_message','commit_files'],
                                    **kwargs)
        cls1 = cls(cls.reponame,**kwargs)
        cls1._commit()
        return cls1
    
    def _commit(self):
        self.gitcommit = GitCommitHelper.commit(self.token,self.reponame,self.commit_files,self.commit_message)
    
if __name__ == "__main__":
    try:
        if len(sys.argv) < 3:
            log.log(PRIORITY.FAILURE,msg="requires access_type and file as args")
            exit()
         
        command_type = sys.argv[1]
        input_filename = sys.argv[2]
        kwargs = {}
        
        if len(sys.argv) == 4:
            kwargs = {'runtime_path':sys.argv[3]}
        
        log.log(PRIORITY.INFO,msg="executing  ["+str(sys.argv)+"]")
        
        if command_type == "commit":
            GitExcelHelper.commit(input_filename,**kwargs)
    except Exception,e:
        log.log(PRIORITY.FAILURE,msg="an error occurred ["+e.__class__.__name__+"] [" + e.message+"]")