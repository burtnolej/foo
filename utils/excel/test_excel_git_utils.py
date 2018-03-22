import sys
import unittest
from utils.excel.excel_git_utils import GitExcelHelper, log, PRIORITY
from utils.misc_basic.misc_utils import write_text_to_file, append_text_to_file, os_file_delete, \
     os_file_to_string, get_2darray_from_file, os_file_exists, \
     uuencode, uudecode, encode, decode
from utils.git.git_utils import GitBase, GitRepoHelper, GitCommitHelper
from os import getcwd,chdir

from os import path
ROOTDIR = path.dirname(path.realpath(__file__))

class Test_GitBase(unittest.TestCase):
    def setUp(self):
        self.cwd = getcwd()
        chdir(ROOTDIR) # force the working dir to be ROOTDIR (as when called via testrunner this may not be the case
        self.commit_message = 'foobar'
        self.gitrootpath = "C:\\Users\\burtnolej\\testpygithub\\"
        self.commit_files = ["C:\\Users\\burtnolej\\testpygithub\git_test.txt",
                             "C:\\Users\\burtnolej\\testpygithub\git_test2.txt",
                             "C:\\Users\\burtnolej\\testpygithub\git_test3.txt"]
        
        
        self.token = GitBase._get_token()
        self.github = GitBase._login(self.token)
        self.reponame = "testpygithub"
        self.username = "burtnolej"
        self.runtime_path = "C:\\Users\\burtnolej"
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        chdir(self.cwd)
        os_file_delete(path.join(ROOTDIR,self.filename))
    
    
class Test_GitCommit(Test_GitBase):
    def setUp(self):
        super(Test_GitCommit,self).setUp()
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
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
        
class Test_GitCommit2Levels(Test_GitBase):
    ''' checkin files that are below the root level directory'''
    def setUp(self):
        super(Test_GitCommit2Levels,self).setUp()
        
        self.commit_files = self.commit_files + ["C:\\Users\\burtnolej\\testpygithub\\test\\git_test5.txt",
                                                 "C:\\Users\\burtnolej\\testpygithub\\test\\git_test6.txt"]
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        write_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_message:"+encode(self.commit_message,self.encoding) + "\n")
        append_text_to_file(self.filename,"commit_files:"+"$$".join([encode(_file,self.encoding) for _file in self.commit_files]) + "\n")
        
    def test_(self):
        repohelper  = GitExcelHelper.action_type(self.filename,"commit")
        commits = GitRepoHelper._get_commits(repohelper.gitcommit.repo)
        details = GitRepoHelper._get_commit_details(repohelper.gitcommit.repo,commits)
        self.assertEquals(details[0][4]['content'],'this is a test5')
        self.assertEquals(details[0][4]['path'],u'test/git_test5.txt')
        
class Test_GitCreateRepo(Test_GitBase):
    def setUp(self):
        super(Test_GitCreateRepo,self).setUp()
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        write_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"username:"+encode(self.username,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")

    def test_(self):
        self.repo  = GitExcelHelper.action_type(self.filename,"create_repo").repo
        self.assertEqual(self.repo.name,self.reponame)
    
class Test_GitHistory(Test_GitBase):
    def setUp(self):
        super(Test_GitHistory,self).setUp()
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        self.user = GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)        
        write_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
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

class Test_GitCreateRepo_ChangeRunTimePath(Test_GitBase):
    def setUp(self):
        super(Test_GitCreateRepo_ChangeRunTimePath,self).setUp()
        self.filename = "uupyshell.txt"
        self.encoding = "uu"
        write_text_to_file(self.filename,"token:"+encode(self.token,self.encoding) + "\n")
        append_text_to_file(self.filename,"reponame:"+encode(self.reponame,self.encoding) + "\n")
        append_text_to_file(self.filename,"username:"+encode(self.username,self.encoding) + "\n")
        append_text_to_file(self.filename,"gitrootpath:"+encode(self.gitrootpath,self.encoding) + "\n")

    def test_(self):
        self.repo = GitExcelHelper.action_type(self.filename,"create_repo",runtime_path="C:\\Users\\burtnolej\\").repo
        self.assertTrue(os_file_exists("C:\\Users\\burtnolej\\python_log.txt"))
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit2Levels))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitHistory))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo_ChangeRunTimePath))
    unittest.TextTestRunner(verbosity=2).run(suite)