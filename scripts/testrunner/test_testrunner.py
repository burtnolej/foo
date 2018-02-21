import unittest
from testrunner import testsuite_get, testsuite_run,testsuite_results
class Test_testrunner(unittest.TestCase):
    def test_testsuite_get(self):
        expected_results = {'test_test1.py': ['Test_Test', 'Test_Test2'], 'test_test2.py': ['Test_Test21', 'Test_Test22'] }
        suite, testsummary = testsuite_get('./dir')
        
        self.assertEqual(testsummary,expected_results)
        
    def test_testsuite_run(self):
        # allow dupe has to be set as the prev test may not have released the module
        expected_results = {'test_test1.py': ['Test_Test', 'Test_Test2'], 'test_test2.py': ['Test_Test21', 'Test_Test22']}
        suite, testsummary = testsuite_get('./dir',allowdupe=True)
        testsuite_run(suite)
        
        self.assertEqual(testsummary,expected_results)
        
    def test_testsuite_results(self):
        # allow dupe has to be set as the prev test may not have released the module
        
        expected_results = {'test_test1.py': ['Test_Test', 'Test_Test2'], 'test_test2.py': ['Test_Test21', 'Test_Test22']}
        suite, testsummary = testsuite_get('./dir',allowdupe=True)
        testresult = testsuite_run(suite)
        
        testsuite_results(testresult)
        
        self.assertEqual(testsummary,expected_results)
        
    def test_testsuite_results_failures(self):
        
        expected_results = {'test_test1.py': ['Test_Test', 'Test_Test2'], 'test_test2.py': ['Test_Test21', 'Test_Test22']}
        suite, testsummary = testsuite_get('./dir_fail')
        testresult = testsuite_results(testsuite_run(suite))
        self.assertEquals(testresult['#failures'],2)
        
    def test_testsuite_results_error(self):
        expected_results = {'test_test1.py': ['Test_Test', 'Test_Test2'], 'test_test2.py': ['Test_Test21', 'Test_Test22']}
        suite, testsummary = testsuite_get('./dir_error',allowdupe=True)
        testresult = testsuite_results(testsuite_run(suite))
        self.assertEquals(testresult['#errors'],2)
    
class Test_testrunner2(unittest.TestCase):
    def test_ignore(self):
        expected_results = {'test_test1.py': ['Test_Test', 'Test_Test2'], 'test_test2.py': ['Test_Test21', 'Test_Test22']}
        suite, testsummary = testsuite_get('./dir_error',allowdupe=True,ignoredir=['./dir_error/subdir'])
        testresult = testsuite_results(testsuite_run(suite))
        self.assertEquals(testresult['#errors'],1)
        
        
class Test_Only1File(unittest.TestCase):
    def test_load(self):
        
        expected_results = {'test_test3.py': ['Test_Test31', 'Test_Test32', 'Test_Test33']}
        
        suite, testsummary = testsuite_get('./dir_deep',allowdupe=True,
                                           specific_files=['subdir/subdir/test_test3.py'])
        
        self.assertEquals(testsummary,expected_results)
        
    def test_run(self):
        suite, testsummary = testsuite_get('./dir_deep',allowdupe=True,
                                            specific_files=['subdir/subdir/test_test3.py'])
        
    
        testresult = testsuite_results(testsuite_run(suite))
        self.assertEquals(testresult['#errors'],0)
        self.assertEquals(testresult['#tests'],6)
        
class Test_Only1Test(unittest.TestCase):
    def test_load(self):
        
        expected_results = {'test_test3.py': ['Test_Test33']}
        
        suite, testsummary = testsuite_get('./dir_deep',allowdupe=True,
                                           specific_files=['subdir/subdir/test_test3.py'],
                                           specific_tests=['Test_Test33'])
        
        self.assertEquals(testsummary,expected_results)
        
    def test_load_bad_test_name(self):
        
        expected_results = {'test_test3.py': ['Test_Test33']}
        
        
        with self.assertRaises(Exception):
            suite, testsummary = testsuite_get('./dir_deep',allowdupe=True,
                                           specific_files=['subdir/subdir/test_test3.py'],
                                           specific_tests=['foobar'])
        
        #self.assertEquals(testsummary,expected_results)
        
    def test_run(self):
        suite, testsummary = testsuite_get('./dir_deep',allowdupe=True,
                                           specific_files=['subdir/subdir/test_test3.py'],
                                           specific_tests=['Test_Test33'])
        
        testresult = testsuite_results(testsuite_run(suite))
        self.assertEquals(testresult['#errors'],0)
        self.assertEquals(testresult['#tests'],2)
        
        
if __name__ == "__main__":
    suite = unittest.TestSuite()
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_testrunner))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_testrunner2))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Only1File))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_Only1Test))
    unittest.TextTestRunner(verbosity=2).run(suite) 