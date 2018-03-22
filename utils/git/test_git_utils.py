import sys
import unittest
from github import Github, Repository, InputGitTreeElement, GitBlob, GitTree, \
     Commit, GitCommit, GitRef
from utils.git.git_utils import GitBase, GitRepoHelper, GitCommitHelper
from utils.misc_basic.misc_utils import write_text_to_file, uuencode, uudecode, append_text_to_file, \
     b64decode
from time import sleep
    
class Test_GitLogin(unittest.TestCase):
    
    def setUp(self):
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        
    def test_(self):
        self.assertIsInstance(GitBase._login(self.token),Github)
        
class Test_GitCreateRepo(unittest.TestCase):
    def setUp(self):
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
    
    def test_(self):
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame)
        self.assertIsInstance(self.repo,Repository.Repository)
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        
class Test_GitBase(unittest.TestCase):
    def setUp(self):
        sleep(5)
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user = GitBase._get_user(self.github)
        sleep(1)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)
        sleep(1)
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
    
class Test_GitGetRepo(Test_GitBase):
    def test_(self):
        newrepo = GitRepoHelper._get_repo(self.user,self.reponame)
        self.assertIsInstance(newrepo ,Repository.Repository)
                            
class Test_GitCCreateInputTree(Test_GitBase):
    def setUp(self):
        super(Test_GitCCreateInputTree,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\testpygithub\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        
    def test_(self):
        tree =  GitCommitHelper._create_input_tree(self.filename,self.repo)
        self.assertIsInstance(tree,GitTree.GitTree)
        
class Test_GitCCreateInputTreeMultipleFiles(Test_GitBase):
    def setUp(self):
        super(Test_GitCCreateInputTreeMultipleFiles,self).setUp()
        self.filenames = ["C:\\Users\\burtnolej\\testpygithub\\git_test.txt",
                          "C:\\Users\\burtnolej\\testpygithub\\git_test2.txt",
                          "C:\\Users\\burtnolej\\testpygithub\\git_test3.txt"]
        
    def test_(self):
        tree =  GitCommitHelper._create_input_tree_multi(self.filenames,self.repo)
        self.assertIsInstance(tree,GitTree.GitTree)

class Test_GitGetCommit(Test_GitBase):
    def test_(self):
        gitcommit = GitRepoHelper._get_last_commit(self.repo)
        self.assertIsInstance(gitcommit,GitCommit.GitCommit)
        
class Test_GitCCreateCommit(Test_GitBase):
    def setUp(self):
        super(Test_GitCCreateCommit,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\testpygithub\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        self.tree =  GitCommitHelper._create_input_tree(self.filename,self.repo)
        self.parents = [GitCommitHelper._get_last_commit(self.repo)]
        
    def test_(self):
        git_commit = GitCommitHelper._create_commit(self.repo,
                                                       "commit via pyyhon api",
                                                       self.tree,self.parents)
        self.assertIsInstance(git_commit,GitCommit.GitCommit)

class Test_GitGetRef(Test_GitBase):
    def test_(self):
        #ref = self.repo.get_ref("heads/master")
        ref = GitRepoHelper._get_ref(self.repo)
        self.assertIsInstance(ref,GitRef.GitRef)
        
class Test_GitUpdateRefs(Test_GitBase):
    def setUp(self):
        super(Test_GitUpdateRefs,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\testpygithub\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        self.parents = [GitCommitHelper._get_last_commit(self.repo)]
        
        self.base_tree = self.parents[0]._tree.value
            
        self.tree =  GitCommitHelper._create_input_tree(self.filename,
                                                        self.repo,
                                                        base_tree=self.base_tree)
        self.git_commit = GitCommitHelper._create_commit(self.repo,
                                                            "commit via pyyhon api",self.tree,self.parents)
        self.headref = GitCommitHelper._get_ref(self.repo)
        
    def test_(self):
        self.headref.edit(self.git_commit.sha)
        self.assertEquals(self.git_commit.sha,GitCommitHelper._get_ref_sha(self.repo))  
        
        gitrepo = GitRepoHelper.history(self.token,self.reponame)
        
        self.assertEquals(gitrepo.commit_history[0][0]['path'],'C:\\Users\\burtnolej\\testpygithub\\git_test.txt')
        self.assertEquals(gitrepo.commit_history[0][1]['path'],'README.md')
        self.assertEquals(gitrepo.commit_history[1][0]['path'],'README.md')
    

class Test_GitMultiUpdateRefs(Test_GitBase):
    ''' do 1 commit and then amend the files and the commit those changes'''
    
    def setUp(self):
        super(Test_GitMultiUpdateRefs,self).setUp()
        self.filename = "C:\\Users\\burtnolej\\testpygithub\\git_test.txt"
        write_text_to_file(self.filename,"this is a test")
        self.parents = [GitCommitHelper._get_last_commit(self.repo)]
        self.base_tree = self.parents[0]._tree.value 
        self.tree =  GitCommitHelper._create_input_tree(self.filename,self.repo,base_tree=self.base_tree)
        self.git_commit = GitCommitHelper._create_commit(self.repo,"commit via pyyhon api",self.tree,self.parents)
        self.headref = GitCommitHelper._get_ref(self.repo)
        self.headref.edit(self.git_commit.sha)
        append_text_to_file(self.filename,"amendment")
        self.parents = [GitCommitHelper._get_last_commit(self.repo)]
        self.base_tree = self.parents[0]._tree.value 
        self.tree =  GitCommitHelper._create_input_tree(self.filename,self.repo,base_tree=self.base_tree)
        self.git_commit = GitCommitHelper._create_commit(self.repo,"commit via pyyhon api",self.tree,self.parents)
        self.headref = GitCommitHelper._get_ref(self.repo)
        
    def test_(self):
        self.headref.edit(self.git_commit.sha)
        self.assertEquals(self.git_commit.sha,GitCommitHelper._get_ref_sha(self.repo))  
        
        gitrepo = GitRepoHelper.history(self.token,self.reponame)
        
        self.assertEquals(gitrepo.commit_history[0][0]['path'],'C:\\Users\\burtnolej\\testpygithub\\git_test.txt')
        self.assertEquals(gitrepo.commit_history[0][0]['content'],"this is a testamendment")
        self.assertEquals(gitrepo.commit_history[1][0]['path'],'C:\\Users\\burtnolej\\testpygithub\\git_test.txt')
        self.assertEquals(gitrepo.commit_history[1][0]['content'],"this is a test")

        self.assertEquals(gitrepo.commit_history[2][0]['path'],'README.md')
    
    def tearDown(self):
        write_text_to_file(self.filename,"this is a test")
        super(Test_GitMultiUpdateRefs,self).tearDown()
        
class Test_GitMultiFileCommit(Test_GitBase):
    def setUp(self):
        super(Test_GitMultiFileCommit,self).setUp()
        self.filenames = ["C:\\Users\\burtnolej\\testpygithub\\git_test.txt",
                              "C:\\Users\\burtnolej\\testpygithub\\git_test2.txt",
                              "C:\\Users\\burtnolej\\testpygithub\\git_test3.txt"]
        self.tree =  GitCommitHelper._create_input_tree_multi(self.filenames,self.repo)
        self.parents = [GitCommitHelper._get_last_commit(self.repo)]
        self.git_commit = GitCommitHelper._create_commit(self.repo,
                                                            "commit via pyyhon api",self.tree,self.parents)
        self.headref = GitCommitHelper._get_ref(self.repo)
        
    def test_(self):
        self.headref.edit(self.git_commit.sha)
        self.assertEquals(self.git_commit.sha,GitCommitHelper._get_ref_sha(self.repo)) 
        
class Test_GitGetCommitDetails(Test_GitBase):
    def test_(self):
        gitcommit = GitRepoHelper._get_last_commit(self.repo)
        self.assertEquals(GitRepoHelper._get_file_path(gitcommit),"README.md")
        content = GitRepoHelper._get_file_content(self.repo,gitcommit)
        self.assertEquals(b64decode(content),"# testpygithub")

class Test_GitCommitBase(unittest.TestCase):
    def setUp(self):
        self.token = GitBase._get_token()
        self.reponame = "testpygithub"
        self.github = GitBase._login(self.token)
        self.user =  GitBase._get_user(self.github)
        self.repo = GitRepoHelper._create_repo(self.user,self.reponame,auto_init=True)
        
        self.filenames = ["C:\\Users\\burtnolej\\testpygithub\\git_test.txt",
                              "C:\\Users\\burtnolej\\testpygithub\\git_test2.txt",
                                  "C:\\Users\\burtnolej\\testpygithub\\git_test3.txt"]
        self.tree =  GitCommitHelper._create_input_tree_multi(self.filenames,self.repo)
        self.parents = [GitCommitHelper._get_last_commit(self.repo)]
        self.new_commit = GitCommitHelper._create_commit(self.repo,"commit via pyyhon api",self.tree,self.parents)
        self.headref = GitCommitHelper._get_ref(self.repo)
        self.headref.edit(self.new_commit.sha)
        
    def tearDown(self):
        GitRepoHelper._delete_repo(self.repo)
        del self.github
        
class Test_GitGetCommits(Test_GitCommitBase):
    def test_(self):
        commits = GitRepoHelper._get_commits(self.repo)
        details = GitRepoHelper._get_commit_details(self.repo,commits)

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
class Test_GitBasePublic(unittest.TestCase):
    
    def setUp(self):
        self.token = GitBase._get_token()
    
    def test_(self):
        gitbase = GitBase(self.token)
        
        self.assertIsInstance(gitbase.github, Github)

class Test_GitRepoHelperPublic(Test_GitBase):
    
    def setUp(self):
        super(Test_GitRepoHelperPublic,self).setUp()
        self.reponame = "testpygithub"
        
    def test_(self):
        gitrepo = GitRepoHelper(self.token,self.reponame)
        self.assertIsInstance(gitrepo.repo, Repository.Repository)
        
class Test_GitRepoHelperPublic_GetCommits(Test_GitCommitBase):
    
    def setUp(self):
        super(Test_GitRepoHelperPublic_GetCommits,self).setUp()
        self.reponame = "testpygithub"
            
    def test_(self):
        
        gitrepo = GitRepoHelper.history(self.token,self.reponame)
        self.assertEquals(gitrepo.commit_history[0][0]['content'],'this is a test')
        self.assertEquals(gitrepo.commit_history[0][2]['content'],'this is a test2')
        self.assertEquals(gitrepo.commit_history[1][0]['content'],'# testpygithub')

class Test_GitCommitHelperPublic_Commit(Test_GitBase):
    
    def setUp(self):
        super(Test_GitCommitHelperPublic_Commit,self).setUp()
        self.reponame = "testpygithub"
        self.filenames = ["C:\\Users\\burtnolej\\testpygithub\\git_test.txt",
                          "C:\\Users\\burtnolej\\testpygithub\\git_test2.txt",
                          "C:\\Users\\burtnolej\\testpygithub\\git_test3.txt"]
        self.message = "test commit"
        
    def test_(self):
        gitcommit = GitCommitHelper.commit(self.token,
                                          self.reponame,
                                          self.filenames,
                                          self.message)
        

class Test_GitCommitHelperPublic_MultiCommit(Test_GitBase):
    
    def setUp(self):
        super(Test_GitCommitHelperPublic_MultiCommit,self).setUp()
        self.reponame = "testpygithub"
        self.filenames = ["C:\\Users\\burtnolej\\testpygithub\\git_test.txt",
                          "C:\\Users\\burtnolej\\testpygithub\\git_test2.txt",
                          "C:\\Users\\burtnolej\\testpygithub\\git_test3.txt"]
        self.message = "test commit1"
        
        
    def test_(self):
    
        # commit 1
        gitcommit = GitCommitHelper.commit(self.token,self.reponame,self.filenames,self.message)
    
        # commit 2
        append_text_to_file("C:\\Users\\burtnolej\\testpygithub\\git_test.txt","foo")
        append_text_to_file("C:\\Users\\burtnolej\\testpygithub\\git_test2.txt","bar")
        gitcommit = GitCommitHelper.commit(self.token,self.reponame,self.filenames,self.message)

        # commit 3        
        self.filenames = ["C:\\Users\\burtnolej\\testpygithub\\git_test4.txt"]
        gitcommit = GitCommitHelper.commit(self.token,self.reponame,self.filenames,self.message)
               
        files = GitRepoHelper._get_files(self.repo)
        self.assertEqual(files,[u'C:\\Users\\burtnolej\\testpygithub\\git_test.txt', u'C:\\Users\\burtnolej\\testpygithub\\git_test2.txt', u'C:\\Users\\burtnolej\\testpygithub\\git_test3.txt', u'C:\\Users\\burtnolej\\testpygithub\\git_test4.txt', u'README.md'])
       
        gitrepo = GitRepoHelper.history(self.token,self.reponame)
        self.assertEquals(gitrepo.commit_history[0][0]['content'],'this is a testfoo')
        self.assertEquals(gitrepo.commit_history[0][1]['content'],'this is a test2bar')
        self.assertEquals(gitrepo.commit_history[0][2]['content'],'this is a test2')
        self.assertEquals(gitrepo.commit_history[0][3]['content'],'this is a test4')
 

    def tearDown(self):
        
        write_text_to_file("C:\\Users\\burtnolej\\testpygithub\\git_test.txt","this is a test")
        write_text_to_file("C:\\Users\\burtnolej\\testpygithub\\git_test2.txt","this is a test2")
        super(Test_GitCommitHelperPublic_MultiCommit,self).tearDown()
        
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
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitMultiUpdateRefs))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommitHelperPublic_MultiCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitMultiFileCommit))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetCommitDetails))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitGetCommits))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitBasePublic))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitRepoHelperPublic))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitRepoHelperPublic_GetCommits))        
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GitCommitHelperPublic_Commit))

    unittest.TextTestRunner(verbosity=2).run(suite)
    
