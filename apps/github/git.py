from github import Github, Commit, AuthenticatedUser, Repository

from misc_utils import os_file_to_string
from misc_utils import uuencode

GIT_OAUTH_TOKEN = "c780495399d2f2daddebea046fe57215b90ce4df"
GIT_OAUTH_TOKEN_REPO_DEL_ONLY = "a8581d7c86090176ca272aaad168f7d3767c9e93"

# using username and password
#g = Github("burtnolej@googlemail.com", "natwest1")


# Then play with your Github objects:
#for repo in g.get_user().get_repos():
#    print(repo.name)

class GitBase(object):
    def __init__(self,token):
        self.token = token
        self.login()
            
    def login(self):
        self.github = GitBase._login(self.token)
        
    @staticmethod
    def _login(token):
        return Github(token)
        
class GitRepo(GitBase):
    
    def __init__(self,token,reponame):
        super(GitRepo,self).__init__(token)
        self.reponame = reponame
        self.get_repo()
        

        
    @classmethod
    def new(cls,token,username,reponame):
        cls1 = cls(token,"")
        user = GitRepo._get_user(cls1.github)
        cls1.repo = GitRepo._create_repo(user,reponame)
        return cls1
    
    @classmethod
    def delete(cls,token,reponame):
        cls1 = cls(token,reponame)
        cls1.delete_repo()

    def get_repo(self):
        self.repo = GitRepo._get_repo(self.github,self.reponame)
        
    def delete_repo(self):
        GitRepo._delete_repo(self.repo)
        
    @staticmethod
    def _get_repo(github,reponame):
        return github.get_repo(reponame)
    
    @staticmethod
    def _create_repo(gituser,reponame):
        return gituser.create_repo(reponame)
    
    @staticmethod
    def _get_user(github):
        return github.get_user()
    
    @staticmethod
    def _delete_repo(repo):
        return repo.delete()
    
class GitCommit(GitRepo):
    
    def __init__(self,token,reponame,files):
        super(GitCommit,self).__init__(token,reponame)
        self.files = files
    
    @staticmethod
    def _create_git_blob_of_file(filename,repo):
        file_str = os_file_to_string(filename)
        return repo.create_git_blob(uuencode(file_str),"utf-8")

    self.repo.create_git_blob


if __name__ == "__main__":
    repo = GitRepo(GIT_OAUTH_TOKEN,"quadviewer")
    
    #repo = GitRepo.new(GIT_OAUTH_TOKEN,"burtnolej","foobar")
    
    #repo = GitRepo.delete(GIT_OAUTH_TOKEN_REPO_DEL_ONLY,"foobar")
    