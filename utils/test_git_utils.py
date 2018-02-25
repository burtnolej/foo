import sys
import unittest
from github import Github, Repository, InputGitTreeElement, GitBlob, GitTree, \
     Commit, GitCommit, GitRef

from git_utils import MyGitBase, MyGitRepo, MyGitCommitter
from misc_utils import write_text_to_file, uuencode, uudecode
    
class Test_GitLogin(unittest.TestCase):
    
    def setUp(self):
        self.token = MyGitBase._get_token()
        self.reponame = "testpygithub"
        
    def test_(self):
        self.assertIsInstance(MyGitBase._login(self.token),Github)
        
class Test_GitCreateRepo(unittest.TestCase):
    def setUp(self):
        self.token = MyGitBase._get_token()
        self.reponame = "testpygithub"
        self.github = MyGitBase._login(self.token)
        self.user = MyGitBase._get_user(self.github)
    
    def test_(self):
        self.repo = MyGitRepo._create_repo(self.user,self.reponame)
        self.assertIsInstance(self.repo,Repository.Repository)
        
    def tearDown(self):
        MyGitRepo._delete_repo(self.repo)
        del self.github
        
class Test_MyGitBase(unittest.TestCase):
    def setUp(self):
        self.token = MyGitBase._get_token()
        self.reponame = "testpygithub"
        self.github = MyGitBase._login(self.token)
        self.user = MyGitBase._get_user(self.github)
        self.repo = MyGitRepo._create_repo(self.user,self.reponame,auto_init=True)
        
    def tearDown(self):
        MyGitRepo._delete_repo(self.repo)
        del self.github
    
class Test_GitGetRepo(Test_MyGitBase):
    def test_(self):
        newrepo = MyGitRepo._get_repo(self.user,self.reponame)
        self.assertIsInstance(newrepo ,Repository.Repository)
                            
