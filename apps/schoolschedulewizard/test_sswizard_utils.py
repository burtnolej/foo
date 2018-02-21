import sys
import os
from os import path as ospath
from shutil import copyfile

from Tkinter import *
from ttk import *

import unittest
from shutil import copyfile

from ui_utils import TkImageLabelGrid, geometry_get_dict, geometry_get

from misc_utils import nxnarraycreate
from type_utils import SetMemberPartial, DBSetMember, TextAlphaNumRO
from sswizard_query_utils import *

from database_util import Database
from database_table_util import tbl_rows_get, tbl_query, tbl_remove

from sswizard_utils import dropdown_build, setenums, session_code_gen, \
     dbinsert, dbinsert_direct, gridreduce, cellrollup, gridrollup

from collections import OrderedDict
      
#CURRENTDIR=os.getcwd()
CURRENTDIR=os.path.dirname(__file__)
THISEXEC=os.path.splitext(os.path.basename(__file__))[0]

'''def _execfunc(database,value,prep):
    
    exec_str = "select s.code "
    exec_str += "from session as s,adult as a "
    exec_str += "where a.prep = {0} and ".format(prep)
    exec_str += "a.name = s.teacher and "
    exec_str += "s.period = {0} and ".format(value)
    exec_str += "a.subject <> \"None\""
    
    #exec_str = "select code from session where period = {0} and subject <> \"None\"".format(value)
    return(tbl_query(database,exec_str))

def _rowheaderexecfunc(database):
    exec_str = "select name from period"
    return(tbl_query(database,exec_str))

def _columnheaderexecfunc(database):
    exec_str = "select nickname from student"
    return(tbl_query(database,exec_str))'''

class UI(Tk):
    def __init__(self,database):       
        Tk.__init__(self)
        
        self.maxrows=9 # rows in the grid
        self.maxcols=10 # cols in the grid
        maxwidgets=self.maxrows*self.maxcols
        wwidth=48 # default button width with text of 3 chars
        wheight=29 # default button height
        wmheight=wheight*20 # master height
        wmwidth=wwidth*20 # master width 
    
        geom = geometry_get(wmheight,wmwidth,0,0)
        self.geometry(geom)
        
        widget_args=dict(background='white')
        
        widgetcfg = nxnarraycreate(self.maxrows,self.maxcols,widget_args)
        widgetcfg = dropdown_build(database,widgetcfg,
                                   _execfunc,
                                   _rowheaderexecfunc,
                                   _columnheaderexecfunc)

        setmemberp = SetMemberPartial(name='x{mylist}',set=[])

        self.entrygrid = TkImageLabelGrid(self,'entrygrid',setmemberp,wmwidth,wmheight,
                                          0,0,self.maxrows,self.maxcols,
                                          {},widgetcfg)
        self.entrygrid.grid(row=0,sticky=NSEW)      


class Test_With_Headers(unittest.TestCase):
    def setUp(self):
        
        self.database = Database(CURRENTDIR+"/"+THISEXEC+"/"+'test_sswizard')
        self.classtbl = 'class'
        self.maxx = 8
        self.maxy = 10
        
        widget_args=dict(background='white')
    
        self.widgetcfg = nxnarraycreate(self.maxx+1,self.maxy+1,widget_args)
        self.widgetcfg = dropdown_build(self.database,
                                  self.widgetcfg,
                                   _execfunc,
                                   5,
                                   "MO",
                                   _rowheaderexecfunc,
                                   _columnheaderexecfunc)


    def test_col1(self):
        testx=0
       
        expected_results = [u'PARC.AC.ENG.MO', u'STAN.BK.DRA.MO', u'??.??.??.MO', u'AMEL.AC.ELA.MO']
        self.assertEqual(self.widgetcfg[testx+1][1]['values'],expected_results)

    def test_col2(self):
        testx=7
       
        expected_results = [u'PARC.AC.ENG.MO', u'STAN.BK.DRA.MO', u'??.??.??.MO', u'AMEL.AC.ELA.MO']
        self.assertEqual(self.widgetcfg[testx+1][1]['values'],expected_results)
        
    def test_col7_rowheader(self):
        testx=7
        expected_results = [u'830-910', u'910-950', u'950-1030', u'1030-1110', u'1110-1210', u'1210-100', u'100-140', u'140-220', u'220-300', u'300-330']
        
        self.assertEqual(self.widgetcfg[testx+1][0]['values'],expected_results)

    def test_row1_colheader(self):
    
        expected_results = [u'Nathaniel', u'Clayton', u'Bruno', u'Orig', u'Stephen', u'Oscar', u'Peter', u'Jack', u'Jake', u'Stephen A', u'Coby', u'Thomas', u'Yosef', u'Tris', u'Ashley', u'SimonA', u'Booker', u'OmerC', u'JackB']
       
        self.assertEqual(self.widgetcfg[0][1]['values'],expected_results)

 
