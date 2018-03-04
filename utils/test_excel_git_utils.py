import sys
import unittest
from excel_git_utils import GitExcelHelper, log, PRIORITY
from misc_utils import write_text_to_file, append_text_to_file, os_file_delete, \
     os_file_to_string, get_2darray_from_file, os_file_exists, \
     uuencode, uudecode
from git_utils import GitBase, GitRepoHelper, GitCommitHelper

class Test_GitCommit(unittest.TestCase):
    def setUp(self):
        self.commit_message = 'foobar'
        self.commit_files = ["C:\\Users\\burtnolej\\git_test.txt",
                             "C:\\Users\\burtnolej\\git_test2.txt",
                             "C:\\Users\\burtnolej\\git_test3.txt"]
        self.filename = "pyshell.txt"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+self.token + "\n")
        append_text_to_file(self.filename,"reponame:"+uuencode(self.reponame) + "\n")
        append_text_to_file(self.filename,"commit_message:"+uuencode(self.commit_message) + "\n")
        append_text_to_file(self.filename,"commit_files:"+"$$".join([uuencode(_file) for _file in self.commit_files]) + "\n")

    def test_(self):
        repohelper  = GitExcelHelper.action_type(self.filename,"commit")
        commits = GitRepoHelper._get_commits(repohelper.gitcommit.repo)
        details = GitRepoHelper._get_commit_details(repohelper.gitcommit.repo,commits)

        self.assertEquals(details[0][0]['content'],'this is a test')
        self.assertEquals(details[0][2]['content'],'this is a test2')
        self.assertEquals(details[1][0]['content'],'# testpygithub')
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        os_file_delete(self.filename)
        
class Test_GitCreateRepo(unittest.TestCase):
    def setUp(self):
        self.filename = "pyshell.txt"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.username = "burtnolej"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+self.token + "\n")
        append_text_to_file(self.filename,"reponame:"+uuencode(self.reponame) + "\n")
        append_text_to_file(self.filename,"username:"+uuencode(self.username) + "\n")

    def test_(self):
        self.repo  = GitExcelHelper.action_type(self.filename,"create_repo")
        self.assertEqual(self.repo.repo.name,self.reponame)
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo.repo)
        os_file_delete(self.filename)
    
class Test_GitHistory(unittest.TestCase):
    def setUp(self):
        self.commit_message = 'foobar'
        self.commit_files = ["C:\\Users\\burtnolej\\git_test.txt",
                             "C:\\Users\\burtnolej\\git_test2.txt",
                             "C:\\Users\\burtnolej\\git_test3.txt"]
        self.filename = "pyshell.txt"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+self.token + "\n")
        append_text_to_file(self.filename,"reponame:"+uuencode(self.reponame) + "\n")
        append_text_to_file(self.filename,"commit_message:"+uuencode(self.commit_message) + "\n")
        append_text_to_file(self.filename,"commit_files:"+"$$".join([uuencode(_file) for _file in self.commit_files]) + "\n")
        GitCommitHelper.commit(self.token,self.reponame,
                               self.commit_files,self.commit_message)
        

    def test_(self):    
        repohelper = GitExcelHelper.action_type(self.filename,"history")
        
        self.assertEquals(repohelper.commit_history[0][0]['content'],'this is a test')
        self.assertEquals(repohelper.commit_history[0][2]['content'],'this is a test2')
        self.assertEquals(repohelper.commit_history[1][0]['content'],'# testpygithub')

    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        os_file_delete(self.filename)

class Test_GitHistory_Large(unittest.TestCase):
    def setUp(self):

        self.token = GitBase._get_token()
        self.reponame = "hungrycrayon"
        self.filename = "pyshell.txt"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+self.token + "\n")
        append_text_to_file(self.filename,"reponame:"+uuencode(self.reponame) + "\n")
        
    def test_(self):    
        repohelper = GitExcelHelper.action_type(self.filename,
                                                "history",
                                                getcontent=False,
                                                limit=10)
        print repohelper.commit_history
        
    def tearDown(self):
        os_file_delete(self.filename)

class Test_GitCreateRepo_ChangeRunTimePath(unittest.TestCase):
    def setUp(self):
        self.filename = "pyshell.txt"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.username = "burtnolej"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+self.token + "\n")
        append_text_to_file(self.filename,"reponame:"+uuencode(self.reponame) + "\n")
        append_text_to_file(self.filename,"username:"+uuencode(self.username) + "\n")

    def test_(self):
        self.repo  = GitExcelHelper.action_type(self.filename,"create_repo",
                                                runtime_path="C:\\Users\\burtnolej\\")
        self.assertTrue(os_file_exists("C:\\Users\\burtnolej\\python_log.txt"))
        
                        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo.repo)
        os_file_delete(self.filename)
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitHistory))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo_ChangeRunTimePath))
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitHistory_Large))


    

    unittest.TextTestRunner(verbosity=2).run(suite)