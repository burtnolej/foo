import unittest
from os import path
from app.quad.utils.data_utils import *
from app.quad.utils.data_utils_v2 import *
from utils.misc_basic.misc_utils import os_dir_exists
from utils.database.database_util import Database
from utils.database.database_table_util import tbl_rows_get

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"excel/test_misc")) # test files go here
TESTDIR = path.join(ROOTDIR,"excel","test_misc")
TESTDBNAME = "QuadQA_v2.db"


class Test_Base(unittest.TestCase):
    def setUp(self):
        self.database = Database(path.join(TESTDIR,TESTDBNAME))
    
    def tearDown(self):
        pass

class Test_GetStudentSchedule(Test_Base):
    def test_(self):
        expected_results = [[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]]
        columns,results = get_student_schedule_v2(self.database,days=['"M"'],periods=[1])
        self.assertEquals(results,expected_results)
        
class Test_InsertSectionScheduleStudent(Test_Base):
    def test_(self):
        expected_results = [[u'Work Period', u'Work Period', u'NOTSET', u'TBC', u'F', 7, 1, 700, u'Seminar', 1, 10001], [u'Work Period', u'Work Period', u'NOTSET', u'TBC', u'F', 8, 2, 700, u'Seminar', 1, 10002], [u'Work Period', u'Work Period', u'NOTSET', u'TBC', u'F', 9, 3, 700, u'Seminar', 1, 10003]]
        
        rows = [[10001,2,994,5,7,1,700],[10002,2,994,5,8,2,700],[10003,2,994,5,9,3,700]]
            
        insert_section_schedule(self.database,rows, columns=["idSectionSched","idStudent","idFaculty","idDay","idTimePeriod","idLocation","idSection"])
                                           
        columns,results = get_student_schedule_v2(self.database,
                                                  students=[2],
                                                  days=['"F"'],
                                                  periods=[7,8,9])    
        self.assertEqual(results,expected_results)  
        
        delete_section_schedule(self.database,sectionschedules=[10001,10002,10003])
        

if __name__ == "__main__":
    suite = unittest.TestSuite()   
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertSectionScheduleStudent))    
    unittest.TextTestRunner(verbosity=2).run(suite)    