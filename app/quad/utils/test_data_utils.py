import unittest
from os import path
from app.quad.utils.data_utils import *
from utils.misc_basic.misc_utils import os_dir_exists
from utils.database.database_util import Database
from utils.database.database_table_util import tbl_rows_get

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
        columns,results = get_all_day(self.database)
        self.assertEquals(len(results),5)

class Test_GetTimePeriodInfo(Test_Base):
    def test_(self):
        columns,results = get_all_timeperiod(self.database)
        self.assertEquals(len(results),11)

class Test_GetPrepInfo(Test_Base):
    def test_(self):
        columns,results = get_all_prep(self.database)
        self.assertEquals(len(results),9)
        
class Test_GetStudentLevelInfo(Test_Base):
    def test_(self):
        columns,results = get_all_studentlevel(self.database)
        
        self.assertEquals(results[0],[42, 1, 2, u'20170912', u'20180622'])
        
class Test_GetCourseInfo(Test_Base):
    def test_(self):
        expected_results =  [[u'Ancient Civilations', 1, 4]]
        columns,results = get_course(self.database)
        self.assertEquals(results,expected_results)

class Test_GetSubjectInfo(Test_Base):
    def test_(self):
        expected_results =   [[u'ELA', 1]]
        columns,results = get_subject(self.database)
        self.assertEquals(results,expected_results)
    
class Test_GetAllCourseInfo(Test_Base):
    def test_(self):
        columns,results = get_all_course(self.database)
        self.assertEquals(len(results),108)
        
class Test_GetAllSectionInfo(Test_Base):
    def test_(self):
        columns,results = get_all_section(self.database)
        self.assertEquals(len(results),833)   
        
class Test_GetAllLocationInfo(Test_Base):
    def test_(self):
        columns,results = get_all_location(self.database)
        
        self.assertEquals(len(results),41)      

class Test_GetAllSubjectInfo(Test_Base):
    def test_(self):
        columns,results = get_all_subject(self.database)
        self.assertEquals(len(results),16)
        
class Test_GetAllBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        columns,results = get_all_student(self.database)
        self.assertEqual(len(results),82)

class Test_InsertBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'foo', u'bar', 666, 2, u'Luna'], [u'blah', u'blah', 667, 3, u'Aurora']]
        rows = [[666, u'\"foo\"', u'\"bar\"',2,6], [667, u'\"blah\"', u'\"blah\"',3,6]]
        insert_student(self.database,rows, 
                        columns = ["idStudent","sStudentFirstNm","sStudentLastNm","idPrep","iGradeLevel"])

        columns,results = get_student(self.database,students=[666,667])    
        self.assertEqual(results,expected_results)  
        
        delete_student(self.database,[666,667])

class Test_InsertStudent(Test_Base):
    def test_(self):
        expected_results = [[666, u'foo', u'bar'], [667, u'blah', u'blah']]
        rows = [[666,"\"foo\"","\"bar\""],[667,"\"blah\"","\"blah\""]]
        _insert_student(self.database,rows)
        
        with self.database:
            _,results,_ = tbl_rows_get(self.database,"Student",
                                       fields = ["idStudent","sStudentFirstNm","sStudentLastNm"],
                                       whereclause=[["idStudent","in","(666,667)"]])
            
        self.assertEqual(results,expected_results)  
        _delete_student(self.database,[666,667])
        
class Test_UpdateStudent(Test_Base):
    def test_(self):
        expected_results = [[666, u'Jon', u'bar'], [667, u'blah', u'blah']]
        rows = [[666,"\"foo\"","\"bar\""],[667,"\"blah\"","\"blah\""]]
        _insert_student(self.database,rows)
        
        _update_table(self.database,"Student","sStudentFirstNm","\"Jon\"","idStudent",666)
        with self.database:
            _,results,_ = tbl_rows_get(self.database,"Student",
                                       fields = ["idStudent","sStudentFirstNm","sStudentLastNm"],
                                       whereclause=[["idStudent","in","(666,667)"]])
            
        self.assertEqual(results,expected_results)  
        _delete_student(self.database,[666,667])
        
