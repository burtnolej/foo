import sys
import unittest
import time
from misc_utils import write_binary_file, write_binary_file_struct, encode, decode

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
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_WriteBinaryFile))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Encode))

    
    
    
    unittest.TextTestRunner(verbosity=2).run(suite)
    
