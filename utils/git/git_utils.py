from github import Github, Commit, AuthenticatedUser, Repository, \
     InputGitTreeElement, Commit, GitTreeElement, GitCommit, GithubObject
from utils.misc_basic.misc_utils import encode,decode, b64decode
from utils.misc_basic.misc_utils import os_file_to_string
from types import StringType, ListType

GIT_TOKEN_FILE = "C:\\Users\\burtnolej\\.gittoken"

class GitBase(object):
    def __init__(self,token):
        self.token = token
        self.login()
        self.user = self._get_user(self.github)
            
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
    
class GitRepoHelper(GitBase):
    
    ''' PUBLIC --------------------------------------------------------- '''

    def __init__(self,token,reponame):
        super(GitRepoHelper,self).__init__(token)
        self.reponame = reponame
        if reponame != "":
            self.repo = self._get_repo(self.user,self.reponame)

    @classmethod
    def new(cls,token,username,reponame):
        cls1 = cls(token,"")
        user = GitRepoHelper._get_user(cls1.github)
        cls1.repo = GitRepoHelper._create_repo(user,reponame,
                                         auto_init=True)
        return cls1
    
    @classmethod
    def history(cls,token,reponame,**kwargs):
        cls1 = cls(token,reponame)
        cls1.get_commit_history(**kwargs)
        return cls1
    
    @classmethod
    def delete(cls,token,reponame):
        cls1 = cls(token,reponame)
        cls1._delete_repo(cls1.repo)
        return cls1
        
    ''' PUBLIC --------------------------------------------------------- '''
        
    def get_commit_history(self,**kwargs):
        commits = self._get_commits(self.repo)
        self.commit_history = self._get_commit_details(self.repo,commits,**kwargs)
        
    ''' PRIVATE ------------------------------------------------------ '''
                    
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
    def _get_commit_git_tree(repo,commit):
        """ for a given commit, recursively get all the files within the corresponding tree
        :param repo: Repository
        :param commit: GitCommit
        :rtype:list of GitTreeElements
        """
        return repo.get_git_tree(commit.sha,True).tree
        
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
    def _get_last_commit(repo):
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
    def _get_git_rel_filepath(reponame,filepaths,gitrootpath):
        """ git filenames are relative to the root i.e vba\tmp.bas whereas input files
        are absolute i.e C:\Users\burtnolej\Documents\GitHub\quadviewer\vba\tmp.bas
        :param filepath: string or list of abs path of file the be checked in
        :param gitrootpath: top of git repository
        :rtype: string: path relative to git root
        """
        if isinstance(filepaths,ListType) == False:
            filepaths = [filepaths]
        
        if gitrootpath.endswith("\\") == False:
            gitrootpath += "\\"        
            
        for i in range(len(filepaths)):
            filepaths[i] = filepaths[i].replace(gitrootpath,"")
            
            # need to flip slashed to conform with unix syntax that GitHub expects
            filepaths[i] = filepaths[i].replace("\\","/")
        return filepaths
        
    @staticmethod
    def _get_files(repo):
        """ given a repo, get the latest version of all files in the head
        :param repo: Repository
        :rtype:list of files
        """
        tree = GitRepoHelper._get_last_commit(repo)._tree.value.tree
        return [_git_tree_element.path for _git_tree_element in tree]

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
    def _get_blob(repo,sha):
        """ get the Blob for a give hash reference
        :param repo: Repository, that contains the blob
        :param sha: string, hash value
        :rtype:GitBlob
        """
        return repo.get_git_blob(sha) 
        
    @staticmethod
    def _get_commits(repo,page_limit=1):
        """ get a simple list of Commit objects
        :param repo: Repository, repo object that you want the commits for
        :rtype: List of Commit objects
        """
        results = []
        i=0
        _commits = repo.get_commits().get_page(i)
        while _commits != [] and i < page_limit:
            _results = [repo.get_git_commit(_commit.sha) for _commit in _commits]
            results += _results
            i+=1
            _commits = repo.get_commits().get_page(i)
        return results

    @staticmethod
    def _get_commit_details(repo,commits,limit=3,getcontent=True):
        details = []
        if len(commits) < limit:
            limit = len(commits)
            
        #for _commit in commits:
        for i in range(limit):
            files = []
            _commit = commits[i]

            for _tree in GitRepoHelper._get_commit_git_tree(repo,_commit):
                try:
                    content = GitRepoHelper._get_file_content(repo,_tree)
                    detail = {'sha'           : _tree.sha,
                              'message'       : _commit.message ,
                              'path'          : _tree.path,
                              'last_modified' : _commit.last_modified ,
                              'author'        : _commit.author}   
                
                    if getcontent==True:
                        detail['content'] = b64decode(content)
                    files.append(detail)
                    
                except:
                    #print "could not retrieve",repo,_tree
                    pass
            #print "retreived details for",_commit.last_modified,str(i),"/",str(limit)
            details.append(files)
        return details
        
    @staticmethod
    def _get_commit(repo,sha):
        return repo.get_commit(sha)
    
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
    
                
class GitCommitHelper(GitRepoHelper):    
    @classmethod
    def commit(cls,token,reponame,filenames,message = ""):
        cls1 = cls(token,reponame)
        parents = [cls1._get_last_commit(cls1.repo)]
        base_tree = parents[0]._tree.value
        
        tree =  cls1._create_input_tree_multi(filenames,cls1.repo,
                                              base_tree=base_tree)
        
        cls1.last_commit = cls1._create_commit(cls1.repo,
                                         message,
                                         tree,
                                         parents)
        headref = cls1._get_ref(cls1.repo)
        headref.edit(cls1.last_commit.sha)
        return cls1
        
    @staticmethod
    def _create_commit(repo,message,tree,parents):
        """ "commit" files to git (by creating a GitCommit objec
        :param message :string: commentary
        :param repo : Repository
        :param tree : GitTreeElement
        :param parents: list of sha's (usually the last commit)
        """
        return repo.create_git_commit(message,tree,parents)
        
    @staticmethod
    def _create_input_tree(filename,repo,
                           base_tree=GithubObject.NotSet,
                           mode="100644"):
        """ generate a GitTreeElement for a file (a Git commit is 1 or more GitTreeElements)
        :param filename: full path of the file
        :repo : Repository
        :rtype: GitTreeElement
        """
        file_str = os_file_to_string(filename)
        return repo.create_git_tree([InputGitTreeElement(filename,mode,
                                                  "blob",file_str)],
                                    base_tree=base_tree)
    
    @staticmethod
    def _create_input_tree_multi(filenames,repo,
                                 base_tree=GithubObject.NotSet,
                                 mode="100644"):
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
        return repo.create_git_tree(tree_input,
                                    base_tree=base_tree)
                
                
if __name__ == "__main__":
    pass
            