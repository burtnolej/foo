from misc_utils import  os_file_to_string, os_file_exists, append_text_to_file, \
     uudecode, uuencode, encode, decode
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
    def __init__(self,**kwargs):
        super(GitExcelBase,self).__init__(**kwargs)
        
    @classmethod   
    def _validate_reponame(self,**kwargs):
        return self._validate_field("reponame",**kwargs)

    @classmethod   
    def _validate_gitrootpath(self,**kwargs):
        return self._validate_filename("gitrootpath",**kwargs)

    @classmethod   
    def _validate_token(self,**kwargs):
        return self._validate_field("token",**kwargs)
        
    @classmethod   
    def _validate_username(self,**kwargs):
        return self._validate_field("username",**kwargs)
    
    @classmethod   
    def _validate_commit_message(self,**kwargs):
        return self._validate_field("commit_message",**kwargs)
    
    @classmethod   
    def _validate_commit_files(self,**kwargs):
        encoding = "unicode"
        if kwargs.has_key("encoding"):
            encoding = kwargs['encoding']
                    
        if hasattr(self,"commit_files") == False:
            log.log(PRIORITY.FAILURE,msg="commit_files must be passed")   
            return([-1]) 
        else:
            if self._validate_filename("commit_files",encoding=encoding) != [-1]:
                files= getattr(self,"commit_files")
                files = GitRepoHelper._get_git_rel_filepath(self.reponame,files,decode(self.gitrootpath[0],encoding))
                setattr(self,"commit_files",files)
            else:
                raise Exception("could not validate commit_files")
        
class GitExcelHelper(GitExcelBase):
    
    def __init__(self,filepath,mandatory_fields,**kwargs):
        super(GitExcelHelper,self).__init__(**kwargs)
        encoding = self._get_file_encoding(filepath)
        self._parse_input_file(filepath,
                               mandatory_fields,
                               encoding=encoding,
                               **kwargs)
        
        # working directory needs to be the gitroot so that the
        # rel file paths work correctly. GitHub requires paths relative to the repo root
        chdir(self.gitrootpath[0])

    @classmethod
    def action_type(cls,filepath,action,**kwargs):
        
        if action == "history":
            cls1 = cls(filepath,mandatory_fields=['token','reponame','gitrootpath'],**kwargs)
            cls1.commit_history = cls1._history(**kwargs)
        elif action == "commit":
            cls1 = cls(filepath,mandatory_fields=['token','reponame','gitrootpath','commit_message',
                                                  'commit_files'],**kwargs)
            cls1.gitcommit = cls1._commit()
        elif action == "create_repo":
            cls1 = cls(filepath,mandatory_fields=['token','reponame','username','gitrootpath'],**kwargs)
            cls1.repo = cls1._create_repo()
        elif action == "delete_repo":
            cls1 = cls(filepath,mandatory_fields=['token','reponame','gitrootpath'],**kwargs)
            cls1._delete()
        else:
            raise Exception("action needs to be history|create_repo|commit")
        return cls1
    
    def _history(self,**kwargs):
        return GitRepoHelper.history(self.token,self.reponame,**kwargs).commit_history

    def _delete(self):
        return GitRepoHelper.delete(self.token,self.reponame)
    
    def _create_repo(self):
        return GitRepoHelper.new(self.token,self.username,self.reponame).repo
        
    def _commit(self):
        return GitCommitHelper.commit(self.token,self.reponame,
                                      self.commit_files,self.commit_message)
    
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
            GitExcelHelper.action_type(input_filename,"commit")
        elif command_type == "create":
            GitExcelHelper.action_type(input_filename,"create_repo")
        elif command_type == "delete":
            GitExcelHelper.action_type(input_filename,"delete_repo")
        elif command_type == "history":
            geh = GitExcelHelper.action_type(input_filename,"history")
            output = []
            for _commit in geh.commit_history:
                for _file in _commit:
                    output.append("^".join([uuencode(_file['message']),
                                            uuencode(_file['path']),
                                            uuencode(_file['sha']),
                                            uuencode(_file['last_modified'])]))           
            print "$$".join(output)
                
    except Exception,e:
        log.log(PRIORITY.FAILURE,msg="an error occurred ["+e.__class__.__name__+"] [" + e.message+"]")