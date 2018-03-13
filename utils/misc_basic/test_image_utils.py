import unittest
from misc_utils import os_dir_exists, os_file_exists, os_file_delete, bindiff, \
     os_dir_delete
from image_utils import ImageCreate, rgbstr_get, get_gif_filename
from subprocess import call, check_output
import sys
from misc_utils_process import *
from time import sleep
from datetime import datetime
from collections import OrderedDict
from misc_utils_log import Log, logger, PRIORITY
from os import path,chdir
if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"

ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_gifs")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_gifs")
    
log = Log(cacheflag=True,logdir=LOGDIR,verbosity=10)

settings = ['gravity','background','pointsize','font']
image_operator = ['rotate','extent']

IMDIR = "C:\Program Files (x86)\ImageMagick-6.7.5-Q8\\"

class TestImageCreateVeryBasic(unittest.TestCase):
    def test_(self):
        cmd = [IMDIR+'convert','-verbose','label:foobar','foobar.gif']        
        p = process_start(cmd)
        sleep(1)
        self.assertTrue(os_file_exists(ROOTDIR+'\\'+'foobar.gif'))
                        
    def tearDown(self):
        os_file_delete(ROOTDIR+'\\'+'foobar.gif')
       
class TestImageBase(unittest.TestCase):
    def setUp(self):        
        self.ic = ImageCreate()
        self.inputfiles = "foobar"
        self.outputdirname = ImageCreate._getoutputdirname()
        chdir(ROOTDIR)
        
    def tearDown(self):
        import os
        try:
            os_file_delete(self.outputfiles[0])
        except AttributeError:
            # in failure case self.outputfiles is not created
            pass
        os_dir_delete(self.outputdirname,treedel=True)
        
class TestImageCreateBasic(TestImageBase):
    def test_create_1image_basic(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert")})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,self.inputfiles+".gif"),path.join(ROOTDIR,self.outputfiles[0])))
        
class TestImageCreatepointsize(TestImageBase):
    def test_create_1image_pointsize_64(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'pointsize':64})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,"64"+self.inputfiles+".gif"),path.join(ROOTDIR,self.outputfiles[0])))
        
class TestImageCreateBackground(TestImageBase):
    def test_create_1image_background_red(self):
        red = '#%02x%02x%02x' % (255, 0, 0)
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'background':red})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,"ff0000"+self.inputfiles+".gif"),path.join(ROOTDIR,self.outputfiles[0])))
        
class TestImageCreateRotate(TestImageBase):
    def test_create_1image_rotate90(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'rotate':90})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,self.inputfiles+"90.gif"),path.join(ROOTDIR,self.outputfiles[0])))
      
class TestImageCreateextent(TestImageBase):        
    def test_create_1image_extent200x200(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'extent':'200x200'})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,self.inputfiles+"200x200.gif"),path.join(ROOTDIR,self.outputfiles[0])))
            
class TestImageCreateGravity(TestImageBase):
    def test_create_1image_gravitycenter(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'gravity':'center'})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,"center"+self.inputfiles+".gif"),path.join(ROOTDIR,self.outputfiles[0])))
        
class TestImageCreateFont(TestImageBase):
    def test_create_1image_fonthelvetica(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'font':'Arial'})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,"Arial"+self.inputfiles+".gif"),path.join(ROOTDIR,self.outputfiles[0])))

class TestImageCreateMultiSetting(TestImageBase):
    def test_create_1image_red800x200(self):
        red = '#%02x%02x%02x' % (255, 0, 0)
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'extent':'800x200','background':red})
        exp_res = get_gif_filename(TESTDIR,self.inputfiles,args)
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        sleep(1)
        self.assertTrue(bindiff(path.join(TESTDIR,"ff0000"+self.inputfiles+"800x200.gif"),path.join(ROOTDIR,self.outputfiles[0])))

class TestImageCreateMultiFile(TestImageBase):  
    def setUp(self):
        super(TestImageCreateMultiFile,self).setUp()
        self.inputfiles = ['foobar','barfoo']
      
    def test_create_1image_largefont_multi(self):
        red = '#%02x%02x%02x' % (255, 0, 0)
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'extent':'800x200','background':red,'pointsize':48,'font':'Arial','rotate':90})
        exp_res = [get_gif_filename(TESTDIR,lbl,args) for lbl in self.inputfiles]
        self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
        self.assertTrue(bindiff(path.join(TESTDIR,"ff000048Arial"+self.inputfiles[1]+"90800x200.gif"),path.join(ROOTDIR,self.outputfiles[1])))
        self.assertTrue(bindiff(path.join(TESTDIR,"ff000048Arial"+self.inputfiles[0]+"90800x200.gif"),path.join(ROOTDIR,self.outputfiles[0])))
        
class TestImageCreateFails(TestImageBase):
    def test_create_1image_badfontextent(self):
        args=OrderedDict({'convert_exec':path.join(IMDIR,"convert"),'pointsize':'ss'})
        with self.assertRaisesRegexp(Exception,'ImageCreate failure'):
            self.outputfiles = self.ic.create_image_file(self.inputfiles,**args)
            
    
if __name__ == "__main__":
    suite = unittest.TestSuite()
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateVeryBasic))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateBasic))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreatepointsize))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateBackground))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateRotate))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateextent))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateGravity))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateFont))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateMultiSetting))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateMultiFile))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestImageCreateFails))
    unittest.TextTestRunner(verbosity=2).run(suite)