class Test_UpdateBasicStudentInfo_StudentLevel(Test_Base):
    def test_(self):
        expected_results = [[u'foo', u'bar', 666, 2, u'Luna'], [u'blah', u'blah', 667, 2, u'Luna']]
        rows = [[666, u'\"foo\"', u'\"bar\"',2,6], [667, u'\"blah\"', u'\"blah\"',3,6]]
        insert_student(self.database,rows, 
                        columns = ["idStudent","sStudentFirstNm","sStudentLastNm","idPrep","iGradeLevel"])

        update_student(self.database,["idPrep",2,"idStudent",667])
    
        columns,results = get_student(self.database,students=[666,667])    
        self.assertEqual(results,expected_results)  
        
        delete_student(self.database,[666,667])
        
class Test_InsertStudent_ExtraColumns(Test_Base):
    # this is where insert student is part of a bigger insert and it needs to take
    # only the columns relevant to it
    def test_(self):
        expected_results = [[666, u'foo',u'bar'], [667, u'blah',u'blah']]
        rows = [[666,"\"foo\"", "\"dummy\"","\"bar\""],[667,"\"blah\"", "\"dummy\"","\"blah\""]]
        _insert_student(self.database,rows,columns=["idStudent","sStudentFirstNm","dummy","sStudentLastNm"])
        
        with self.database:
            _,results,_ = tbl_rows_get(self.database,"Student",
                                       fields = ["idStudent","sStudentFirstNm","sStudentLastNm"],
                                       whereclause=[["idStudent","in","(666,667)"]])
            
        self.assertEqual(results,expected_results)  
        _delete_student(self.database,[666,667])
        
class Test_InsertStudentLevel(Test_Base):
    def test_(self):
    
        expected_results =  [[666, 2, 6],
                             [667, 3, 6]]
        # 2=Luna
        rows = [[666,2,6],[667,3,6]]
        _insert_student_level(self.database,rows)
        with self.database:
            _,results,_ = tbl_rows_get(self.database,"StudentLevel",
                                       fields = ["idStudent","idPrep","iGradeLevel"],
                                       whereclause=[["idStudent","in","(666,667)"]])
            
        self.assertEqual(results,expected_results)  
        _delete_student_level(self.database,[666,667])
   
class Test_GetBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        columns,results = get_student(self.database)
        self.assertEquals(results,expected_results)

class Test_GetAllBasicStudentInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Donovan', u'Greene', 70, 7, u'Photon']]
        columns,results = get_all_student(self.database)
        self.assertEqual(len(results),82)
        
class Test_GetAllBasicTeacherInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Nicole', u'Consaga', 30]]
        columns,results = get_all_teacher(self.database)
        self.assertEqual(len(results),99)
        
class Test_GetBasicTeacherInfo(Test_Base):
    def test_(self):
        expected_results = [[u'Nicole', u'Consaga', 30]]
        columns,results = get_teacher(self.database)
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

class Test_InsertBasicScheduleStudent(Test_Base):
    def test_(self):
        expected_results = [[u'Work Period', u'Work Period', u'NOTSET', u'TBC', u'F', 7, 1, 700, u'Seminar', 1, 10001], [u'Work Period', u'Work Period', u'NOTSET', u'TBC', u'F', 8, 2, 700, u'Seminar', 1, 10002], [u'Work Period', u'Work Period', u'NOTSET', u'TBC', u'F', 9, 3, 700, u'Seminar', 1, 10003]]
        
        rows = [[10001,2,994,5,7,1,700],[10002,2,994,5,8,2,700],[10003,2,994,5,9,3,700]]
            
        insert_student_schedule(self.database,rows, columns=["idClassLecture","idStudent","idFaculty","idDay","idTimePeriod","idLocation","idSection"])
                                           
        columns,results = get_student_schedule(self.database,
                                                          students=[2],
                                                          days=['"F"'],
                                                          periods=[7,8,9])    
        self.assertEqual(results,expected_results)  
        
        delete_classlecture(self.database,classlectures=[10001,10002,10003])
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   

    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_UpdateStudent))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_UpdateBasicStudentInfo_StudentLevel))
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertStudent))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertStudentLevel))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertStudent_ExtraColumns))
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertBasicStudentInfo))
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
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentLevelInfo))
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetAllSectionInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetAllLocationInfo))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertBasicScheduleStudent))
    
    unittest.TextTestRunner(verbosity=2).run(suite)    