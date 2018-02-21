from Tkinter import *
#from Tkinter import Button as Tkbutton
#from Tkinter import Label as Tklabel
from ttk import *
#from PIL import Image, ImageTk
from image_utils import ImageCreate, rgbstr_get, get_gif_filename
from collections import OrderedDict
from misc_utils_process import *
from misc_utils_enum import enum
from misc_utils import nxnarraycreate

from type_utils import SetMemberPartial, DBSetMember, TextAlphaNumRO, TrueFalse


from ui_utils import TkImageWidget, TkImageLabelGrid, geometry_get, font_scale, \
     tkwidgetfactory, geometry_get_dict, tkwidgetimage_set, fontscale, \
     TkCombobox, TkButton, TkEntry, TkLabel, Tk3Label, TkNLabel
import tkFont
import unittest

from format_utils import *
from type_utils import TextAlphaNum, TextAlphaNumRO, SetMemberPartial, DBSetMember
from ui_utils import tk_create_config, tkfrm_cfg, \
     tk_create_frame, tk_label_get_image
from test_ui_utils2 import TestWidget
import time

class TestUILabelImageGrid(TestWidget):

    def setUp(self):
        self.master = Tk()

        self.maxrows=2 # rows in the grid
        self.maxcols=2 # cols in the grid

        self.wmheight=400 # master height
        self.wmwidth=400 # master width

        #geom = geometry_get(self.wmheight,self.wmwidth,0,0)

        #self.master.geometry(geom)

        image_args = dict(pointsize=12,font='Helvetica',gravity='center',
                          rotate=90,label='foobar')
        gridcfg = nxnarraycreate(self.maxrows,self.maxcols,image_args)

        widget_args={}
        widgetcfg = nxnarraycreate(self.maxrows,self.maxcols,
                                   widget_args)

        gridcfg[1][1]['rotate'] = 270

        self.mytextalphanumro = TextAlphaNumRO(name='set')
        #self.mytextalphanumro.widgettype = TkNLabel

        self.tkilg = TkImageLabelGrid(self.master,'grid',self.mytextalphanumro,self.wmwidth,self.wmheight,
                                      0,0,
                                      self.maxrows,self.maxcols,
                                      True,False,
                                      gridcfg,widgetcfg,
                                      1)

        self.tkilg.grid(row=0,column=0,sticky=NSEW)
        self.tkilg.grid_rowconfigure(0, weight=1, uniform="foo")
        self.tkilg.grid_columnconfigure(0, weight=1, uniform="foo")

        self.tkilg.image_set()
        #self.tkilg.grid(row=0,column=0,sticky=NSEW)

    def test_topleft(self):
        pass

        self.master.mainloop()
        #widget = self.tkilg.widgets[0][0]

        #exp_res = get_gif_filename('/home/burtnolej/Development/pythonapps3/clean/utils/test_gifs',
        #                           widget.label,widget.image_args)

        #self.assertFilesEqual(exp_res,widget.image)

    '''def test_bottomright(self):

        widget = self.tkilg.widgets[1][1]

        exp_res = get_gif_filename('/home/burtnolej/Development/pythonapps3/clean/utils/test_gifs',
                                   widget.label,widget.image_args)

        self.assertFilesEqual(exp_res,widget.image)


    def test_topright(self):

        widget = self.tkilg.widgets[0][1]

        exp_res = get_gif_filename('/home/burtnolej/Development/pythonapps3/clean/utils/test_gifs',
                                   widget.label,widget.image_args)

        self.assertFilesEqual(exp_res,widget.image)

    def test_bottomleft(self):

        widget = self.tkilg.widgets[1][0]

        exp_res = get_gif_filename('/home/burtnolej/Development/pythonapps3/clean/utils/test_gifs',
                                   widget.label,widget.image_args)

        self.assertFilesEqual(exp_res,widget.image)'''

    def tearDown(self):
        self.master.destroy()
        
