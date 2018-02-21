from Tkinter import *
from Tkinter import Button as Tkbutton
from Tkinter import Label as Tklabel
from Tkinter import Entry as Tkentry

from type_utils import BaseType, BoundRealInt

from ui_utils import tkwidgetfactory,geometry_get,geometry_get_dict

defaultmaster = dict(height=300,width=200,x=400,y=100)

master = Tk()

class TkEntry(Frame):
    def __init__(self,*args,**kwargs):
        self.sv=StringVar()    

        master.geometry(geometry_get_dict(defaultmaster)) 
        
        Frame.__init__(self,master)
        
        #self.boundint = BaseType()
        self.boundint = BoundRealInt(name='40>=x<=60',ubound=60,lbound=40)
        
        self.entry= tkwidgetfactory(self,self.boundint,self,self,
                                    textvariable=self.sv)
        
        self.entry.grid(row=0,column=1,sticky=NSEW)
        
        self.label = Tklabel(self,text="foo",width=100,anchor=W,justify=LEFT)
    
        self.label.grid(row=0,column=2,sticky=NSEW)
        
        self.statuslabel = Tklabel(self,text='',width=1,anchor=W,background='lightblue',justify=LEFT)
    
        self.statuslabel.grid(row=0,column=2,sticky=NSEW)
        
        self.sv.trace("w",lambda name, index, mode,
                      sv=self.sv: self.complete())
        
        check out how to pack a widget like on top of sswizard
        calling validate works propperly
        
        
    def complete(self):
        print self.boundint.validate(self.sv.get())
        
if __name__ == "__main__":
    
    tkentry = TkEntry()
    tkentry.grid(row=0,sticky=NSEW)
    master.mainloop()