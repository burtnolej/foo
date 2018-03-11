from subprocess import Popen, STDOUT, PIPE
from time import sleep
import sys
from misc_utils_process import process_instances_get, process_kill, \
     process_start,process_get_stdout

from misc_utils import Enum
from image_utils import parse_convert_stdout
from os import remove, path
import unittest


IMDIR = "C:\Program Files (x86)\ImageMagick-6.7.5-Q8\\"

class TestSubProcess_ls(unittest.TestCase):
    # most basic exercising of process_start; 
    def setUp(self):
        pass

    def test_(self):
        cmd = ["dir",__file__] 
        p = process_start(cmd)
        self.assertEqual(path.basename(process_get_stdout(p).rstrip()),
                         path.basename(__file__))
    
class TestSubProcess(unittest.TestCase):
            
    def setUp(self):
        self.label = 'foobar'
        
    def test_success(self):

        # some external command to test with whose outputs are known
        cmd = [IMDIR+'convert','-verbose','label:'+self.label,'-pointsize','22','foobar.gif']
        p = process_start(cmd)
        status = parse_convert_stdout(p,self.label)
        
        self.assertEquals(status[0],0)
        self.assertTrue(status[1],'37x13')
        self.assertTrue(status[2],'foobar.txt')
        
    def test_failure(self):
        # known external command --verbose is a bad switch
        cmd = [IMDIR+'convert','--verbose','label:'+self.label,'-pointsize','22','foobar.gif']
        
        p = process_start(cmd)
        status = parse_convert_stdout(p,self.label)
        self.assertTrue(status[0],1)
        
    def test_failure_grabstderr(self):
        # known external command --verbose is a bad switch
        cmd = [IMDIR+'convert','--verbose','label:'+self.label,'-pointsize','22','foobar.gif']
        
        p = process_start(cmd)
        stderr = parse_convert_stdout(p,self.label)[1]
        
        if sys.platform == "win32":
            self.assertTrue(stderr.startswith('convert.exe: no decode delegate for this image format'))
        else:     
            self.assertTrue(stderr.startswith('convert: unrecognized option'))
        
    def test_killprocess(self):
        
        import os
        import signal
        
        # some process that runs until killed
        if sys.platform == "win32":
            cmd = ['cmd','/k','imdisplay','foobar.gif']
        
            process_start(cmd)
            
            pids=process_instances_get('imdisplay.exe')
            self.assertEquals(len(pids),1)
            
            for _pid in pids:
                process_kill(_pid)
                
            pids=process_instances_get('imdisplay.exe')
            self.assertEquals(len(pids),0)
        else:
            cmd = ['display','foobar.gif']
            process_start(cmd)
            
            pids=process_instances_get('display')
            self.assertEquals(len(pids),1)
            
            process_kill(pids[0][0])
            pids=process_instances_get('display')
            self.assertEquals(len(pids),0)
            
        
    def test_killprocess_popen(self):
        # passing in a Popen object not a pid
        import os
        import signal
        
        # some process that runs until killed
        if sys.platform == "win32":
            cmd = ['cmd','/k','imdisplay','foobar.gif']
                    
            p = process_start(cmd)
            pids=process_instances_get('imdisplay.exe')
            self.assertEquals(len(pids),1)
        
            process_kill(p)
            sleep(1)
            pids=process_instances_get('imdisplay.exe')
            self.assertEquals(len(pids),0)
        
class TestProcessUp(unittest.TestCase):
    
    def setUp(self):
        self.findpids=[]
        
        # some process that runs until killed
        cmd = ['cmd','/k','imdisplay','foobar.gif']

        for i in range(5):
            self.findpids.append(process_start(cmd))

    def test_processup(self):
        
        pids=process_instances_get('imdisplay.exe')
        self.assertEquals(len(pids),5)
        
    def tearDown(self):
        
        for p in self.findpids:
            process_kill(p)


if __name__ == "__main__":

    suite = unittest.TestSuite()
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestSubProcess_ls))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestSubProcess))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestProcessUp))

    unittest.TextTestRunner(verbosity=2).run(suite)
