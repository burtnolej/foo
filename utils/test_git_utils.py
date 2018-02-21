import sys
import unittest
from github import Github, Repository, InputGitTreeElement
from git_utils import GIT_OAUTH_TOKEN, GIT_OAUTH_TOKEN_REPO_DEL_ONLY,GitBase, GitRepo, GitCommit
from misc_utils import write_text_to_file, uuencode

class Test_GitBase_Login(unittest.TestCase):
    def test_(self):
        self.assertIsInstance(GitBase._login(GIT_OAUTH_TOKEN),Github)

class Test_GitRepo_GetRepo(unittest.TestCase):
    def setUp(self):
        self.github = GitBase._login(GIT_OAUTH_TOKEN)
    
    def test_(self):
        self.assertIsInstance(GitRepo._get_repo(self.github,"quadviewer"),Repository.Repository)
    
    def tearDown(self):
        del self.github
        
class Test_GitRepo_CreateRepo(unittest.TestCase):
    def setUp(self):
        self.github = GitBase._login(GIT_OAUTH_TOKEN)
    
    def test_(self):
        user = GitRepo._get_user(self.github)
        
        GitRepo._create_repo(user,"foobar",auto_init=True)
        #self.assertIsInstance(,Repository.Repository)
        
    def tearDown(self):
        del self.github
        
class Test_GitRepo_DeleteRepo(unittest.TestCase):
    def setUp(self):
        self.github = GitBase._login(GIT_OAUTH_TOKEN_REPO_DEL_ONLY)
    
    def test_(self):
        user = GitRepo._get_user(self.github)
        repo = GitRepo._get_repo(user,"quadviewer")
        GitRepo._delete_repo(repo)
        #GitRepo._create_repo(user,"foobar",auto_init=True)
        #self.assertIsInstance(,Repository.Repository)
        
    def tearDown(self):
        del self.github
        
class Test_GitCommit_CreateBlobOfTextFile(unittest.TestCase):
    def setUp(self):
        #self.user = self.g.get_user()
        #self.repo = self.user.get_repo("PyGithub")
        self.filename = "C:\\Users\\burtnolej\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        self.github = GitBase._login(GIT_OAUTH_TOKEN)
        self.user = GitRepo._get_user(self.github)
        self.repo = GitRepo._get_repo(self.user,"foobar")
        
    def test_(self):
         
        #t1 = self.repo.create_git_tree([InputGitTreeElement("test.txt",
        #                                                    "100644",
        #                                                    "blob",
        #                                                    content="File created by PyGithub")])
        #print self.repo.create_git_blob(uuencode("Blob created by PyGithub"), "utf-8")

        print  GitCommit._create_git_blob_of_file(self.filename,self.repo)
    
    def tearDown(self):
        pass
        
        

    
if __name__ == "__main__":

    #unittest.main()
    
    suite = unittest.TestSuite()
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitBase_Login))
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitRepo_GetRepo))
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitRepo_CreateRepo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitRepo_DeleteRepo))
    
    
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit_CreateBlobOfTextFile))
    
    
    unittest.TextTestRunner(verbosity=2).run(suite)
    
