import sys
import os
from os import path as ospath

from Tkinter import *
from ttk import *
from os import remove, path
import unittest

from shutil import copyfile

from sswizard import schoolschedgeneric, WizardUI
from database_util import Database
from database_table_util import tbl_rows_get
from misc_utils_objectfactory import ObjFactory
from ui_utils_event import get_event
import time

class Test_Base(unittest.TestCase):
    def setUp(self,dbname,refdbname):
        dbpath = '/Users/burtnolej/Development/pythonapps3/clean/apps/schoolschedulewizard/'
        self.dbname = dbname
        self.dbfilename = path.join(dbpath,self.dbname)
        self.database = Database(self.dbfilename)
        self.of = ObjFactory(True)
        self.ui = WizardUI(self.dbname, self.of,refdbname,maxentrycols=6,maxentryrows=6)       
        self.ui.dbname_entry_sv.set(dbname)
        
        parent_name = self.ui.entrygrid.widgets[0][0].winfo_parent()
        self.parent_widget = self.ui.entrygrid.widgets[0][0]._nametowidget(parent_name)
        self.parent_widget.update()
        
    def _focus_force(self,widget):
        widget.focus_force()
        

    def tearDown(self):
        self.ui.destroy()
        copyfile(self.dbfilename+".sqlite.backup",self.dbfilename+".sqlite")


