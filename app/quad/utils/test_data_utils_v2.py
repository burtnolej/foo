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
#TESTDBNAME = "QuadQA_v2.db"
TESTDBNAME = "QuadQA_v3.db"

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
        
class Test_GetScheduleLesson(Test_Base):
    def test_(self):
        expected_results = [[70, 16, 165, 9, 1, 1, 993]]
        columns,results = get_schedule_lesson_v2(self.database,days=[1],periods=[1])

        
        print results
        #self.assertEquals(results,expected_results)
        

class Test_ExplodeSection(Test_Base):
    def test_(self):

        section_columns,section_data = get_sections_to_explode(self.database)
        max_section_sched_id = get_max_section_schedule(self.database)
        for _section_data in section_data:
            fields = dict(zip(section_columns,_section_data))
            section_sched_data = []
            section_sched_columns = section_columns + ["idSectionSched","idDay","idTimePeriod","dtLectureStart","dtLectureStart"]
            
            for i in range(1,fields["iFreq"]+1):
                # section schedule
                max_section_sched_id = max_section_sched_id + 1
                _section_sched_data = _section_data+ ["\"" + str(max_section_sched_id) + "\"","\"\"","\"\"","\"\"","\"\""]
                section_sched_data.append(_section_sched_data)
                
                if fields["iMaxCapacity"] == 0:
                    pass
        
                # section schedule student
                if fields["lStudentEnroll"] != "":
                    student_ids = map(int,fields["lStudentEnroll"].split("_"))
                    section_student_enroll_data = []
                    section_student_enroll_columns = section_sched_columns + ["idStudent","sLectureFocusArea","dtEnrollStart","dtEnrollEnd"]
                    for m in range(len(student_ids)):
                        section_student_enroll_data.append(_section_sched_data + [student_ids[m],"\"\"","\"\"","\"\""])
                    
                    _insert_section_schedule_student(self.database,section_student_enroll_data,section_student_enroll_columns)
                
                # section schedule faculty
                if fields["lFacultyEnroll"] != "":
                    faculty_ids = map(int,fields["lFacultyEnroll"].split("_"))
                    section_faculty_enroll_data = []
                    section_faculty_enroll_columns = section_sched_columns + ["idFaculty","sLectureFocusArea","dtEnrollStart","dtEnrollEnd"]
                    for k in range(len(faculty_ids)):
                        section_faculty_enroll_data.append(_section_sched_data + [faculty_ids[k],"\"\"","\"\"","\"\""])
                    
                    _insert_section_schedule_faculty(self.database,section_faculty_enroll_data,section_faculty_enroll_columns)
                
            _insert_section_schedule(self.database,section_sched_data,section_sched_columns) 
            print _section_data
                
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetStudentSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_InsertSectionScheduleStudent))    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetScheduleLesson))   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_ExplodeSection))     
    
    
    
    unittest.TextTestRunner(verbosity=2).run(suite)    