import unittest
from os import path
from data_utils import *
from misc_utils import os_dir_exists
from database_util import Database

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_misc")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_misc")
TESTDBNAME = "QuadQA.db"

class Test_DataStoredProc_StudentSchedule(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = "C:\\Users\\burtnolej\\pyshell_result.txt"
        self.database = Database(path.join(TESTDIR,TESTDBNAME))
        self.encoding = "uu"
            
    def test_(self):
        append_text_to_file(self.filename,"database_name:"+encode(self.database_name,self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode(student_schedule,self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode(False,self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("day=M,period=1",self.encoding) + "\n") 
        
        result = DatabaseQueryTable.stored_proc_by_file(self.filename,result_file=self.result_filename)
        
    def tearDown(self):
        os_file_delete(self.result_filename)

if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_StudentSchedule))
    unittest.TextTestRunner(verbosity=2).run(suite)