class Test_Dropdown(unittest.TestCase):
    def setUp(self):
        
        self.database = Database(CURRENTDIR+"/"+THISEXEC+"/"+'test_sswizard')
        self.classtbl = 'class'
        self.maxx = 8
        self.maxy = 10

    def test_col1(self):
        prep=5
        widget_args=dict(background='white')
        
        widgetcfg = nxnarraycreate(self.maxx,self.maxy,widget_args)
        widgetcfg = dropdown_build(self.database,widgetcfg,_execfunc,prep,"MO")
       
        expected_results =[u'??.??.??.MO', u'AMEL.AC.ELA.MO', u'PARC.AC.ENG.MO', u'STAN.BK.DRA.MO']
        
        expected_results.sort()
        
        results = widgetcfg[1][1]['values']
        results.sort()
        
        self.assertListEqual(results,expected_results)

    def test_col2(self):
        prep =5
        widget_args=dict(background='white')
         
        widgetcfg = nxnarraycreate(self.maxx,self.maxy,widget_args)
        widgetcfg = dropdown_build(self.database,widgetcfg,_execfunc,prep,"MO")
        
        expected_results = [u'??.??.??.MO',u'??.BK.MOVE.MO',u'??.PY.SPCH.MO',u'ALEX.??.??.MO',u'AMEL.AC.ELA.MO',u'PARC.AC.SC.MO']        
        expected_results.sort()
        
        results = widgetcfg[1][2]['values']
        results.sort()
        
        self.assertListEqual(results,expected_results)
         
    def test_col3(self):
        prep=5
        widget_args=dict(background='white')
         
        widgetcfg = nxnarraycreate(self.maxx,self.maxy,widget_args)
        widgetcfg = dropdown_build(self.database,widgetcfg,_execfunc,prep,"MO")
        
        expected_results = [u'??.??.??.MO',u'??.BK.SN.MO',u'??.PY.SPCH.MO',u'ALEX.??.??.??',u'AMEL.AC.ELA.MO',u'PARC.AC.SC.MO']
        
        expected_results.sort()
        
        results = widgetcfg[1][3]['values']
        results.sort()
        
        self.assertEqual(results,expected_results)

class Test_GetEnums(unittest.TestCase):
    def setUp(self):
        
        self.database = Database(CURRENTDIR+"/"+THISEXEC+"/"+'test_sswizard')
        self.enums =  setenums('all','5',self.database)
        
    def test_prep3_students_name(self):
        
        expected_results = [u'Nathaniel', u'Clayton', u'Bruno', u'Orig', u'Stephen', u'Oscar', u'Peter', u'Jack', u'Jake', u'Stephen A', u'Coby', u'Thomas', u'Yosef', u'Tris', u'Ashley', u'SimonA', u'Booker', u'OmerC', u'JackB', '??']
        
        self.assertListEqual(expected_results,self.enums['student']['name'])

    def test_prep3_students_name2enum(self):
        
        expected_results = OrderedDict([(u'Nathaniel', 1), (u'Clayton', 2), (u'Bruno', 3), (u'Orig', 4), (u'Stephen', 5), (u'Oscar', 6), (u'Peter', 7), (u'Jack', 8), (u'Jake', 9), (u'Stephen A', 10), (u'Coby', 11), (u'Thomas', 12), (u'Yosef', 13), (u'Tris', 14), (u'Ashley', 15), (u'SimonA', 16), (u'Booker', 17), (u'OmerC', 18), (u'JackB', 19)])
                
        self.assertEqual(expected_results,self.enums['student']['name2enum'])

    def test_prep3_get_code_name2code(self):
        
        expected_results = OrderedDict([(u'Nathaniel', u'NATH'), (u'Clayton', u'CLAY'), (u'Bruno', u'BRUN'), (u'Orig', u'ORIG'), (u'Stephen', u'STNA'), (u'Oscar', u'OSCA'), (u'Peter', u'PETR'), (u'Jack', u'JCKA'), (u'Jake', u'JAKE'), (u'Stephen A', u'STNB'), (u'Coby', u'COBY'), (u'Thomas', u'THOM'), (u'Yosef', u'YOSF'), (u'Tris', u'TRIS'), (u'Ashley', u'ASHL'), (u'SimonA', u'SIMA'), (u'Booker', u'BOOK'), (u'OmerC', u'OMRC'), (u'JackB', u'JCKB'), ('??', '??')])
        
        self.assertEqual(expected_results,self.enums['student']['name2code'])
        
