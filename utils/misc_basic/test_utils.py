from module_utils import __load_module__ as load_module
import unittest
import sys
from os import walk, getcwd
from os.path import join, splitext

def testrunner(rootdir="C:\Users\burtnolej\Development"):
    suite = unittest.TestSuite()
    testsummary = []
    
    for root,cwd,files in walk(rootdir):
        for file in files:
            if file.startswith("test_") and splitext(file)[1] == ".py":
                mymodule = load_module(join(root,file))  
                
                for item in dir(mymodule):
                    if item.startswith('Test'):
                        suite.addTest(unittest.TestLoader().loadTestsFromTestCase(getattr(mymodule,item)))
                        
                testsummary.append(file)
    
    unittest.TextTestRunner(verbosity=3,buffer=True).run(suite)

if __name__ == "__main__":
    
    testrunner("C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\utils")