import sys
import unittest
from excel_git_utils import GitExcelHelper, log, PRIORITY
from misc_utils import write_text_to_file, append_text_to_file, os_file_delete, \
     os_file_to_string, get_2darray_from_file, \
     uuencode, uudecode
from git_utils import GitBase, GitRepoHelper

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
        gitexcel  = GitExcelHelper.commit(self.filename)
    
        commits = GitRepoHelper._get_commits(gitexcel.gitcommit.repo)
        details = GitRepoHelper._get_commit_details(gitexcel.gitcommit.repo,commits)
    
        self.assertEquals(details[0][0]['content'],'this is a test')
        self.assertEquals(details[0][2]['content'],'this is a test2')
        self.assertEquals(details[1][0]['content'],'# testpygithub')
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        os_file_delete(self.filename)
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommit))
    unittest.TextTestRunner(verbosity=2).run(suite)