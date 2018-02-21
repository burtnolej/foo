from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, tbl_rows_get, tbl_query
from DownloadTrainerRoadTcx import DB_COLUMN_DEFN,DB_COLUMN_NAMES,DownloadTrainerRoadTcx, TR_HOME_PAGE, TR_RIDES_URL, DOWNLOAD_DIR
from tcxParser import TcxMoveFiles
from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, _quotestrs
import unittest
from tcxParser import TcxParser, log, LOGDIR, ns
from misc_utils import os_file_delete, os_file_touch, os_dir_delete
from misc_utils_log import Log, logger
from collections import OrderedDict
from test_misc_utils import Test_MoveFiles
from os import path as ospath
import os

TEST_FILES=os.environ["PYTHONAPPS"] + "\\apps\\traineroad\\test_files"

class TestTcxBase(unittest.TestCase):
    def setUp(self):
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
        log.echoflag = True
        
class TestTcxParserBasic(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"

        self.watts_points = [269, 274, 251, 275, 275, 275, 275, 283, 283]
        self.hr_points = [91, 91, 91, 92, 92, 93, 93, 94, 96]
        
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
        
    def test_filename(self):
        
        tcxparser = TcxParser(TEST_FILES,verbosity=20)

        tcxparser.process_files()
        
        self.assertTrue(tcxparser.files.has_key(self.test_file_name))
        
    def test_datapoints(self):
        tcxparser = TcxParser(TEST_FILES,verbosity=20)
        tcxparser.process_files()
        _file = tcxparser.files[self.test_file_name]

        self.assertListEqual(_file['watts'],self.watts_points)
        self.assertListEqual(_file['hr'],self.hr_points)
    
class TestTcxParserBadFile(unittest.TestCase):
    def setUp(self):
        pass

    def test_filename(self):
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('msg',-1)])
        tcxparser = TcxParser(TEST_FILES,verbosity=10)

        self.assertEquals(tcxparser.parse_tcx("foobar.tcx",ns),-1)
        
