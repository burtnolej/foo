from Tkinter import *
from Tkinter import Button as Tkbutton
from Tkinter import Label as Tklabel
from Tkinter import Entry as Tkentry

#from Tkinter import Entry as Tkentry
from ttk import *

import tkFont
import unittest

from ui_utils_tkventry import TkValidEntry, BaseTkValidEntry

from ui_utils import geometry_get,  tkwidgetfactory, geometry_get_dict, TkCombobox, TkEntry, TkGridCombobox
from type_utils import BoundRealInt, SetMember, SetMemberPartial, DBSetMember, BaseType

#fontscale = enum(sy = 2500,sx = 3500,
#                 minfpt = 8,maxfpt = 64,
#                 minwy=50,minwx=50)

defaultmaster = dict(height=300,width=200,x=400,y=100)

defaultframe = dict(height=300,width=200,x=0,y=0)

fullscreenmaster = dict(height=2500,width=3500,x=0,y=0)
        
class TestTkValidEntryBInt(unittest.TestCase):
    def setUp(self):

        self.master = Tk() 
        
        class MyEntry(Frame):
            
            def __init__(self,master):

                master.geometry(geometry_get_dict(defaultmaster))  
        
                Frame.__init__(self,master)
            
                sv = StringVar()
                self.sv = sv
        
                #self.boundint = BoundRealInt(name='40>=x<=60',ubound=60,lbound=40)
                self.boundint = BaseType()
                
        
                #self.entry= tkwidgetfactory(self,self.boundint,self,self,
                #                            textvariable=self.sv)
                
                #self.entry = Tkentry(textvariable=self.sv)
                self.entry = TkEntry(self,self.boundint)
        
                #self.ventry = TkValidEntry(self.master,'foobar',8,0,self.boundint)
                self.entry.grid(row=0,sticky=NSEW)
                self.entry.focus_set()
                
                master.rowconfigure(0,uniform='foo2')
                
        self.myentry = MyEntry(self.master)
        
    def test_55_True(self):
        
        
        self.myentry.mainloop()
        
        #self.ventry.sv.set(55)
        #self.assertEqual(self.ventry.statuslabel.cget('background'),'lime')
        #self.master.mainloop()
        
    #def test_65_True(self):
    #    self.ventry.sv.set(65)
    #    #self.assertEqual(self.ventry.statuslabel.cget('background'),'pink')
    #    self.master.mainloop()
        
    def tearDown(self):
        self.master.destroy()
        
class TestBaseTkValidEntrySetMember(unittest.TestCase):
    def setUp(self):
        self.master = Tk()
        self.master.geometry(geometry_get_dict(defaultmaster))  
        
        values = ['pineapple','grapefruit','banana',
                  'peach','pomegranate','passionfruit',
                  'pear','grape','strawberry','raspberry',
                  'rhubarb','mango','guava','apple',
                  'Orange']
        
        self.setmemberp = SetMemberPartial(name='x{mylist}',set=values)
        self.ventry = tkwidgetfactory(self.master,self.setmemberp,self.master,self.master,
                                    name="entry,0,0")
        
        self.ventry.s.theme_use("default")
    
        #self.ventry.name = "entry,0,0"
        
        setattr(self.ventry,"orig_values",values)
        
        #self.ventry.pack()
        self.ventry.grid(row=0,sticky=NSEW)
        #self.ventry.entry.focus_set()
        
        black_on_yellow = ".".join(['InFocus','Invalid',self.ventry.winfo_class()])
        green_arrow = ".".join(['InFocus','Valid',self.ventry.winfo_class()])
        
        self.ventry.s = Style()
    
        self.ventry.s.configure(black_on_yellow,
                               fieldbackground='yellow',
                               foreground='black')
        
        self.ventry.s.configure(green_arrow,
                               background='green',
                               foreground='black')
    
        self.ventry['style'] = black_on_yellow

        self.master.rowconfigure(0,uniform='foo2')
        
    def test_Pomegranate_True(self):
        #self.ventry.sv.set('pomegranate')
        #self.assertEqual(self.ventry.statuslabel.cget('background'),'lime')
        self.master.mainloop()
        
    def tearDown(self):
        self.master.destroy()
        
if __name__ == "__main__":

    suite = unittest.TestSuite()
     
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestBaseTkValidEntrySetMember))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTkValidEntryBInt))
    
    unittest.TextTestRunner(verbosity=2).run(suite)