class Test_DBLoader(unittest.TestCase):
    
    def setUp(self):
        
        self.databasename = CURRENTDIR+"/"+THISEXEC+"/"+"quad"

        self.database = Database(self.databasename)
        
        self.cols = ['col1','col2']
        self.rows = [['val1','val2']]
        
    def test_(self):
        
        dbinsert(self.database,'session2',self.rows,self.cols)
        
        with self.database:
            
            _,rows,_ = tbl_rows_get(self.database,'session2',self.cols)
        
            print rows
        
    def tearDown(self):
        copyfile(self.databasename+".sqlite.backup",
                 self.databasename+".sqlite")

class Test_DBInsert_Direct(unittest.TestCase):
    def setUp(self):  

        #Test_Base.setUp(self)
        
        #self.databasename = CURRENTDIR+"/"+THISEXEC+"/"+"test_ssloader"
        self.databasename = CURRENTDIR+"/"+THISEXEC+"/"+"quad"

        self.database = Database(self.databasename)
        
        try:
            with self.database:
                tbl_remove(self.database,'lesson')
                tbl_remove(self.database,'session')
        except:
            pass
        
    def test_lesson(self):
        
        records = [['1250-130', 'TU', 'STEM', 'Thea', u'Simon A','1-on-1'], 
                  ['1030-1110', 'WE', 'Humanities', 'Jess', 'Liam','1-on-1']]
                 
        expected_results = [[u'Liam', u'WE', u'1030-1110', u'Jess', u'Humanities', u'Jess.Humanities.Wednesday.1030-1110', u'4.4.24.16.22'], 
                            [u'Simon A', u'TU', u'1250-130', u'Thea', u'STEM', u'Thea.STEM.Tuesday.1250-130', u'7.2.15.15.21']]
        
        expected_results.sort()
        
        dbinsert_direct(self.database,records,'lesson','test',['period','dow','subject','adult','student','recordtype','numstudents'])
        
        with self.database:
            _,rows,_ = tbl_rows_get(self.database,'lesson',['student','dow','period','teacher','subject','session','userobjid'])
        
        rows.sort()
        
        self.assertListEqual(expected_results,rows)
        
    def tearDown(self):
        copyfile(self.databasename+".sqlite.backup",
                 self.databasename+".sqlite")
        
class Test_DBInsert_Direct_Convert_Input_Types(unittest.TestCase):
    # pass in dow code's instead of names and period enums not names
    def setUp(self):  

        #Test_Base.setUp(self)
        
        self.databasename = CURRENTDIR+"/"+THISEXEC+"/"+"quad"

        self.database = Database(self.databasename)
        
        try:
            with self.database:
                tbl_remove(self.database,'lesson')
                tbl_remove(self.database,'session')
        except:
            pass
        
        
    def test_lesson(self):
        
        records = [[7, 'Tuesday', 'STEM', 'Thea', u'Simon A','1-on-1'], 
                  [6, 'Wednesday', 'Humanities', 'Jess', 'Liam','1-on-1']]
            
        
        expected_results = [[u'Liam', u'WE', u'1210-1250', u'Jess', u'Humanities', u'Jess.Humanities.Wednesday.1210-1250'], [u'Simon A', u'TU', u'1250-130', u'Thea', u'STEM', u'Thea.STEM.Tuesday.1250-130']]
        
        expected_results.sort()
        
        dbinsert_direct(self.database,records,'lesson','test',['period','dow','subject','adult','student','recordtype','numstudents'])
        
        with self.database:
            _,rows,_ = tbl_rows_get(self.database,'lesson',['student','dow','period','teacher','subject','session'])
        
        rows.sort()
        
        self.assertListEqual(expected_results,rows)
        
    def tearDown(self):
        copyfile(self.databasename+".sqlite.backup",
                 self.databasename+".sqlite")
    

