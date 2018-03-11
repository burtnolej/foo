import sys
import unittest
import time
from os import path
from misc_utils import write_binary_file, write_binary_file_struct, encode, decode, \
     bindiff, os_dir_exists
from misc_utils_log import Log, PRIORITY

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_gifs")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_gifs")
    
log = Log(cacheflag=True,logdir=LOGDIR,verbosity=10)

class Test_BinDiff(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_diff(self):
        file1 = path.join(TESTDIR,"foobar.gif")
        file2 = path.join(TESTDIR,"center8Helveticafoobar90200x200.gif")
        self.assertFalse(bindiff(file1,file2))
        
    def test_not_diff(self):
        file1 = path.join(TESTDIR,"foobar.gif")
        file2 = path.join(TESTDIR,"foobar.gif")
        self.assertTrue(bindiff(file1,file2))
        
    def test_diff_full_result(self):
        file1 = path.join(TESTDIR,"foobar.gif")
        file2 = path.join(TESTDIR,"center8Helveticafoobar90200x200.gif")
        self.assertEqual(599,len(bindiff(file1,file2,returnfulldiff=True)))

        
class Test_WriteBinaryFile(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_(self):
        write_binary_file("foo.bin",b'\x07\x08\x07')
        
        write_binary_file_struct("foo.bin",[1234, 5678, -9012, -3456])
        
    def tearDown(self):
        pass

class Test_Encode(unittest.TestCase):
    def setUp(self):
        self.test_str = "'C:\\Users\\burtnolej\\foo.txt'"
        self.b64_str = "J0M6XFVzZXJzXGJ1cnRub2xlalxmb28udHh0Jw=="
        self.uu_str = "%27C%3A%5CUsers%5Cburtnolej%5Cfoo.txt%27"
    def test_uu_encoding(self):
        self.assertEqual(encode(self.test_str,"uu"),self.uu_str)
    def test_b64_encoding(self):
        self.assertEqual(encode(self.test_str,"base64"),self.b64_str)
    def test_uu_decoding(self):
        self.assertEqual(decode(self.uu_str,"uu"),self.test_str)
    def test_b64_decoding(self):
        self.assertEqual(decode(self.b64_str,"base64"),self.test_str)

        
if __name__ == "__main__":

    #unittest.main()
    
    suite = unittest.TestSuite()
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_BinDiff))
    
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_WriteBinaryFile))
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Encode))

    
    
    
    unittest.TextTestRunner(verbosity=2).run(suite)
    
