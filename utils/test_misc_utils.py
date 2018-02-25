import sys
import unittest
import time
from misc_utils import write_binary_file, write_binary_file_struct

class Test_WriteBinaryFile(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_(self):
        write_binary_file("foo.bin",b'\x07\x08\x07')
        
        write_binary_file_struct("foo.bin",[1234, 5678, -9012, -3456])
        
    def tearDown(self):
        pass

if __name__ == "__main__":

    #unittest.main()
    
    suite = unittest.TestSuite()
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_WriteBinaryFile))

    
    unittest.TextTestRunner(verbosity=2).run(suite)
    