class Test_GridReduce(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_1blankcol_1blankrow_space(self):
        
        self.grid = [['','A','B','C'],
                     ['X','','',''],
                     ['Y','foo','',''],
                     ['Z','','','bar']]    

        self.expected_results = [['','A','C'],
                               ['Y','foo',''],
                               ['Z','','bar']]     
        
        gridreduce(self.grid,[""])
        self.assertListEqual(self.grid,self.expected_results)
        
    def test_1blankcol_1blankrow_list(self):
        
        self.grid = [['','A','B','C'],
                     ['X',[],[],[]],
                     ['Y','foo',[],[]],
                     ['Z',[],[],'bar']]    

        self.expected_results = [['','A','C'],
                                 ['Y','foo',[]],
                                 ['Z',[],'bar']]     
        
        gridreduce(self.grid,[[]])
        self.assertListEqual(self.grid,self.expected_results)
        
    def test_allblank_list(self):
        
        self.grid = [['','A','B','C'],
                     ['X',[],[],[]],
                     ['Y',[],[],[]],
                     ['Z',[],[],[]]
                     ]

        self.expected_results = [['']]
        
        gridreduce(self.grid,[[]])
        self.assertListEqual(self.grid,self.expected_results)
        
    def test_noblank_list(self):
        
        import copy
        
        self.grid = [['','A','B','C'],
                     ['X',['blah'],['blah'],['blah']],
                     ['Y',['foo'],['blah'],['blah']],
                     ['Z',['blah'],['blah'],['bar']]]
        
        self.expected_results = copy.deepcopy(self.grid)
        
        gridreduce(self.grid,[[]])
        self.assertListEqual(self.grid,self.expected_results)
        
        
    def test_1blankcol_1blankrow_space_list(self):
        
        self.grid = [['','A','B','C'],
                     ['X',[],'',''],
                     ['Y','foo',[],''],
                     ['Z','','','bar']]    

        self.expected_results = [['','A','C'],
                                 ['Y','foo',''],
                                 ['Z','','bar']]     
        
        gridreduce(self.grid,["",[]])
        self.assertListEqual(self.grid,self.expected_results)
        
        
    def test_1blankcol_1blankrow_space_rectangle(self):
        
        self.grid = [['','A','B','C','D'],
                     ['X','','','',''],
                     ['Y','foo','','','blah'],
                     ['Z','','','bar','blah']]    

        self.expected_results = [['','A','C','D'],
                               ['Y','foo','','blah'],
                               ['Z','','bar','blah']]     
        
        gridreduce(self.grid,[""])
        self.assertListEqual(self.grid,self.expected_results)
        
        
    def test_realexample(self):        
        self.grid = [['', u'MO', u'TU', u'TH', u'WE', u'FR'], 
                     [u'830-910', [(u'Amelia', u'ELA')], [], [], [], []], 
                     [u'910-950', [], [], [], [], []], 
                     [u'950-1030', [], [], [], [], []], 
                     [u'1030-1110', [], [], [], [], []], 
                     [u'1110-1210', [], [], [], [], []], 
                     [u'1210-100', [], [], [], [], []], 
                     [u'100-140', [], [], [], [], []], 
                     [u'140-220', [], [], [], [], []], 
                     [u'220-300', [], [], [], [], []], 
                     [u'300-330', [], [], [], [], []]]
        
        self.expected_results = [['', u'MO'], [u'830-910', [(u'Amelia', u'ELA')]]]

        
        gridreduce(self.grid,["",[]])
        self.assertListEqual(self.grid,self.expected_results)
    
class Test_GridRollup(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_cellrollup1(self):
        
        self.grid = [(u'Movement', u'Dylan', u'Peter'), 
                     (u'Movement', u'Dylan', u'Clayton')] 

        self.expected_results = [(u'Movement', u'Dylan', u'Peter,Clayton')]
        
        results = cellrollup(self.grid,['subject','adult'],dict(ztypes='subject,adult,student'))
        
        self.assertListEqual(results,self.expected_results)
        
    def test_cellrollup2(self):
        
        self.grid = [(u'Movement', u'Dylan', u'Peter'), 
                     (u'Movement', u'Dylan', u'Clayton'),
                     (u'Math', u'Dylan', u'Clayton')] 

        self.expected_results = [(u'Movement', u'Dylan', u'Peter,Clayton'),
                                 (u'Math', u'Dylan', u'Clayton')]
        
        results = cellrollup(self.grid,['subject','adult'],dict(ztypes='subject,adult,student'))
        
        results.sort()
        self.expected_results.sort()
        
        self.assertListEqual(results,self.expected_results)
        
    def test_cellrollup3(self):
        
        self.grid = [(u'Movement', u'Dylan', u'Peter'), 
                     (u'Movement', u'Dylan', u'Clayton'),
                     (u'Math', u'Dylan', u'Clayton'),
                     (u'Math', u'Dylan', u'Peter'),
                     (u'Science', u'Dylan', u'Brian')] 

        self.expected_results = [(u'Movement', u'Dylan', u'Peter,Clayton'),
                                 (u'Math', u'Dylan', u'Clayton,Peter'),
                                 (u'Science', u'Dylan', u'Brian')]
        
        results = cellrollup(self.grid,['subject','adult'],dict(ztypes='subject,adult,student'))
        
        results.sort()
        self.expected_results.sort()
        
        self.assertListEqual(results,self.expected_results)
        
    def test_cellrollup4(self):
        
        self.grid = [(u'Movement', u'Dylan', u'Peter'), 
                     (u'Movement', u'Gale', u'Clayton')] 

        self.expected_results = [(u'Movement', u'Dylan,Gale', u'Peter,Clayton')]
        
        results = cellrollup(self.grid,['subject'],dict(ztypes='subject,adult,student'))
        
        self.assertListEqual(results,self.expected_results)
        
    def test_cellrollup5(self):
        
        self.grid = [(u'Movement',  u'Peter'), 
                     (u'Movement',  u'Clayton')] 

        self.expected_results = [(u'Movement', u'Peter,Clayton')]
        
        results = cellrollup(self.grid,['subject'],dict(ztypes='subject,student'))
        
        self.assertListEqual(results,self.expected_results)
        
    def test_gridrollup1(self):        
        self.grid = [['', u'MO'], 
                     [u'830-910', [(u'Movement', u'Dylan', u'Peter'), 
                                   (u'Movement', u'Dylan', u'Clayton')]
                      ]
                     ] 

        self.expected_results = [['', u'MO'], 
                     [u'830-910', [(u'Movement', u'Dylan', u'Peter,Clayton')]
                      ]
                     ]

        gridrollup(self.grid,['subject','adult'],dict(ztypes='subject,adult,student'))
        self.assertListEqual(self.grid,self.expected_results)
        
    def test_gridrollup2(self):        
        self.grid = [['', u'MO',u'TU'], 
                     [u'830-910', [(u'Movement', u'Dylan', u'Peter'), (u'Movement', u'Dylan', u'Clayton')],[]
                      ]
                     ] 

        self.expected_results = [['', u'MO',u'TU'], 
                     [u'830-910', [(u'Movement', u'Dylan', u'Peter,Clayton')],[]
                      ]
                     ]

        gridrollup(self.grid,['subject','adult'],dict(ztypes='subject,adult,student'))
        self.assertListEqual(self.grid,self.expected_results)
        
if __name__ == "__main__":
    suite = unittest.TestSuite()

    '''suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GridRollup))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GridReduce))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Dropdown))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_With_Headers))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_GetEnums))'''
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DBLoader))
    
    # dbinsert_direct
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DBInsert_Direct))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DBInsert_Direct_Convert_Input_Types))
    
    unittest.TextTestRunner(verbosity=2).run(suite) 