class TestTcxParserLimitsPassed(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"

        self.watts_points = [251, 275, 275, 275]
        self.hr_points = [91, 92, 92, 93]
        self.limits = {'test_9trackpoints':{'start':2,'end':6}}
    
    def test_(self):
        tcxparser = TcxParser(TEST_FILES)
        tcxparser.process_files(limits=self.limits)
        _file = tcxparser.files[self.test_file_name]
        self.assertListEqual(_file['watts'],self.watts_points)
        self.assertListEqual(_file['hr'],self.hr_points)
        
class TestTcxParserLimitsFromDB(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"

        self.wattsavg_points =  [[263], [275]]
        
        self.limits = {'test_9trackpoints':{'start':2,'end':6}}
        
        self.cdefns = DB_COLUMN_DEFN
        self.cnames = DB_COLUMN_NAMES
        self.dtr_tcx = DownloadTrainerRoadTcx()
        self.dname = "foo"
        self.tname = "bar"
        
        start = "00:02"
        end = "00:06"
        new_file_name = "test_9trackpoints"
        ride_title = "foo_title"
        workout_type = "z2"
    
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
        
        row = _quotestrs([[start,end,new_file_name,ride_title,workout_type],
                          ["15:00","25:00","test_all_trackpoints","foo2_title","z2"]])
        self.dtr_tcx._write_to_db(row,self.dname, self.tname,self.cdefns,self.cnames)

    def test_from_db(self):
                  
        tcxparser = TcxParser(TEST_FILES,databasename="foo",tablename="foo2")
        limits = tcxparser.get_limits_from_db('bar')
        
        expected_results =  {u'test_9trackpoints': {'start': 2, 'end': 6}, u'test_all_trackpoints': {'start': 900, 'end': 1500}}
        self.assertEqual(limits,expected_results)
        
        tcxparser.process_files(summation_type="avg",limits=limits,bucket_size=2)
        tcxparser.persist()
        
        database = Database('foo',True)
        
        with database:
            _,rows,_ = tbl_query(database,'select watts from foo2 where filename=\"test_9trackpoints\"')        
            
            self.assertListEqual(rows,self.wattsavg_points)
            
    def test_from_db_bad_db(self):

        tcxparser = TcxParser(TEST_FILES,databasename="xxx",tablename="foo2")
        
        with self.assertRaises(Exception):
            limits = tcxparser.get_limits_from_db('bar')

        os_file_delete(self.dname+".sqlite")    
            
            
class TestTcxParserLimitsFromDB_Hours(unittest.TestCase):
    ''' test a limit that has an hours component; 01:30:00, rather than just 30:00'''
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"

        self.wattsavg_points =  [[263], [275]]
        
        self.limits = {'test_9trackpoints':{'start':2,'end':6}}
        
        self.cdefns = DB_COLUMN_DEFN
        self.cnames = DB_COLUMN_NAMES
        self.dtr_tcx = DownloadTrainerRoadTcx()
        self.dname = "foo"
        self.tname = "bar"
        
        start = "00:02"
        end = "01:00:06"
        new_file_name = "test_9trackpoints"
        ride_title = "foo_title"
        workout_type = "z2"
        
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
    
        row = _quotestrs([[start,end,new_file_name,ride_title,workout_type],
                          ["15:00","25:00","test_all_trackpoints","foo2_title","z2"]])
        self.dtr_tcx._write_to_db(row,self.dname, self.tname,self.cdefns,self.cnames)
        
    def test_from_db(self):

        expected_results =  {u'test_9trackpoints': {'start': 2, 'end': 3606}, u'test_all_trackpoints': {'start': 900, 'end': 1500}}
        
        tcxparser = TcxParser(TEST_FILES,databasename="foo",tablename="foo2")
        limits = tcxparser.get_limits_from_db('bar')
        
        self.assertEqual(limits,expected_results)

    def tearDown(self):
        os_file_delete(self.dname+".sqlite")
        
        
        
class TestTcxParserAverages(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"
        self.mavg_hr_10 = [92]
        self.mavg_watts_10 = [273]

        self.mavg_watts_2 = [271, 262, 263, 275, 275, 275, 279, 283]
        self.mavg_hr_2 = [91, 91, 91, 92, 92, 93, 93, 95]
        
        self.avg_watts_3 = [264, 275, 280]
        self.avg_hr_3 = [91, 92, 94]   
        
    def test_mavgs_default(self):
        tcxparser = TcxParser(TEST_FILES)
        tcxparser.process_files()
        
        _file = tcxparser.files[self.test_file_name]
        
        self.assertEquals(_file['wattsmavg'],self.mavg_watts_10)
        self.assertEquals(_file['hrmavg'],self.mavg_hr_10)
        
    def test_mavgs_size_2(self):
        tcxparser = TcxParser(TEST_FILES)
        tcxparser.process_files(bucket_size=2)
        
        _file = tcxparser.files[self.test_file_name]
        
        self.assertEquals(_file['wattsmavg'],self.mavg_watts_2)
        self.assertEquals(_file['hrmavg'],self.mavg_hr_2)
        
    def test_avgs_default(self):
        tcxparser = TcxParser(TEST_FILES)
        tcxparser.process_files(summation_type="avg", 
                                bucket_size=3)
        
        _file = tcxparser.files[self.test_file_name]
        
        self.assertEquals(_file['wattsavg'],self.avg_watts_3)
        self.assertEquals(_file['hravg'],self.avg_hr_3)
        
    def tearDown(self):
        pass

class TestTcxParserFullFile(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_all_trackpoints.tcx"

        self.watts_points = [269, 274, 251, 275, 275, 275, 275, 283, 283]
        self.hr_points = [91, 91, 91, 92, 92, 93, 93, 94, 96]
        
        self.watts_avg_200 = [273,282,292,288,290,304,314,311,319,320,322,303,307,302,297,286,285,273,140]
        
    def test_(self):
        
        tcxparser = TcxParser(TEST_FILES)
        tcxparser.process_files(summation_type="avg",bucket_size=200)
    
        _file = tcxparser.files[self.test_file_name]
    
        self.assertEquals(_file['wattsavg'],self.watts_avg_200)
        
class TestTcxParserDump(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"
        self.test_file_name2 = "test_all_trackpoints.tcx"
        self.expected_results = [[0, 264, 91, u'test_9trackpoints'], 
                                 [1, 275, 92, u'test_9trackpoints'], 
                                 [2, 280, 94, u'test_9trackpoints']]
        
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
        
        self.tcxparser = TcxParser(TEST_FILES,databasename="foo",tablename="foo")
        self.tcxparser.process_files(summation_type="avg",bucket_size=3)
        
    def test_(self):
        expected_results = [['0','0', '264', '91', '"test_9trackpoints"'], ['1','1', '275', '92', '"test_9trackpoints"'], ['2','2', '280', '94', '"test_9trackpoints"']]
        self.assertListEqual(self.tcxparser.dump(self.test_file_name,"avg"), expected_results)
                
    def test_bad_file(self):
        self.assertListEqual([],self.tcxparser.dump("foobar.tcx","avg"))

    def test_bad_timeseries_type(self):
        self.assertListEqual([],self.tcxparser.dump("test_9trackpoints.tcx","foo"))
     
class TestTcxParserDumpMultiFiles(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"
        self.test_file_name2 = "test_all_trackpoints.tcx"
        self.expected_results = [[0, 264, 91, u'test_9trackpoints'], 
                                 [1, 275, 92, u'test_9trackpoints'], 
                                 [2, 280, 94, u'test_9trackpoints'],
                                 [0, 264, 91, u'test_all_trackpoints'], 
                                 [1, 275, 92, u'test_all_trackpoints'], 
                                 [2, 280, 94, u'test_all_trackpoints']                                 ]
        
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
        
        self.tcxparser = TcxParser(TEST_FILES,databasename="foo",tablename="foo")
        self.tcxparser.process_files(summation_type="avg",bucket_size=3)
        
    def test_(self):
        
        _dump = self.tcxparser.dump(summation_type="avg")
        self.assertEqual(_dump[3][0],'3')
        
class TestTcxParserPersist(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"
        self.test_file_name2 = "test_all_trackpoints.tcx"
        self.expected_results = [[0,0, 264, 91, u'test_9trackpoints'], 
                                 [1,1, 275, 92, u'test_9trackpoints'], 
                                 [2,2, 280, 94, u'test_9trackpoints']]
    
        self.tcxparser = TcxParser(TEST_FILES,databasename="foo",tablename="foo")
        self.tcxparser.process_files(summation_type="avg",bucket_size=3)
        
    def test_1file_no_limits(self):

        self.tcxparser.persist(self.test_file_name)
        
        database = Database('foo',True)
        
        with database:
            _,rows,_ = tbl_rows_get(database,'foo')        
        
        self.assertListEqual(self.expected_results,rows)
        
    def test_1file_no_limits_fail_to_write_to_db(self):

        self.tcxparser.persist(self.test_file_name,
                               column_names =["id","foobar","watts","hr","filename"])
        
        database = Database('foo',True)
        
        with database:
            _,rows,_ = tbl_rows_get(database,'foo')        
        
        self.assertListEqual([],rows)
        
    def test_2files(self):
        self.tcxparser.persist(self.test_file_name)
        self.tcxparser.persist(self.test_file_name2)
        
        database = Database('foo',True)
        
        with database:
            _,rows,_ = tbl_query(database,'select count(*) from foo where filename=\"'+os.path.splitext(self.test_file_name2)[0]+'\"')        
        
        self.assertEqual(1238,rows[0][0])

class TestTcxParserPersistWithLimits(unittest.TestCase):
    def setUp(self):
        self.test_file_name = "test_9trackpoints.tcx"
        self.test_file_name2 = "test_all_trackpoints.tcx"
    
        row = _quotestrs([["00:02","00:06","test_9trackpoints","foo_title","z2"],
                              ["15:00","25:00","test_all_trackpoints","foo2_title","z2"]])
        self.dtr_tcx = DownloadTrainerRoadTcx()
        self.dtr_tcx._write_to_db(row,'foo', 'bar',DB_COLUMN_DEFN,DB_COLUMN_NAMES)
        
        self.tcxparser = TcxParser(TEST_FILES,databasename="foo",tablename="foo")
        limits = self.tcxparser.get_limits_from_db('bar')
        self.tcxparser.process_files(summation_type="avg",bucket_size=3,limits=limits)
        
    def test(self):
    
        self.tcxparser.persist(self.test_file_name2)
        
        database = Database('foo',True)
        
        with database:
            _,rows,_ = tbl_query(database,'select count(*) from foo where filename=\"'+os.path.splitext(self.test_file_name2)[0]+'\"')        
        
        self.assertEqual(200,rows[0][0])
        
class TestTcxParser_MoveFiles(Test_MoveFiles):
    def test_(self):
        test_file_input_dir = "C:\\Users\\burtnolej\\Documents\\target" # target dir for move files
        test_file_source_dir = "C:\\Users\\burtnolej\\Documents\\source"
        tcxparser = TcxParser(test_file_input_dir,databasename="foo",tablename="foo")
        
        self.file1 = os_file_touch(test_file_source_dir,"burtnolejusa-2017-12-25-some-workout-metadata-666666.tcx")
        self.file2 = os_file_touch(test_file_source_dir,"burtnolejusa-2017-12-25-some-workout-metadata-777777.tcx")
        
        TcxMoveFiles(test_file_source_dir,test_file_input_dir,moveflag=True).move_files()

        # ['20172512_666666.tcx', '20172512_777777.tcx']
        #print os.listdir(test_file_input_dir)
        
        self.assertListEqual(os.listdir(test_file_input_dir),
            ['20171225_666666.tcx', '20171225_777777.tcx'])
        
        self.assertListEqual(os.listdir(test_file_source_dir),[])
        
    def tearDown(self):
        os_file_delete(ospath.join(self.targetdir,"20171225_666666.tcx"))
        os_file_delete(ospath.join(self.targetdir,"20171225_777777.tcx"))
        
        os_dir_delete(self.root,'source')
        os_dir_delete(self.root,'target')
    
if __name__ == "__main__":
    
    log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
    
    suite = unittest.TestSuite()
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserBasic))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserBadFile))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserAverages))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserFullFile))    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserPersist))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserPersistWithLimits))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserLimitsPassed))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserLimitsFromDB))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserLimitsFromDB_Hours))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserDump))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParser_MoveFiles))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxParserDumpMultiFiles))
    
    
    unittest.TextTestRunner(verbosity=2).run(suite)