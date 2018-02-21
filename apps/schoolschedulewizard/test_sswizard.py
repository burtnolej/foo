import sys
import os
from os import path as ospath

from Tkinter import *
from ttk import *

import unittest

from sswizard import schoolschedgeneric, WizardUI
from database_util import Database
from database_table_util import tbl_rows_get
from misc_utils_objectfactory import ObjFactory

from shutil import copyfile
from os import remove, path, chdir

class Test_Base(unittest.TestCase):
    def setUp(self,dbname,refdbname):
        dbpath = '/Users/burtnolej/Development/pythonapps3/clean/apps/schoolschedulewizard/test_sswizard'
        chdir(dbpath)
        self.dbname = dbname
        self.dbfilename = path.join(dbpath,self.dbname)
        self.database = Database(self.dbfilename)
        self.of = ObjFactory(True)
        self.ui = WizardUI(self.dbname, self.of,refdbname)       
        self.ui.dbname_entry_sv.set(dbname)
        
        parent_name = self.ui.entrygrid.widgets[0][0].winfo_parent()
        self.parent_widget = self.ui.entrygrid.widgets[0][0]._nametowidget(parent_name)
        self.parent_widget.update()

    def tearDown(self):
        self.ui.destroy()
        copyfile(self.dbfilename+".sqlite.backup",self.dbfilename+".sqlite")
        
class Test_Input_New_Save_Persist(Test_Base):
    
    def setUp(self):
        #Test_Base.setUp(self,'tmp','test_sswizard_save')
        Test_Base.setUp(self,'test_sswizard_save','test_sswizard_save')
    
        self.ui.dbname_entry_sv.set(self.dbname)
    
        self.ui.entrygrid.widgets[1][0].sv.set('Nathaniel')
        self.ui.entrygrid.widgets[0][1].sv.set('910-950')
        self.ui.entrygrid.widgets[1][1].sv.set('AMEL.AC.ELA.MO')
    
        self.ui.save(1)
        self.ui.persist_lesson()
          
    def test_dbwrite(self):
        
        
        expected_result = [[u'830-910', u'Nathaniel', u'AMEL.AC.ELA.MO', u'MO', u'1'], [u'910-950', u'Nathaniel', u'AMEL.AC.ELA.MO', u'MO', u'1']]
        
        cols = ['period','student','session','dow','saveversion']

        with self.database:
            colndefn,rows,exec_str = tbl_rows_get(self.database,'lesson',cols,
                                                  [['saveversion',"=",'1']])
            
        
        self.assertListEqual(expected_result,rows)
        
    def test_dbwrite_reload(self):
                
        self.of = ObjFactory(True)
        self.ui = WizardUI('test_sswizard_save', self.of,'test_sswizard_save')       
        self.ui.dbname_entry_sv.set('test_sswizard_save')
        
        parent_name = self.ui.entrygrid.widgets[0][0].winfo_parent()
        self.parent_widget = self.ui.entrygrid.widgets[0][0]._nametowidget(parent_name)
        self.parent_widget.update()
        
        self.ui.load(1)
        self.ui.save(1)
        
        self.assertListEqual(self.of.store['lesson'].keys(),['1,1,156', '1,2,156'])
        

    def tearDown(self):
        self.ui.destroy()
        copyfile(self.dbfilename+".sqlite.backup",self.dbfilename+".sqlite")

