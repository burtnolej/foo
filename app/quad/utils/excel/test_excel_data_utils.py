import unittest
from os import path
from data_utils import *
from excel_data_utils import *
from misc_utils import os_dir_exists, write_text_to_file, append_text_to_file, encode, os_file_delete, os_file_to_string, os_file_exists
from database_util import Database
from types import FunctionType, MethodType,StringType
from sys import modules

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_misc")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_misc")
TESTDBNAME = "QuadQA.db"

class Test_DataStoredProc_validate_sp_name(unittest.TestCase):
    def setUp(self):
        self.datasp = DataStoredProcBase(path.join(TESTDIR,TESTDBNAME))        
        DataStoredProcBase.sp_name="student_schedule"
        
    def test_(self):
        self.assertTrue(self.datasp._validate_sp_name())
        self.assertIsInstance(self.datasp.sp_name,StringType)
        
        args = {'studentid':70,'days':'"M"','periods':1}
        module = modules[self.datasp.sp_module]
        func = getattr(module,self.datasp.sp_name)
        result = func(self.datasp.database,**args)
        
        self.assertEqual(result,[[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]])
        
class Test_DataStoredProc_validate_sp_args(unittest.TestCase):
    def setUp(self):
        self.datasp = DataStoredProcBase(TESTDBNAME)        
        DataStoredProcBase.sp_args="<root><day>M</day><period>1</period></root>"
        
    def test_(self):
        self.assertTrue(self.datasp._validate_sp_args())
        
class Test_DataStoredProc_StudentSchedule(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = "C:\\Users\\burtnolej\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
            
    def test_(self):
        
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("student_schedule",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><studentid>70</studentid><days>M</days><periods>1</periods></root>",self.encoding) + "\n") 
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        self.assertEqual(result,[[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]])

        self.assertTrue(os_file_exists(self.result_filename))
        self.assertEqual("Homeroom^Homeroom^None^Isaac^M^1^9^165^Seminar^5^993",os_file_to_string(self.result_filename))
        
    def tearDown(self):
        os_file_delete(self.filename)

if __name__ == "__main__":
    suite = unittest.TestSuite()   
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_validate_sp_name))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_validate_sp_args))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_StudentSchedule))
    
    unittest.TextTestRunner(verbosity=2).run(suite)