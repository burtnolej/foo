import sys
import unittest
from excel_git_utils import GitExcelHelper, log, PRIORITY
from misc_utils import write_text_to_file, append_text_to_file, os_file_delete, \
     os_file_to_string, get_2darray_from_file, os_file_exists, \
     uuencode, uudecode, encode, decode
from git_utils import GitBase, GitRepoHelper, GitCommitHelper

class Test_GitCommit(unittest.TestCase):
    def setUp(self):
        self.commit_message = 'foobar'
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        self.commit_files = ["C:\\Users\\burtnolej\\testpygithub\git_test.txt",
                             "C:\\Users\\burtnolej\\testpygithub\git_test2.txt",
                             "C:\\Users\\burtnolej\\testpygithub\git_test3.txt"]
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_message:"+encode(self.commit_message,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_files:"+"$$".join([encode(_file,self.encoding) for _file in self.commit_files]) + "\n")
        
    def test_(self):
        repohelper  = GitExcelHelper.action_type(self.filename,"commit")
        commits = GitRepoHelper._get_commits(repohelper.gitcommit.repo)
        details = GitRepoHelper._get_commit_details(repohelper.gitcommit.repo,commits)

        self.assertEquals(details[0][1]['content'],'this is a test')
        self.assertEquals(details[0][3]['content'],'this is a test2')
        self.assertEquals(details[1][0]['content'],'# testpygithub')
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        #os_file_delete(self.filename
        
        
class Test_GitCommit2Levels(unittest.TestCase):
    ''' checkin files that are below the root level directory'''
    def setUp(self):
        self.commit_message = 'foobar'
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        self.commit_files = ["C:\\Users\\burtnolej\\testpygithub\\git_test.txt",
                             "C:\\Users\\burtnolej\\testpygithub\\git_test2.txt",
                             "C:\\Users\\burtnolej\\testpygithub\\test\\git_test5.txt",
                             "C:\\Users\\burtnolej\\testpygithub\\test\\git_test6.txt"]
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_message:"+encode(self.commit_message,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_files:"+"$$".join([encode(_file,self.encoding) for _file in self.commit_files]) + "\n")
        
    def test_(self):
        repohelper  = GitExcelHelper.action_type(self.filename,"commit")

        commits = GitRepoHelper._get_commits(repohelper.gitcommit.repo)
        details = GitRepoHelper._get_commit_details(repohelper.gitcommit.repo,commits)

        self.assertEquals(details[0][3]['content'],'this is a test5')
        self.assertEquals(details[0][3]['path'],u'test/git_test5.txt')
            
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        #os_file_delete(self.filename)
        
class Test_GitCreateRepo(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.username = "burtnolej"
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"username:"+encode(self.username,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")

    def test_(self):
        self.repo  = GitExcelHelper.action_type(self.filename,"create_repo")
        self.assertEqual(self.repo.repo.name,self.reponame)
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo.repo)
        os_file_delete(self.filename)
    
class Test_GitHistory(unittest.TestCase):
    def setUp(self):
        self.commit_message = 'foobar'
        self.commit_files = ["C:\\Users\\burtnolej\\testpygithub\git_test.txt",
                                 "C:\\Users\\burtnolej\\testpygithub\git_test2.txt",
                                 "C:\\Users\\burtnolej\\testpygithub\git_test3.txt"]
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_message:"+encode(self.commit_message,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_files:"+"$$".join([encode(_file,self.encoding) for _file in self.commit_files]) + "\n")

        GitCommitHelper.commit(self.token,self.reponame,self.commit_files,self.commit_message)
        
    def test_(self):    
        repohelper = GitExcelHelper.action_type(self.filename,"history")
        
        self.assertEquals(repohelper.commit_history[0][0]['content'],'this is a test')
        self.assertEquals(repohelper.commit_history[0][2]['content'],'this is a test2')
        self.assertEquals(repohelper.commit_history[1][0]['content'],'# testpygithub')

    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        #os_file_delete(self.filename)

class Test_GitHistory_Large(unittest.TestCase):
    def setUp(self):

        self.token = GitBase._get_token()
        self.reponame = "hungrycrayon"
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")
        
    def test_(self):    
        repohelper = GitExcelHelper.action_type(self.filename,
                                                "history",
                                                getcontent=False,
                                                limit=10)
        print repohelper.commit_history
        
    def tearDown(self):
        os_file_delete(self.runtime_path + "\\" + self.filename)

class Test_GitCreateRepo_ChangeRunTimePath(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        
        # create a new repo in GitHub
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.username = "burtnolej"
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"username:"+encode(self.username,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")

    def test_(self):
        self.gitexcephelper  = GitExcelHelper.action_type(self.filename,"create_repo",runtime_path="C:\\Users\\burtnolej\\")
        self.assertTrue(os_file_exists("C:\\Users\\burtnolej\\python_log.txt"))
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.gitexcephelper.repo)
        #os_file_delete(self.runtime_path + "\\" + self.filename)
        del self.gitexcephelper
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit2Levels))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitHistory))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo_ChangeRunTimePath))
    
    # this test pulls the enttire history from a large repo. Just to show that you can
    # not a test that is always necessary so uncomment as needed
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitHistory_Large))
    unittest.TextTestRunner(verbosity=2).run(suite)