
import sys

from utils.misc_basic.misc_utils_generic import GenericBase

class enum(GenericBase):
    pass
    
'''return(GenericBase.datamembers(datamembers=kwarg))
        
def __getattribute__(self,attr):
    return super(GenericBase, self.gbase).__getattribute__("_dm_"+attr)

def getter(self,key):
    mangle = "_dm_" + key
    return(getattr(self,mangle)'''
    
