import sys
from misc_utils_log import Log, logger, Singleton, PRIORITY
from misc_utils import thisfuncname, os_file_to_list, os_file_delete
from time import sleep
from collections import OrderedDict
import unittest
import os
import module_utils

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"
    

class Test_Log_Base(unittest.TestCase):
    def setUp(self):
        self.log = Log()
        self.log.verbosity=10
        self.log.cacheflag=True
        self.log.logdir=LOGDIR,
        self.log.pidlogname=False
        self.log.proclogname=False
        self.log.pad=False
    
    def tearDown(self):
        logfullpath = self.log.logfullpath
        self.log.close()
        self.log.reset()
        self.log.cache=[]
        os_file_delete(logfullpath)
        
class Test_Logger_Member_Function(Test_Log_Base):
    def setUp(self):
        super(Test_Logger_Member_Function,self).setUp()
        self.log.verbosity = 20
        
        @logger(self.log)
        def func_1sec(*args,**kwargs):
            sleep(1)
            return(100)
        
        @logger(self.log)
        def func1(*args,**kwargs):
            return(100)
        
        self.func1 = func1
        self.func_1sec = func_1sec
        
    def test_args(self):
        self.func1("xyz",123,list())
        expected_results = "xyz,123,[]"
        self.assertEqual(self.log.cache[0][7] ,expected_results)
        
    def test_args_kwargs(self):
        self.func1("xyz",123,list(),abc="xyz")
        expected_results = "[('abc','xyz')]"
        self.assertEqual(self.log.cache[0][8] ,expected_results)

    def test_userclassobj_args(self):
        class myclass(object):
            pass
        
        self.func1(myclass())
        expected_results = "myclass"
        self.assertEqual(self.log.cache[0][7] ,expected_results)
        
class Test_Log(Test_Log_Base):
    def test_debug(self):        
        self.log.log(PRIORITY.SUCCESS,msg="foofoobarbar")
        self.assertEquals(self.log.cache[0][2],'SUCCESS')
        self.assertEquals(self.log.cache[0][3],'test_misc_utils_log.py')
        self.assertEquals(self.log.cache[0][4],'test_debug')
        self.assertEquals(self.log.cache[0][9],"[('msg', 'foofoobarbar')]")
        
    def test_extra_msg(self): 
        self.log.log(PRIORITY.SUCCESS,foobar='barfoo')
        expected_results = "[('foobar', 'barfoo')]"
        self.assertEquals(self.log.cache[0][9],expected_results)
           
class Test_Calling_Class(Test_Log_Base):
    def setUp(self):
        super(Test_Calling_Class,self).setUp()
        self.log.pidlogname=True
        self.log.proclogname=True
        self.log.pad = True
        self.log.config = OrderedDict([('now',12),('class',20),('funcname',20),('msg',30),('args',30)])

    def test_(self):
        expected_results = ['Test_Calling_Class  ','myfunc              ','this is a test                ','{\'arg1\': \'foo\', \'arg2\': \'bar\'}']
        def myfunc(arg1,arg2):
            self.log.log(PRIORITY.SUCCESS,msg="this is a test")            
        myfunc('foo','bar')
        self.assertListEqual(expected_results,self.log.cache[0][1:])
        
class Test_Misc(Test_Log_Base):
    def test_func_arg(self):
        from database_table_util import tbl_col_add
        self.log.log(PRIORITY.SUCCESS,func=tbl_col_add,current_value="aaa",new_value="bbb")
        
        expected_results = "[('current_value', 'aaa'), ('new_value', 'bbb'), ('func', 'tbl_col_add')]"
        self.assertEquals(self.log.cache[0][9],expected_results)
           
class Test_Log_Multiple_Entries(Test_Log_Base):
    def setUp(self):
        super(Test_Log_Multiple_Entries,self).setUp()
        self.log.verbosity=20
        
        @logger(self.log)
        def func1(*args,**kwargs):
            return(100)
        self.func1  = func1
    
    def test_1000msg(self):
        for i in range(20):
            self.log.log(PRIORITY.SUCCESS,)
        self.assertEqual(len(self.log.cache),20)
        
    def test_1000msg_logger(self):
        pid = os.getpid()
        for i in range(20):
            self.func1()
        self.assertEqual(self.log.stats[str(pid)]['func1']['no'],20)
        
class Test_Log_Names(Test_Log_Base):
    def setUp(self):        
        self.log = Log()
        self.log.pidlogname=True
        self.log.proclogname=True  
        self.log.startlog()
        #super(Test_Log_Names,self).setUp()
  
        
        @logger(self.log)
        def func1(*args,**kwargs):
            return(100)
        
        self.func1  = func1
        
    def test_(self):
        
        logname = os.path.basename(self.log.logname).split(".")
        self.assertEquals(logname[3],'test_misc_utils_log')
        
if __name__ == "__main__":

    suite = unittest.TestSuite()
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Logger_Member_Function))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Log))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Calling_Class))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Log_Multiple_Entries))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Misc))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Log_Names))
    
    unittest.TextTestRunner(verbosity=2).run(suite)