class Test_Grid_Behaviour_Focus(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(2)
        
    def test_rightarrow_moveright(self):
        
        # move right and focus in event for widget[1,2]
        event = get_event('Right','entrygrid',1,1)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[1][2].highlight(event)
        
        self._focus_force(self.ui.entrygrid.widgets[1][2])
        
        _,new_x,new_y = str(self.parent_widget.focus_get()).split(",")
            
        self.assertEqual(new_x,'1')
        self.assertEqual(new_y,'2')
        
    def tearDown(self):
        self.ui.destroy()
        
class Test_Grid_Behaviour_Update_Combobox(Test_Base):
    def setUp(self):
        
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')

        self.widget = self.ui.entrygrid.widgets[0][1]
        self._focus_force(self.ui.entrygrid.widgets[0][1])
        self.ui.dropdowns_set()
    
    def test_rightarrow_moveright(self):
        
        self.widget.insert(0,'8')
        self.ui.update()
        
        self.assertEqual(self.widget.sv.get(),'830-910')

        self.assertEqual(self.widget['style'],'InFocus.Valid.TCombobox')
        
    def tearDown(self):
        self.ui.destroy()

class Test_Grid_Behaviour_Update_Combobox_Reset(Test_Base):
    def setUp(self):
        
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')

        self.widget = self.ui.entrygrid.widgets[0][1]
        self._focus_force(self.ui.entrygrid.widgets[0][1])
        self.ui.dropdowns_set()
    
    def test_(self):
        
        self.widget.insert(0,'8')
        self.ui.update()
        
        self.widget.delete(0,END)
        
        self.assertEqual(self.widget.sv.get(),'')
        
        self.widget.insert(0,'8')
        self.ui.update()
        
        self.assertEqual(self.widget.sv.get(),'830-910')

        self.assertEqual(self.widget['style'],'InFocus.Valid.TCombobox')
        
    def tearDown(self):
        self.ui.destroy()
        
class Test_Grid_Behaviour_After_Load(Test_Base):
    def setUp(self):
        
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')

        self.colhdrwidget = self.ui.entrygrid.widgets[1][1]
        self.rowhdrwidget = self.ui.entrygrid.widgets[0][1]
        self.valuewidget = self.ui.entrygrid.widgets[1][0]
        
        self.ui.load(2)
    
    def test_(self):
        
        self.assertEqual(self.colhdrwidget['style'],'OutOfFocus.Invalid.TCombobox')
        self.assertEqual(self.rowhdrwidget['style'],'OutOfFocus.Invalid.TCombobox')
        self.assertEqual(self.valuewidget['style'],'OutOfFocus.Invalid.TCombobox')
                
    def tearDown(self):
        self.ui.destroy()
        
class Test_Grid_Behaviour_Headers_Highlight(Test_Base):
    def setUp(self):
        
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.valuewidget = self.ui.entrygrid.widgets[2][2]
        self._focus_force(self.ui.entrygrid.widgets[2][2])
        
        self.valuewidget.focus_set()

    def test_(self):
        
        self.ui.update()
        self.assertEqual(self.valuewidget['style'],'InFocus.Invalid.TCombobox')
        self.assertEqual(self.valuewidget.xhdrwidget['style'],'InFocus.Invalid.TCombobox')
        self.assertEqual(self.valuewidget.yhdrwidget['style'],'InFocus.Invalid.TCombobox')
                
    def tearDown(self):
        self.ui.destroy()
        
class Test_Grid_Behaviour_Single_Cell_Copy_Paste(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(0)
    
        self.ui.entrygrid.widgets[2][0].sv.set('Tristan')
    
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        self.ui.event_generate("<Control-c>")
        
        self.ui.update()
        
    def test_copy(self):
        
        self.assertListEqual(self.ui.clipboard,[[(1,1)]])
        
    def test_paste(self):
        
        self.ui.entrygrid.widgets[2][1].focus_set()
        
        self.ui.event_generate("<Control-v>")
        
        self.assertEquals(self.ui.entrygrid.widgets[2][1].sv.get(),"PARC.AC.ENG.MO")
        
    def test_cleanup(self):
        
        self.ui.entrygrid.widgets[2][1].focus_set()
        
        self.ui.event_generate("<Control-v>")
        
        self.assertEquals(self.ui.current_inputmode,"Normal")
        
    def test_cleanup_next_mode(self):
        
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Right>")
        self.ui.update()
        
        compare_list = [(2,1),(2,2),(2,3),(2,4)]
        
        for  x,y in compare_list:
            self.assertEquals(self.ui.entrygrid.widgets[x][y]['style'],'OutOfFocus.Invalid.TCombobox')
        
        
class Test_Grid_Behaviour_Square_Range_Copy_Paste(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(0)
    
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        self.ui.event_generate("<Control-s>")
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Down>")
        self.ui.event_generate("<Left>")
        self.ui.update()
        
        self.ui.event_generate("<Control-c>")                     
        
    def test_copy(self):
        
        self.assertListEqual(self.ui.clipboard,[[(1,1),(1,2),(2,1),(2,2)]])
        
    def test_paste(self):
        
        self.ui.entrygrid.widgets[3][3].focus_set()
        
        self.ui.event_generate("<Control-v>")
        
        compare_list = [(1,1),(3,3)],[(1,2),(3,4)],[(2,1),(4,3)],[(2,2),(4,4)]
        
        for compare in compare_list:
            ox,oy = compare[0]
            tx,ty = compare[1]
            
            self.assertEquals(self.ui.entrygrid.widgets[ox][oy].sv.get(),
                              self.ui.entrygrid.widgets[tx][ty].sv.get())
        
    def test_cleanup_next_mode(self):
        
        self.ui.entrygrid.widgets[3][3].focus_set()
        
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Right>")
        self.ui.update()
        
        compare_list = [(3,3),(3,4),(3,5)]

        for  x,y in compare_list:
            self.assertNotEquals(self.ui.entrygrid.widgets[x][y]['style'],'Select.Invalid.TCombobox')
            
        
class Test_Grid_Behaviour_2x_Single_Cell_Copy_Paste(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(0)
    
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        self.ui.event_generate("<Control-c>")
        
        self.ui.update()
        
        self.ui.entrygrid.widgets[2][1].focus_set()
        
        self.ui.event_generate("<Control-v>")

        self.ui.update()    
        self.ui.entrygrid.widgets[1][2].focus_set()
    
        self.ui.event_generate("<Control-c>")

        self.ui.update()        
        self.ui.entrygrid.widgets[2][2].focus_set()
        
        self.ui.event_generate("<Control-v>")
        
        self.ui.update()
        
    def test_(self):
        
        compare_list = [(1,1),(2,1)],[(1,2),(2,2)]
        
        for compare in compare_list:
            ox,oy = compare[0]
            tx,ty = compare[1]
            
            self.assertEquals(self.ui.entrygrid.widgets[ox][oy].sv.get(),
                              self.ui.entrygrid.widgets[tx][ty].sv.get())
            
    def test_cleanup_next_mode(self):
        
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Right>")
        self.ui.update()
        
        compare_list = [(2,2),(2,3),(2,4)]

        for  x,y in compare_list:
            self.assertNotEquals(self.ui.entrygrid.widgets[x][y]['style'],'Select.Invalid.TCombobox')

class Test_Grid_Behaviour_Clipboard_Clear(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(2)

        # initial focus set on widget[1,1]
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        # set select mode
        event = get_event('ctrl-s','entrygrid',1,1)
        self.ui.entrygrid.modeset(event)

        # focus out event for widget[1,1]
        event = get_event('Right','entrygrid',1,1,'10')        
        self.ui.entrygrid.widgets[1][1].highlight(event)
        
        # move right and focus in event for widget[1,2]
        event = get_event('Right','entrygrid',1,1)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[1][2].highlight(event)

        # focus out event for widget[1,2]
        event = get_event('Down','entrygrid',1,2,'10')        
        self.ui.entrygrid.widgets[1][2].highlight(event)
        
        # focus in event for widget[2,2]
        event = get_event('Down','entrygrid',1,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][2].highlight(event)

        # focus out event for widget[2,2]
        event = get_event('Left','entrygrid',2,2,'10')        
        self.ui.entrygrid.widgets[2][2].highlight(event)
        
        # focus in event for widget[2,1]
        event = get_event('Left','entrygrid',2,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
        # focus out event for widget[2,1]
        # note that im not sure why this focus out event is required for the test 
        # to work as it does not seem to behave that way at normal runtime
        event = get_event('Left','entrygrid',2,1,'10')        
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
    def test_clear(self):
        
        event = get_event('ctrl-c','entrygrid',2,1,'2')
        self.ui.entrygrid.modeset(event)

        compare_list = [[(1,1),(1,2),(2,1),(2,2)]]
        self.assertEquals(self.ui.entrygrid.clipboard,compare_list)
            
        event = get_event('ctrl-R','entrygrid',2,1,'2')
        self.ui.entrygrid.modeset(event) 
        
        self.assertEquals(self.ui.entrygrid.clipboard,[])
            
class Test_Grid_Behaviour_Select_Next_Value(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(2)
        
        self.ui.dropdowns_set()
        
        #self.ui.mainloop()
    
    def test_():
        pass

class Test_Grid_Behaviour_Selection_Clear(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(2)

        # initial focus set on widget[1,1]
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        # set select mode
        event = get_event('ctrl-s','entrygrid',1,1)
        self.ui.entrygrid.modeset(event)

        # focus out event for widget[1,1]
        event = get_event('Right','entrygrid',1,1,'10')        
        self.ui.entrygrid.widgets[1][1].highlight(event)
        
        # move right and focus in event for widget[1,2]
        event = get_event('Right','entrygrid',1,1)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[1][2].highlight(event)

        # focus out event for widget[1,2]
        event = get_event('Down','entrygrid',1,2,'10')        
        self.ui.entrygrid.widgets[1][2].highlight(event)
        
        # focus in event for widget[2,2]
        event = get_event('Down','entrygrid',1,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][2].highlight(event)

        # focus out event for widget[2,2]
        event = get_event('Left','entrygrid',2,2,'10')        
        self.ui.entrygrid.widgets[2][2].highlight(event)
        
        # focus in event for widget[2,1]
        event = get_event('Left','entrygrid',2,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
        # focus out event for widget[2,1]
        # note that im not sure why this focus out event is required for the test 
        # to work as it does not seem to behave that way at normal runtime
        event = get_event('Left','entrygrid',2,1,'10')        
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
    def test_clear(self):
        
        compare_list = [(1,1),(1,2),(2,1),(2,2)]
        
        for  x,y in compare_list:
            self.assertTrue(self.ui.entrygrid.widgets[x][y].copy_state)
            
        
        event = get_event('ctrl-r','entrygrid',2,1,'2')
        self.ui.entrygrid.modeset(event)
        
        for  x,y in compare_list:
            self.assertEquals(self.ui.entrygrid.widgets[x][y]['style'],'OutOfFocus.Invalid.TCombobox')
            self.assertFalse(self.ui.entrygrid.widgets[x][y].copy_state)
            
    '''def test_cleanup_next_mode(self):
        
        self.ui.event_generate("<Control-r>")
        
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Right>")
        self.ui.update()
        
        compare_list = [(2,2),(2,3),(2,4)]

        for  x,y in compare_list:
            self.assertNotEquals(self.ui.entrygrid.widgets[x][y]['style'],'Select.Invalid.TCombobox')'''
            

class Test_Grid_Behaviour_Selection_Cut(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(0)
    
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        self.ui.event_generate("<Control-s>")

        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Down>")
        self.ui.event_generate("<Left>")
        self.ui.update()
        
    def test_cut(self):
        
        self.ui.event_generate("<Control-x>")
        
        compare_list = [(1,1),(1,2),(2,1),(2,2)]
        
        for  x,y in compare_list:
            self.assertEquals(self.ui.entrygrid.widgets[x][y].get(),"")
            
    def test_cleanup_next_mode(self):
        
        self.ui.event_generate("<Control-x>")
        
        self.ui.event_generate("<Right>")
        self.ui.event_generate("<Right>")
        self.ui.update()
        
        compare_list = [(2,2),(2,3),(2,4)]

        for  x,y in compare_list:
            self.assertNotEquals(self.ui.entrygrid.widgets[x][y]['style'],'Select.Invalid.TCombobox')
            

class Test_Grid_Behaviour_Selection_Cut_Paste(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(2)
    
        # initial focus set on widget[1,1]
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        # set select mode
        event = get_event('ctrl-s','entrygrid',1,1)
        self.ui.entrygrid.modeset(event)

        # focus out event for widget[1,1]
        event = get_event('Right','entrygrid',1,1,'10')        
        self.ui.entrygrid.widgets[1][1].highlight(event)
        
        # move right and focus in event for widget[1,2]
        event = get_event('Right','entrygrid',1,1)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[1][2].highlight(event)

        # focus out event for widget[1,2]
        event = get_event('Down','entrygrid',1,2,'10')        
        self.ui.entrygrid.widgets[1][2].highlight(event)
        
        # focus in event for widget[2,2]
        event = get_event('Down','entrygrid',1,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][2].highlight(event)

        # focus out event for widget[2,2]
        event = get_event('Left','entrygrid',2,2,'10')        
        self.ui.entrygrid.widgets[2][2].highlight(event)
        
        # focus in event for widget[2,1]
        event = get_event('Left','entrygrid',2,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
        # focus out event for widget[2,1]
        # note that im not sure why this focus out event is required for the test 
        # to work as it does not seem to behave that way at normal runtime
        event = get_event('Left','entrygrid',2,1,'10')        
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
        self.ui.update()
        
        
    def test_copy(self):
                
        event = get_event('ctrl-c','entrygrid',2,1,'2')
        self.ui.entrygrid.modeset(event)
        
        self.assertListEqual(self.ui.entrygrid.clipboard,[[(1,1),(1,2),(2,1),(2,2)]])
        
    def test_paste(self):
        
        event = get_event('ctrl-c','entrygrid',2,1,'2')
        self.ui.entrygrid.modeset(event)
        
        
        # focus out event for widget[2,1]
        event = get_event('Right','entrygrid',2,1,'10')        
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
        # move right and focus in event for widget[4,1]
        
        event = get_event('Right','entrygrid',1,4)
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[1][4].highlight(event)
        
        # focus out event for widget[4,1]
        self.ui.entrygrid.widgets[1][4].focus_set()
        
        self._focus_force(self.ui.entrygrid.widgets[1][4])
        
        event = get_event('ctrl-v','entrygrid',1,4,'2')
        self.ui.entrygrid.modeset(event)
    
        compare_list = [(1,1),(1,4)],[(2,1),(2,4)],[(1,2),(1,5)],[(2,2),(2,5)]
        
        self.ui.update()
        
        for compare in compare_list:
            ox,oy = compare[0]
            tx,ty = compare[1]
            
            self.assertEquals(self.ui.entrygrid.widgets[ox][oy].sv.get(),
                              self.ui.entrygrid.widgets[tx][ty].sv.get())
                    
class Test_Grid_Behaviour_Paste_From_Multiple_Selections(Test_Base):
    def setUp(self):
        Test_Base.setUp(self,'test_sswizard_grid','test_quadref')
        
        self.ui.load(2)
 
        # initial focus set on widget[1,1]
        self.ui.entrygrid.widgets[1][1].focus_set()
    
        # set select mode
        event = get_event('ctrl-s','entrygrid',1,1)
        self.ui.entrygrid.modeset(event)

        # focus out event for widget[1,1]
        event = get_event('Down','entrygrid',1,1,'10')        
        self.ui.entrygrid.widgets[1][1].highlight(event)
        
        # move right and focus in event for widget[2,1]
        event = get_event('Down','entrygrid',1,1)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][1].highlight(event)
        
        event = get_event('ctrl-c','entrygrid',2,1,'2')
        self.ui.entrygrid.modeset(event)
        
        # initial focus set on widget[1,2]
        self.ui.entrygrid.widgets[1][2].focus_set()
        
        event = get_event('ctrl-s','entrygrid',1,2)
        self.ui.entrygrid.modeset(event)

        # focus out event for widget[1,1]
        event = get_event('Down','entrygrid',1,2,'10')        
        self.ui.entrygrid.widgets[1][1].highlight(event)
        
        # move right and focus in event for widget[2,1]
        event = get_event('Down','entrygrid',1,2)        
        self.ui.entrygrid.refocus(event)
        self.ui.entrygrid.widgets[2][2].highlight(event)
        
        event = get_event('ctrl-c','entrygrid',2,2,'2')
        self.ui.entrygrid.modeset(event)
        
        
    def test_paste(self):
        
        self.assertListEqual(self.ui.entrygrid.clipboard,[[(1, 1), (2, 1)], [(1, 1), (2, 2)]])
        
        
if __name__ == "__main__":
    suite = unittest.TestSuite()

    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Focus))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Selection_Cut_Paste))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Paste_From_Multiple_Selections))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Selection_Clear))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Clipboard_Clear))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_After_Load))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Headers_Highlight))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Update_Combobox))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Update_Combobox_Reset))
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Select_Next_Value))
    
    '''suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Single_Cell_Copy_Paste))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Square_Range_Copy_Paste))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_2x_Single_Cell_Copy_Paste))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Grid_Behaviour_Selection_Cut))
    
    '''
    
    unittest.TextTestRunner(verbosity=2).run(suite)
    

    
            
