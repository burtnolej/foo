import unittest
from os import path
from data_utils import *
from misc_utils import os_dir_exists
from database_util import Database

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_misc")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_misc")
TESTDBNAME = "QuadQA.db"

class Test_Base(unittest.TestCase):
    def setUp(self):
        self.database = Database(path.join(TESTDIR,TESTDBNAME))
    
    def tearDown(self):
        pass
    
class Test_GetBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        self.assertEquals(get_basic_student_info(self.database),expected_results)
    
class Test_GetBasicTeacherInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Nicole', u'Consaga', 30]]
        self.assertEquals(get_basic_teacher_info(self.database),expected_results)

class Test_GetStudentSchedule(Test_Base):
    def test_(self):
        expected_results = [[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]]
        self.assertEquals(get_student_schedule(self.database,days='"M"',periods=1),expected_results)

class TestGetTeacherSchedule(Test_Base):
    def test_(self):
        expected_results =  [[u'ELA', u'Weapons of Satire', u'Amelia', u'M', 2, 9, 110, u'Seminar', 2, 68]]
        self.assertEquals(get_teacher_schedule(self.database,days='"M"',periods=2),expected_results)

class TestGetStudentsPerClassByTeacher(Test_Base):
    def test_(self):
        expected_results = [[320, u'Julian', u'Krause', u'Weapons of Satire', None, u'M', 4, 27, 135, u'1on1', 2, 320]]
        self.assertEquals(get_students_per_class_by_teacher(self.database,class_ids='320'),expected_results)

    
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetBasicStudentInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetBasicTeacherInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestGetTeacherSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestGetStudentsPerClassByTeacher))
    unittest.TextTestRunner(verbosity=2).run(suite)    