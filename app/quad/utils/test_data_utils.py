import unittest
from os import path
from app.quad.utils.data_utils import *
from utils.misc_basic.misc_utils import os_dir_exists
from utils.database.database_util import Database

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_misc")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_misc")
TESTDBNAME = "QuadQA.db"

class Test_Base(unittest.TestCase):
    def setUp(self):
        self.database = Database(path.join(TESTDIR,TESTDBNAME))
    
    def tearDown(self):
        pass

class Test_GetDayInfo(Test_Base):
    def test_(self):
        columns,results = get_all_basic_day_info(self.database)
        self.assertEquals(len(results),5)

class Test_GetTimePeriodInfo(Test_Base):
    def test_(self):
        columns,results = get_all_basic_timeperiod_info(self.database)
        self.assertEquals(len(results),11)

class Test_GetPrepInfo(Test_Base):
    def test_(self):
        columns,results = get_all_basic_prep_info(self.database)
        self.assertEquals(len(results),9)
        
class Test_GetCourseInfo(Test_Base):
    def test_(self):
        expected_results =  [[u'Ancient Civilations', 1, 4]]
        columns,results = get_basic_course_info(self.database)
        self.assertEquals(results,expected_results)

class Test_GetSubjectInfo(Test_Base):
    def test_(self):
        expected_results =   [[u'ELA', 1]]
        columns,results = get_basic_subject_info(self.database)
        self.assertEquals(results,expected_results)
    
class Test_GetAllCourseInfo(Test_Base):
    def test_(self):
        columns,results = get_all_basic_course_info(self.database)
        self.assertEquals(len(results),108)

class Test_GetAllSubjectInfo(Test_Base):
    def test_(self):
        columns,results = get_all_basic_subject_info(self.database)
        self.assertEquals(len(results),16)
        
class Test_GetAllBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        columns,results = get_all_basic_student_info(self.database)
        self.assertEqual(len(results),82)
        
        
class Test_GetBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        columns,results = get_basic_student_info(self.database)
        self.assertEquals(results,expected_results)

class Test_GetAllBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        columns,results = get_all_basic_student_info(self.database)
        self.assertEqual(len(results),82)
        
class Test_GetAllBasicTeacherInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Nicole', u'Consaga', 30]]
        columns,results = get_all_basic_teacher_info(self.database)
        self.assertEqual(len(results),99)
        
class Test_GetBasicTeacherInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Nicole', u'Consaga', 30]]
        columns,results = get_basic_teacher_info(self.database)
        self.assertEquals(results,expected_results)

class Test_GetStudentSchedule(Test_Base):
    def test_(self):
        expected_results = [[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]]
        columns,results = get_student_schedule(self.database,days=['"M"'],periods=[1])
        self.assertEquals(results,expected_results)
        
class Test_GetStudentScheduleArgs(Test_Base):
    def test_(self):
        expected_results = [[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]]
        args = {'students':[70],'days':['"M"'],'periods':[1]}
        columns,results = get_student_schedule(self.database,**args)
        self.assertEquals(results,expected_results)

class TestGetTeacherSchedule(Test_Base):
    def test_(self):
        expected_results =  [[u'ELA', u'Weapons of Satire', u'Amelia', u'M', 2, 9, 110, u'Seminar', 2, 68]]
        columns,results = get_teacher_schedule(self.database,days=['"M"'],periods=[2])
        self.assertEquals(results,expected_results)

class TestGetStudentsPerClassByTeacher(Test_Base):
    def test_(self):
        expected_results = [[320, u'Julian', u'Krause', u'Weapons of Satire', None, u'M', 4, 27, 135, u'1on1', 2, 320]]
        columns,results = get_students_per_class_by_teacher(self.database,class_ids='320')
        self.assertEquals(results,expected_results)
        
class Test_GetStudentScheduleArgs_Columns(Test_Base):
    """ test that the columns names are returned correctly
    """
    def test_(self):
        expected_results = ['sSubjectLongDesc', 'sCourseNm', 'sClassFocusArea', 'sFacultyFirstNm', 'cdDay', 'idTimePeriod', 'idLocation', 'idSection', 'cdClassType', 'iFreq', 'idClassLecture']
        args = {'students':[70],'days':['"M"'],'periods':[1]}
        columns,results = get_student_schedule(self.database,**args)
        self.assertEquals(columns,expected_results)
    
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentScheduleArgs))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetBasicStudentInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetBasicTeacherInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestGetTeacherSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestGetStudentsPerClassByTeacher))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentScheduleArgs_Columns))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetAllBasicStudentInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetAllBasicTeacherInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetCourseInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetSubjectInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetAllCourseInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetAllSubjectInfo))

    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetPrepInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetDayInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetTimePeriodInfo))

    unittest.TextTestRunner(verbosity=2).run(suite)    