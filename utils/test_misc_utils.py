import sys
import unittest
import time

class Test_MoveFiles(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_(self):
        pass
        
    def tearDown(self):
        pass

if __name__ == "__main__":

    #unittest.main()
    
    suite = unittest.TestSuite()
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestIDGenerator))

    
    unittest.TextTestRunner(verbosity=2).run(suite)
    
