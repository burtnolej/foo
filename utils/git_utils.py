from github import Github, Commit, AuthenticatedUser, Repository, \
     InputGitTreeElement, Commit, GitTreeElement, GitCommit

from misc_utils import os_file_to_string
from misc_utils import uuencode,uudecode

GIT_TOKEN_FILE = "C:\\Users\\burtnolej\\.gittoken"

class MyGitBase(object):
    def __init__(self,token):
        self.token = token
        self.login()
            
    def login(self):
        self.github = self._login(self.token)
        
    @staticmethod
    def _login(token):
        """ login to GitHub and get a session object
        :param token:string (OAuth key)
        rtype:GitHub.MainClass
        """
        return Github(token)
    
    @staticmethod
    def _get_token():
        """ get a OAuth token for the GitHub server. This has likely been created
        on the github.com and saved to the text file
        :rtype:string
        """
        return os_file_to_string(GIT_TOKEN_FILE)
    
    @staticmethod
    def _get_user(github):
        """ get the user for a given github session
        :param github: GitHub.MainClass, associated with this session
        :rtype:AuthenticatedUser
        """
        return github.get_user()
    
class MyGitRepo(MyGitBase):
    ''' functions to help manage repos '''
    def __init__(self,token,reponame):
        super(MyGitRepo,self).__init__(token)
        self.reponame = reponame
        user = MyGitRepo._get_user(self.github)
        
        self.get_repo(user)

    @classmethod
    def new(cls,token,username,reponame):
        cls1 = cls(token,"")
        user = MyGitRepo._get_user(cls1.github)
        cls1.repo = MyGitRepo._create_repo(user,reponame,
                                         auto_init=True)
        return cls1
    
    @classmethod
    def delete(cls,token,reponame):
        cls1 = cls(token,reponame)
        cls1.delete_repo()

    def get_repo(self):
        self.repo = MyGitRepo._get_repo(self.user,self.reponame)

    def delete_repo(self):
        MyGitRepo._delete_repo(self.repo)    

    def get_git_commits(self):
        return self._get_git_commits(self.repo)
    
    def get_git_commit(self,sha):
        return self._get_git_commit(self.repo,sha)
    
    ''' ----------------------------------------------------------- '''
                    
    @staticmethod
    def _get_repo(user,reponame):
        """ get the Repository for a given user and name
        :param user: AuthenticatedUser, of the current sesssion 
        :param reponame: string
        :rtype:Repository
        """
        return user.get_repo(reponame)
        
    @staticmethod
    def _delete_repo(repo):
        """ delete a given Repository (need to have admin rights on the OAuth token)
        :param repo: Repository
        """
        return repo.delete()
    
    @staticmethod
    def _create_repo(gituser,reponame,**kwargs):
        """ create a repo on github.com
        :param gituser: AuthenticatedUser, of the current sesssion 
        :param reponame: string
        'param kwargs: accepts auto_init=True|False (true is required to initialize automatically by committing README.md
        :rtype:Repository
        """
        return gituser.create_repo(reponame,**kwargs)
    
    @staticmethod
    def _get_last_git_commit(repo):
        """ get the last commit (aka the HEAD)
        :param repo: Repositiory
        :rtype:GitCommit
        """
        last_commit_sha = repo.get_commits().get_page(0)[0].sha
        return repo.get_git_commit(last_commit_sha)

    @staticmethod
    def _get_file_path(commit):
        """ given a commit object get the file path it represents
        :param commit: Commit
        :rtype:string
        """
        return commit.tree.tree[0].path
    
    @staticmethod
    def _get_sha(commit):
        """ given a commit object get the sha it represents
        :param commit: Commit
        :rtype:string
        """
        return commit.tree.tree[0].sha
    
    @staticmethod
    def _get_file_content(repo,object):
        """ given an object get the file path it represents
        :param object: Commit or GitTreeElement
        :rtype:string
        """
        if isinstance(object,GitCommit.GitCommit):
            return repo.get_git_blob(object.tree.tree[0].sha).content
        elif isinstance(object,GitTreeElement.GitTreeElement):
            return repo.get_git_blob(object.sha).content
        else:
            raise Exception("_get_file_content needs either Commit or GitTreeElement got",object.__class__)            
    
    @staticmethod
    def _get_git_blob(repo,sha):
        """ get the Blob for a give hash reference
        :param repo: Repository, that contains the blob
        :param sha: string, hash value
        :rtype:GitBlob
        """
        return repo.get_git_blob(sha) 
        
    @staticmethod
    def _get_git_commits(repo):
        """ get a simple list of Commit objects
        :param repo: Repository, repo object that you want the commits for
        :rtype: List of Commit objects
        """
        return [repo.get_git_commit(_commit.sha) for _commit in repo.get_commits().get_page(0)]        
    
    @staticmethod
    def _get_commit_details(repo,commits):
        details = []
        for _commit in commits:
            files = []
            for _tree in _commit.tree.tree:                
                content = MyGitRepo._get_file_content(repo,_tree)
                files.append({
                    'sha'           : _tree.sha,
                    'message'       : _commit.message ,
                    'path'          : _tree.path,
                    'content'       : uudecode(content),
                    'last_modified' : _commit.last_modified ,
                    'author'        : _commit.author })
            details.append(files)
        return details
        
    @staticmethod
    def _get_git_commit(repo,sha):
        return repo.get_git_commit(sha)
    
    @staticmethod
    def _get_ref(repo,refname="heads/master"):
        """ get a reference object; default gets the head (the ref object is updated when we do a commit)
        :param repo: Repository
        :param refname : string, label for the reference
        :rtype : GitRef
        """
        return repo.get_git_ref(refname)
    
    @staticmethod
    def _get_ref_sha(repo,ref="heads/master"):
        return repo.get_git_ref(ref).object.sha
    
                
class MyGitCommitter(MyGitRepo):
    ''' functions to help with committing changes '''
    def __init__(self,token,reponame,files):
        super(GitCommit,self).__init__(token,reponame)
        self.files = files
    
    @staticmethod
    def _create_git_commit(repo,message,tree,parents):
        """ "commit" files to git (by creating a GitCommit objec
        :param message :string: commentary
        :param repo : Repository
        :param tree : GitTreeElement
        :param parents: list of sha's (usually the last commit)
        """
        return repo.create_git_commit(message,tree,parents)
        
    @staticmethod
    def _create_input_tree(filename,repo,mode="100644"):
        """ generate a GitTreeElement for a file (a Git commit is 1 or more GitTreeElements)
        :param filename: full path of the file
        :repo : Repository
        :rtype: GitTreeElement
        """
        file_str = os_file_to_string(filename)
        return repo.create_git_tree([InputGitTreeElement(filename,mode,
                                                  "blob",file_str)])
    
    @staticmethod
    def _create_input_tree_multi(filenames,repo,mode="100644"):
        """ generate a GitTreeElement for a file(s) (a Git commit is 1 or more GitTreeElements)
        :param filenames: list of full path of the file
        :repo : Repository
        :rtype: GitTreeElement
        """
        tree_input = []
        
        for filename in filenames:
            file_str = os_file_to_string(filename)
            tree_input.append(InputGitTreeElement(filename,mode,
                                                   "blob",file_str))
        return repo.create_git_tree(tree_input)
                
                
if __name__ == "__main__":
    pass