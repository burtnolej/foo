import unittest
from os import path, environ
from app.quad.utils.data_utils import *
from app.quad.utils.excel.excel_data_utils import *
from utils.misc_basic.misc_utils import os_dir_exists, write_text_to_file, append_text_to_file, encode, os_file_delete, os_file_to_string, os_file_exists, put_2darray_in_file
from utils.database.database_util import Database


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
        
        args = {'students':[70],'days':['"M"'],'periods':[1]}
        module = modules[self.datasp.sp_module]
        func = getattr(module,self.datasp.sp_name)
        _,result = func(self.datasp.database,**args)
        
        self.assertEqual(result,[[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]])
        
class Test_DataStoredProc_validate_sp_args(unittest.TestCase):
    def setUp(self):
        self.datasp = DataStoredProcBase(TESTDBNAME)        
        DataStoredProcBase.sp_args="<root><day>M</day><period>1</period></root>"
        
    def test_(self):
        self.assertTrue(self.datasp._validate_sp_args())
    
class Test_DataStoredProc_InsertStudent(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = environ["MYHOME"] + "\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
        self.columns = ["idStudent","sStudentFirstNm","sStudentLastNm","idPrep","iGradeLevel"]
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[[666, 'foo', 'bar',2,6], [667, 'blah', 'blah',3,6]]
            
    def test_(self):
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")

        append_text_to_file(self.filename,"sp_name:"+encode("insert_basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"header_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"columns:"+"$$".join([field for field in self.columns]) + "\n")
    
        put_2darray_in_file(self.filename,self.row,suffix="rows:")
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        
        DataStoredProc.sp_args = {}
    
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>667</students></root>",self.encoding) + "\n") 
    
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
    
        self.assertEqual(result,[[u'blah', u'blah', 667, 3, u'Aurora']])
        
    def tearDown(self):
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
    
        append_text_to_file(self.filename,"sp_name:"+encode("delete_basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>666</students><students>667</students></root>",self.encoding) + "\n") 
    
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        os_file_delete(self.filename)    
        DataStoredProc.sp_args = {}
        
class Test_DataStoredProc_UpdateStudent(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = environ["MYHOME"] + "\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
        self.columns = ["idStudent","sStudentFirstNm","sStudentLastNm","idPrep","iGradeLevel"]
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.rows =[[666, 'foo', 'bar',2,6], [667, 'blah', 'blah',3,6]]
        self.row =['idPrep', 3, 'idStudent',666]
                   
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
    
        append_text_to_file(self.filename,"sp_name:"+encode("insert_basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"columns:"+"$$".join([field for field in self.columns]) + "\n")
    
        put_2darray_in_file(self.filename,self.rows,suffix="rows:")
    
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        DataStoredProc.sp_args = {}
        
    def test_(self):
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
    
        append_text_to_file(self.filename,"sp_name:"+encode("update_basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"row:"+"$$".join([str(field) for field in self.row]) + "\n")
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        DataStoredProc.sp_args = {}
        
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>666</students></root>",self.encoding) + "\n") 
    
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        
        self.assertEqual(result,[[u'foo', u'bar', 666, 3, u'Aurora']])

    def tearDown(self):
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
    
        append_text_to_file(self.filename,"sp_name:"+encode("delete_basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>666</students><students>667</students></root>",self.encoding) + "\n") 
    
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        os_file_delete(self.filename)
    
class Test_DataStoredProc_DeleteStudent(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = environ["MYHOME"] + "\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
            
    def test_(self):
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")

        append_text_to_file(self.filename,"sp_name:"+encode("delete_basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>666</students><students>667</students></root>",self.encoding) + "\n") 
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)

        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("basic_student_info",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>666</students></root>",self.encoding) + "\n") 
    
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        
        self.assertEqual("",os_file_to_string(self.result_filename))

    def tearDown(self):
        os_file_delete(self.filename)
        DataStoredProc.sp_args = {}
        
class Test_DataStoredProc_StudentSchedule(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = environ["MYHOME"] + "\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
            
    def test_(self):
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("student_schedule",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>70</students><days>M</days><periods>1</periods></root>",self.encoding) + "\n") 
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        self.assertEqual(result,[[u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]])

        self.assertTrue(os_file_exists(self.result_filename))
        self.assertEqual("Homeroom^Homeroom^None^Isaac^M^1^9^165^Seminar^5^993",os_file_to_string(self.result_filename))
        
    def tearDown(self):
        os_file_delete(self.filename)
        DataStoredProc.sp_args = {}
                       
class Test_DataStoredProc_StudentSchedule_MultiVals(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = environ["MYHOME"] + "\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
            
    def test_(self):
        
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("student_schedule",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>70</students><students>69</students><days>M</days><days>T</days><periods>1</periods><periods>2</periods></root>",self.encoding) + "\n") 
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        
        expected_results= [[u'Homeroom', u'Homeroom', None, u'Samantha', u'M', 1, 10, 163, u'Seminar', 5, 983], 
                           [u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993], 
                           [u'Movement', u'Movement', None, u'Michael', u'M', 2, 37, 432, u'Seminar', 1, 1196], 
                           [u'Science', u'Science', None, u'John', u'M', 2, 4, 162, u'1on1', 1, 143], 
                           [u'Homeroom', u'Homeroom', None, u'Samantha', u'T', 1, 10, 163, u'Seminar', 5, 984], 
                           [u'Homeroom', u'Homeroom', None, u'Isaac', u'T', 1, 9, 165, u'Seminar', 5, 994], 
                           [u'Foreign Language', u'Spanish 1', None, u'Jamie', u'T', 2, 6, 451, u'Seminar', 2, 1218], 
                           [u'Work Period', u'Work Period', None, u'Alyssa', u'T', 2, 37, 564, u'Seminar', 1, 713]]
        
        
        self.assertEqual(result,expected_results)

        self.assertTrue(os_file_exists(self.result_filename))
        self.assertEqual(os_file_to_string(self.result_filename),"Homeroom^Homeroom^None^Samantha^M^1^10^163^Seminar^5^983$$Homeroom^Homeroom^None^Isaac^M^1^9^165^Seminar^5^993$$Movement^Movement^None^Michael^M^2^37^432^Seminar^1^1196$$Science^Science^None^John^M^2^4^162^1on1^1^143$$Homeroom^Homeroom^None^Samantha^T^1^10^163^Seminar^5^984$$Homeroom^Homeroom^None^Isaac^T^1^9^165^Seminar^5^994$$Foreign Language^Spanish 1^None^Jamie^T^2^6^451^Seminar^2^1218$$Work Period^Work Period^None^Alyssa^T^2^37^564^Seminar^1^713")
        
    def tearDown(self):
        os_file_delete(self.filename)

class Test_DataStoredProc_StudentScheduleWithHeaders(unittest.TestCase):
    def setUp(self):
        self.filename = "uupyshell.txt"
        self.result_filename = environ["MYHOME"] + "\\pyshell_result.txt"
        self.datasp = DataStoredProc(path.join(TESTDIR,TESTDBNAME)) 
        self.encoding = "uu"
            
    def test_(self):
        
        write_text_to_file(self.filename,"database_name:"+encode(path.join(TESTDIR,TESTDBNAME),self.encoding) + "\n")
        append_text_to_file(self.filename,"sp_name:"+encode("student_schedule",self.encoding) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+encode("False",self.encoding) + "\n") 
        append_text_to_file(self.filename,"header_flag:"+encode("True",self.encoding) + "\n") 
        append_text_to_file(self.filename,"sp_args:"+encode("<root><students>70</students><days>M</days><periods>1</periods></root>",self.encoding) + "\n") 
        
        result = DataStoredProc.stored_proc_by_file(self.filename,result_file=self.result_filename)
        self.assertEqual(result,[['sSubjectLongDesc', 'sCourseNm', 'sClassFocusArea', 'sFacultyFirstNm', 'cdDay', 'idTimePeriod', 'idLocation', 'idSection', 'cdClassType', 'iFreq', 'idClassLecture'], [u'Homeroom', u'Homeroom', None, u'Isaac', u'M', 1, 9, 165, u'Seminar', 5, 993]])
        
        self.assertTrue(os_file_exists(self.result_filename))
        self.assertEqual("sSubjectLongDesc^sCourseNm^sClassFocusArea^sFacultyFirstNm^cdDay^idTimePeriod^idLocation^idSection^cdClassType^iFreq^idClassLecture$$Homeroom^Homeroom^None^Isaac^M^1^9^165^Seminar^5^993",
        os_file_to_string(self.result_filename))
        
    def tearDown(self):
        os_file_delete(self.filename)
        os_file_delete(self.result_filename)
        DataStoredProc.sp_args = {}
        
if __name__ == "__main__":
    suite = unittest.TestSuite()   
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_validate_sp_name))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_validate_sp_args))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_StudentSchedule))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_StudentSchedule_MultiVals))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_StudentScheduleWithHeaders))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_InsertStudent))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_DeleteStudent))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DataStoredProc_UpdateStudent))
    
    unittest.TextTestRunner(verbosity=2).run(suite)