class Test_Input_New_Save_Change_Save_Persist(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_empty','test_sswizard_empty')
        
        self.ui.dbname_entry_sv.set(self.dbname)
        
        self.ui.entrygrid.widgets[1][0].sv.set('Nathaniel')
        self.ui.entrygrid.widgets[0][1].sv.set('830-910')
        self.ui.entrygrid.widgets[1][1].sv.set('AMEL.AC.ELA.MO')
        
        self.ui.save(1)
        
        self.ui.entrygrid.widgets[1][1].sv.set('STAN.BK.DRA.MO')
        
        self.ui.save(2)
        
        self.ui.persist_lesson()

    def test_dbwrite(self):
        
        expected_result = [['830-910', u'Nathaniel', 'STAN.BK.DRA.MO', u'MO', '2']]
        
        cols = ['period','student','session','dow','saveversion']

        with self.database:
            colndefn,rows,exec_str = tbl_rows_get(self.database,'lesson',cols,[['saveversion',"=",'2']])
        
        self.assertListEqual(expected_result,rows)

    def tearDown(self):
        self.ui.destroy()
        copyfile(self.dbfilename+".sqlite.backup",self.dbfilename+".sqlite")

             
class Test_Load(Test_Base):
    def setUp(self):
        #Test_Base.setUp(self,'test_sswizard','test_quadref')
        Test_Base.setUp(self,'test_sswizard','test_sswizard')
        
    def test_grid_contents(self):
        self.ui.load(1)
                
        expected_results = [[u'830-910'], [u'Nathaniel', u'AMEL.AC.ELA.MO']]
            
        self.assertListEqual(self.ui.entrygrid.dump_grid(), expected_results)

class Test_Load_Save(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard','test_sswizard')

        self.ui.load(1)
        self.ui.save(2)

        
    def test_objectrepr_type(self):
        
        expected_results = ['dow', 'lesson', 'lessontype', 'objtype', 'period', 'prep', 'saveversion', 'schedule', 'session', 'student', 'subject', 'teacher', 'userobjid']
        
        expected_results.sort()

        results = self.of.query()
        results.sort()

        self.assertListEqual(results, expected_results)
        
    def test_objectrepr_student_object(self):
        
        results = self.of.query('student')
        
        for obj in results:
            self.assertEqual(obj.__class__.__name__,'student')
        
    def test_objectrepr_student_attr(self):
        
        
        results = self.of.query('student')
        
        student_obj = results[0]
        name = getattr(student_obj,'name')
        
        self.assertEquals(name,getattr(student_obj,'objid'))
        self.assertEquals(name,getattr(student_obj,'userobjid'))
        self.assertEquals('student',getattr(student_obj,'objtype'))
        
        self.assertEqual('ObjFactory', getattr(student_obj,'of').__class__.__name__)

    def test_objectrepr_lesson_attr(self):
             
        
        results = self.of.query('lesson')
        
        lesson_obj = results[0]
        objid = getattr(lesson_obj,'objid')

        self.assertEquals(objid,getattr(lesson_obj,'userobjid').objid)
        self.assertEquals('lesson',getattr(lesson_obj,'objtype').objid)
        self.assertEquals('MO',getattr(lesson_obj,'dow').objid)
        self.assertEquals('ELA',getattr(lesson_obj,'subject').objid)
        self.assertEquals('Academic',getattr(lesson_obj,'lessontype').objid)
        self.assertEquals('Amelia',getattr(lesson_obj,'teacher').objid)
        self.assertEqual('ObjFactory', getattr(lesson_obj,'of').__class__.__name__)
     
    def test_objectrepr_num_lesson(self):
        # test that the objects created have the correct member attr and attrvals
        results = self.of.query('lesson')
        self.assertEqual(len(results),1)
        
    def test_objectrepr_num_teacher(self):
        # test that the objects created have the correct member attr and attrvals
        results = self.of.query('teacher')
        self.assertEqual(len(results),1)
        
    def test_objectrepr_num_student(self):
        # test that the objects created have the correct member attr and attrvals
        
        results = self.of.query('student')
        self.assertEqual(len(results),1)
        
    def test_grid_contents(self):
        
        expected_results =[[u'830-910'], [u'Nathaniel', u'AMEL.AC.ELA.MO']]
        
        self.assertListEqual(self.ui.entrygrid.dump_grid(), expected_results)
        
class Test_Load_Change_Save_Single_Value(Test_Base):
    
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard','test_sswizard')
        
        self.ui.load(1)
    
        self.ui.entrygrid.widgets[1][1].sv.set('AMEL.AC.ELA.MO')
    
        self.ui.save(2)
        
        self.ui.persist_lesson()
       
  
    def test_dbwrite(self):
        
        expected_result = [[u'830-910', u'Nathaniel', u'AMEL.AC.ELA.MO',u'MO','2']]
        
        cols = ['period','student','session','dow','saveversion']
        
        
        with self.database:
            colndefn,rows,exec_str = tbl_rows_get(self.database,'lesson',cols,[['saveversion',"=",'2']])
        
        self.assertListEqual(expected_result,rows)
        
                
class Test_Load_Save_Change_Save_Change_Save_Add_Col_Save(Test_Base):
    
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard','test_sswizard')
    
        self.ui.load(1)
        self.ui.save(2)
    
        self.ui.entrygrid.widgets[1][1].sv.set('STAN.BK.DRA.MO')
        
        self.ui.save(3)
        
        self.ui.entrygrid.widgets[0][2].sv.set('910-950')
        self.ui.entrygrid.widgets[1][2].sv.set('PARC.AC.ENG.MO')
    
        self.ui.save(4)

        self.ui.persist_lesson()
        
    def test_dbwrite(self):
        
        expected_result = [[u'830-910', u'Nathaniel', u'STAN.BK.DRA.MO', u'MO', u'4'], 
                           [u'910-950', u'Nathaniel', u'PARC.AC.ENG.MO', u'MO', u'4']]

     
        
        cols = ['period','student','session','dow','saveversion']
    
        with self.database:
                colndefn,rows,exec_str = tbl_rows_get(self.database,'lesson',cols,[['saveversion','=','4']])
    
        self.assertListEqual(expected_result,rows)
        
class Test_Load_Save_Change_Save_Single_Value(Test_Base):
    
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard','test_sswizard')
        
        self.ui.load(1)
        self.ui.save(2)
    
        self.ui.entrygrid.widgets[1][1].sv.set('PARC.AC.ENG.MO')
    
        self.ui.save(3)
        
        self.ui.persist_lesson()
        
    def test_dbwrite(self):
        
        expected_result = [['830-910', u'Nathaniel', 'PARC.AC.ENG.MO', u'MO', '3']]
        
        cols = ['period','student','session','dow','saveversion']
        
        
        with self.database:
            colndefn,rows,exec_str = tbl_rows_get(self.database,'lesson',cols,
                                                  [['saveversion',"=",'3']])
        
        self.assertListEqual(expected_result,rows)
        
    def test_entrygrid_contents(self):
        
        expected_results =[['830-910'],
                           ['Nathaniel', 'PARC.AC.ENG.MO']]
                
        self.assertListEqual(self.ui.entrygrid.dump_grid(), expected_results)        
        
class Test_Load_Save_Change_Save_New_Row(Test_Base):
    
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard','test_sswizard')
        
        self.ui.load(1)
        self.ui.save(2)
    
        self.ui.entrygrid.widgets[3][0].sv.set('Orig')
        self.ui.entrygrid.widgets[3][1].sv.set('STAN.BK.DRA.MO')
    
        self.ui.save(3)
        
        self.ui.persist_lesson()
        
    def test_dbwrite(self):
        
        expected_result = [['830-910', u'Nathaniel', 'AMEL.AC.ELA.MO', u'MO', '3'], 
                           ['830-910', u'Orig', 'STAN.BK.DRA.MO', u'MO', '3']]
        
        cols = ['period','student','session','dow','saveversion']
        
        with self.database:
            colndefn,rows,exec_str = tbl_rows_get(self.database,'lesson',cols,[['saveversion',"=",'3']])
        
        self.assertListEqual(expected_result,rows)
        
    def test_entrygrid_contents(self):
        
        expected_results =[['830-910'],
                           ['Nathaniel', 'AMEL.AC.ELA.MO'],
                           ['Orig', 'STAN.BK.DRA.MO']]
                
        self.assertListEqual(self.ui.entrygrid.dump_grid(), expected_results)
        
        
class Test_Dropdowns(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_dropdown','test_sswizard_dropdown')
        
        self.ui.dropdowns_set()
        
        self.periods = (u'830-910', u'910-950', u'950-1030', u'1030-1110', u'1110-1210', u'1210-100', u'100-140', u'140-220', u'220-300', u'300-330')
        self.students = ('Nathaniel', 'Clayton', 'Bruno', 'Orig', 'Stephen', 'Oscar', 'Peter', 'Jack', 'Jake', 'Stephen A', 'Coby', 'Thomas', 'Yosef', 'Tris', 'Ashley', 'SimonA', 'Booker', 'OmerC', 'JackB')
        self.sessions = ('PARC.AC.ENG.MO', 'STAN.BK.DRA.MO', '??.??.??.MO', 'AMEL.AC.ELA.MO')
        
    def test_(self):
        
        self.assertEqual(self.ui.entrygrid.widgets[0][1]['values'],self.periods)
        self.assertEqual( self.ui.entrygrid.widgets[1][0]['values'],self.students)
        self.assertEqual( self.ui.entrygrid.widgets[1][1]['values'],self.sessions)
        
class Test_GridReduce(unittest.TestCase):
    def setUp(self):
        
        self.grid = [['','A','B','C'],
                     ['X','','',''],
                     ['Y','foo','',''],
                     ['Z','','','bar']]                     
                     
    def test_(self):
        
        for y in range(1,3): # test grid only 3 wide
            self.ui.entrygrid.widgets[0][y]['values'] = self.periods
            
        for x in range(1,3): # test grid only 3 high
            self.ui.entrygrid.widgets[x][0]['values'] = self.students
             
                
if __name__ == "__main__":
    suite = unittest.TestSuite()
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Load))    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Load_Save))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Load_Change_Save_Single_Value))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Load_Save_Change_Save_Single_Value))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Load_Save_Change_Save_New_Row))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Load_Save_Change_Save_Change_Save_Add_Col_Save))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Input_New_Save_Change_Save_Persist))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Input_New_Save_Persist))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Dropdowns))
    
    unittest.TextTestRunner(verbosity=2).run(suite) 
    
    
    