class Test_GitCCreateInputTree(Test_MyGitBase):
    def setUp(self):
        super(Test_GitCCreateInputTree,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        
    def test_(self):
        tree =  MyGitCommitter._create_input_tree(self.filename,self.repo)
        self.assertIsInstance(tree,GitTree.GitTree)
        
class Test_GitCCreateInputTreeMultipleFiles(Test_MyGitBase):
    def setUp(self):
        super(Test_GitCCreateInputTreeMultipleFiles,self).setUp()
        self.filenames = ["C:\\Users\\burtnolej\\git_test.txt",
                          "C:\\Users\\burtnolej\\git_test2.txt",
                          "C:\\Users\\burtnolej\\git_test3.txt"]
        
    def test_(self):
        tree =  MyGitCommitter._create_input_tree_multi(self.filenames,self.repo)
        self.assertIsInstance(tree,GitTree.GitTree)

class Test_GitGetCommit(Test_MyGitBase):
    def test_(self):
        gitcommit = MyGitRepo._get_last_git_commit(self.repo)
        self.assertIsInstance(gitcommit,GitCommit.GitCommit)
        
class Test_GitCCreateCommit(Test_MyGitBase):
    def setUp(self):
        super(Test_GitCCreateCommit,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        self.tree =  MyGitCommitter._create_input_tree(self.filename,self.repo)
        self.parents = [MyGitCommitter._get_last_git_commit(self.repo)]
        
    def test_(self):
        git_commit = MyGitCommitter._create_git_commit(self.repo,
                                                       "commit via pyyhon api",
                                                       self.tree,self.parents)
        self.assertIsInstance(git_commit,GitCommit.GitCommit)

class Test_GitGetRef(Test_MyGitBase):
    def test_(self):
        #ref = self.repo.get_git_ref("heads/master")
        ref = MyGitRepo._get_ref(self.repo)
        self.assertIsInstance(ref,GitRef.GitRef)
        
class Test_GitUpdateRefs(Test_MyGitBase):
    def setUp(self):
        super(Test_GitUpdateRefs,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        self.tree =  MyGitCommitter._create_input_tree(self.filename,self.repo)
        self.parents = [MyGitCommitter._get_last_git_commit(self.repo)]
        
        self.git_commit = MyGitCommitter._create_git_commit(self.repo,
                                                            "commit via pyyhon api",self.tree,self.parents)
        self.headref = MyGitCommitter._get_ref(self.repo)
        
    def test_(self):
        self.headref.edit(self.git_commit.sha)
        self.assertEquals(self.git_commit.sha,MyGitCommitter._get_ref_sha(self.repo))  
        
class Test_GitMultiFileCommit(Test_MyGitBase):
    def setUp(self):
        super(Test_GitMultiFileCommit,self).setUp()
        self.filenames = ["C:\\Users\\burtnolej\\git_test.txt",
                              "C:\\Users\\burtnolej\\git_test2.txt",
                              "C:\\Users\\burtnolej\\git_test3.txt"]
        self.tree =  MyGitCommitter._create_input_tree_multi(self.filenames,self.repo)
        self.parents = [MyGitCommitter._get_last_git_commit(self.repo)]
        self.git_commit = MyGitCommitter._create_git_commit(self.repo,
                                                            "commit via pyyhon api",self.tree,self.parents)
        self.headref = MyGitCommitter._get_ref(self.repo)
        
    def test_(self):
        self.headref.edit(self.git_commit.sha)
        self.assertEquals(self.git_commit.sha,MyGitCommitter._get_ref_sha(self.repo)) 
        
class Test_GitGetCommitDetails(Test_MyGitBase):
    def test_(self):
        gitcommit = MyGitRepo._get_last_git_commit(self.repo)
        self.assertEquals(MyGitRepo._get_file_path(gitcommit),"README.md")
        content = MyGitRepo._get_file_content(self.repo,gitcommit)
        self.assertEquals(uudecode(content),"# testpygithub")

class Test_GitCommitBase(unittest.TestCase):
    def setUp(self):
        self.token = MyGitBase._get_token()
        self.reponame = "testpygithub"
        self.github = MyGitBase._login(self.token)
        self.user =  MyGitBase._get_user(self.github)
        self.repo = MyGitRepo._create_repo(self.user,self.reponame,auto_init=True)
        
        self.filenames = ["C:\\Users\\burtnolej\\git_test.txt",
                              "C:\\Users\\burtnolej\\git_test2.txt",
                                  "C:\\Users\\burtnolej\\git_test3.txt"]
        self.tree =  MyGitCommitter._create_input_tree_multi(self.filenames,self.repo)
        self.parents = [MyGitCommitter._get_last_git_commit(self.repo)]
        self.new_git_commit = MyGitCommitter._create_git_commit(self.repo,"commit via pyyhon api",self.tree,self.parents)
        self.headref = MyGitCommitter._get_ref(self.repo)
        self.headref.edit(self.new_git_commit.sha)
        
    def tearDown(self):
        MyGitRepo._delete_repo(self.repo)
        del self.github
        
class Test_GitGetCommits(Test_GitCommitBase):
    def test_(self):
        commits = MyGitRepo._get_git_commits(self.repo)
        details = MyGitRepo._get_commit_details(self.repo,commits)

        self.assertEquals(details[0][0]['content'],'this is a test')
        self.assertEquals(details[0][2]['content'],'this is a test2')
        self.assertEquals(details[1][0]['content'],'# testpygithub')
        
        '''
        [[{'author': GitAuthor(name="burtnolej"), 
        'content': 'this is a test', 
        'sha': u'a8a940627d132695a9769df883f85992f0ff4a43', 
        'last_modified': 'Sat, 24 Feb 2018 16:04:08 GMT', 
        'path': u'C:\\Users\\burtnolej\\git_test.txt', 
        'message': u'commit via pyyhon api'}, 
        {'author': GitAuthor(name="burtnolej"), 
        'content': 'this is a test2', 
        'sha': u'62735d2e0ac54c10b96e28f9cd1fe1bf50e911aa', 
        'last_modified': 'Sat, 24 Feb 2018 16:04:08 GMT', 
        'path': u'C:\\Users\\burtnolej\\git_test2.txt', 
        'message': u'commit via pyyhon api'}, 
        {'author': GitAuthor(name="burtnolej"), 
        'content': 'this is a test3',
        'sha': u'62735d2e0ac54c10b96e28f9cd1fe1bf50e911aa', 
        'last_modified': 'Sat, 24 Feb 2018 16:04:08 GMT', 
        'path': u'C:\\Users\\burtnolej\\git_test3.txt', 
        'message': u'commit via pyyhon api'}], 
        [{'author': GitAuthor(name="burtnolej"), 
        'content': '# testpygithub',
        'sha': u'c432d383d75b157540b9a63e35467a8b21b91c50', 
        'last_modified': 'Sat, 24 Feb 2018 16:04:07 GMT', 
        'path': u'README.md', 
        'message': u'Initial commit'}]]
        '''
                
if __name__ == "__main__":
    
    suite = unittest.TestSuite()

    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitLogin))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCreateRepo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetRepo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCCreateInputTree))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCCreateInputTreeMultipleFiles))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCCreateCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetRef))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitUpdateRefs))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitMultiFileCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetCommitDetails))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetCommits))
    
    unittest.TextTestRunner(verbosity=2).run(suite)
    