class TestUISchedulerNLabel(TestWidget):
    def setUp(self):
        self.master = Tk()
        self.master.geometry("400x200+0+0")
   
        self.maxrows=3 # rows in the grid
        self.maxcols=3 # cols in the grid
        self.maxwidgets=self.maxrows*self.maxcols
        self.wwidth=48 # default button width with text of 3 chars
        self.wheight=29 # default button height
        self.wmheight=self.wheight*self.maxrows # master height
        self.wmwidth=self.wwidth*self.maxcols # master width
      
        #font = tkFont.Font(family="monospace", size=12) 
        self.style = Style()
        self.style.theme_use("default")
        
        self.mytextalphanum = TextAlphaNum(name='textalphanum')
        widget_args=dict(background='white',width=9)
        widgetcfg = nxnarraycreate(self.maxrows,self.maxcols,widget_args)

        self.mytextalphanum.widgettype = TkNLabel
        self.tkilg = TkImageLabelGrid(self.master,'grid',self.mytextalphanum,
                                      self.wmwidth,self.wmheight,
                                      0,0,self.maxrows,self.maxcols
                                      ,True,True,{},widgetcfg)

        self.tkilg.grid(row=0,column=0,sticky=NSEW)
        self.master.grid_rowconfigure(0, weight=1, uniform="foo")
        self.master.grid_columnconfigure(0, weight=1, uniform="foo") 
        
    def test_(self):
        
        values = [['a','b','c'],['d','e','f'],['g','h','i']]
        
        for x in range(len(values)):
            for y in range(len(values[x])):
                widget = self.tkilg.widgets[x][y]
                _value = values[x][y]
                widget.addlabel(1,True,_value,'red','blue')
                
        self.assertTrue(hasattr(self.tkilg.widgets[0][0],"addlabel"))
        
        
class TestUIGridFocusAppObject(TestWidget):
    def setUp(self):
        
        class UI(Tk):
            
            def __init__(self):
                
                Tk.__init__(self)
                
                self.maxrows=10 # rows in the grid
                self.maxcols=10 # cols in the grid
                self.maxwidgets=self.maxrows*self.maxcols
                self.wwidth=48 # default button width with text of 3 chars
                self.wheight=29 # default button height
                self.wmheight=self.wheight*self.maxrows # master height
                self.wmwidth=self.wwidth*self.maxcols # master width
        
                members = ['pineapple','grapefruit','banana',
                           'peach','pomegranate','passionfruit',
                           'pear','grape','strawberry','raspberry',
                           'rhubarb','mango','guava','apple',
                           'Orange']      
                widget_args=dict(background='white',values=members)
                widgetcfg = nxnarraycreate(self.maxrows,self.maxcols,widget_args)
        
        
                self.setmemberp = SetMemberPartial(name='x{mylist}',set=members)
                
                self.tkilg = TkImageLabelGrid(self.master,'grid',self.setmemberp,self.wmwidth,self.wmheight,
                                              0,0,7,5,{},widgetcfg)
                
                self.tkilg.grid(row=0,column=0,sticky=NSEW)
    
                self.grid_rowconfigure(0, weight=1, uniform="foo")
                self.grid_columnconfigure(0, weight=1, uniform="foo")
            
        self.ui = UI()
    
        self.ui.update()
        parent_name = self.ui.tkilg.widgets[0][0].winfo_parent()
        self.parent_widget = self.ui.tkilg.widgets[0][0]._nametowidget(parent_name)
        self.parent_widget.update()    

    def test_rightarrow_moveright(self):
        
        self.ui.tkilg.widgets[0][0].focus_set()
        self.ui.tkilg.update()
        self.parent_widget.update()
        self.ui.tkilg.widgets[0][0].event_generate("<Right>",when="tail")
        
        _,new_x,new_y = str(self.parent_widget.focus_get()).split(",")
        
        
        self.assertEqual(new_x,'0')
        self.assertEqual(new_y,'1')
        
    '''def test_rightarrow_moveright_highlightcolor(self):
        
        self.ui.tkilg.widgets[0][0].event_generate("<Right>")
        _,new_x,new_y = str(self.parent_widget.focus_get()).split(",")
        
        self.assertEqual(new_x,'0')
        self.assertEqual(new_y,'1')
        
        self.ui.update()

        self.assertEqual(self.ui.tkilg.widgets[int(new_x)][int(new_y)]['style'].split(".")[0],'InFocus')
        
    def test_rightarrow_moveright_unhighlightcolor(self):
        
        self.ui.tkilg.widgets[0][0].event_generate("<Right>")
        self.parent_widget.focus_get().event_generate("<Left>")
        _,new_x,new_y = str(self.parent_widget.focus_get()).split(",")
        self.ui.update()

        self.assertEqual(self.ui.tkilg.widgets[0][1]['style'].split(".")[0],'OutOfFocus')
    
    def test_rightarrow_moveright1_down1(self):
        
        self.ui.tkilg.widgets[0][0].event_generate("<Right>")
        self.parent_widget.focus_get().event_generate("<Down>")
        
        _,new_x,new_y = str(self.parent_widget.focus_get()).split(",")
              
        self.assertEqual(new_x,'1')
        self.assertEqual(new_y,'1')'''
        
    def tearDown(self):
        self.ui.destroy()
        
if __name__ == "__main__":

    suite = unittest.TestSuite()
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestUISchedulerNLabel)) 
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestUIGridFocusAppObject)) 
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestUILabelImageGrid)) 
    
    
    
    
    unittest.TextTestRunner(verbosity=2).run(suite)
    exit()