from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, _quotestrs, tbl_rows_get, tbl_query
from misc_utils import os_file_delete
from TcxAnalyzer import TcxAnalyzer, TcxAnalyzerAddDerivedData
from misc_utils_log import Log,logger,PRIORITY
from collections import OrderedDict
import sys
import unittest

class TestTcxAnalyzer(unittest.TestCase):
    def setUp(self):
        self.databasename='foo'
        self.database = Database(self.databasename)
        self.rawdata = [[1,1,130,240,'fileA'],
                        [2,2,131,241,'fileA'],
                        [3,3,132,242,'fileA'],
                        [4,4,133,240,'fileA'],
                        [5,5,132,261,'fileA'],
                        [6,6,131,262,'fileA'],
                        [7,1,150,310,'fileB'],
                        [8,2,152,307,'fileB'],
                        [9,3,154,309,'fileB'],
                        [10,4,152,306,'fileB'],
                        [11,5,151,310,'fileB'],
                        [12,6,157,311,'fileB']]
    
        self.files = ['fileA','fileB']
        
        self.col_defn=[("id","integer"),
                       ("bucket","integer"),
                       ("hr","integer"),
                       ("watts","integer"),
                       ("filename","string")]
        self.col_names=["id","bucket","hr","watts","filename"]
        self.tablename = "bar"

        _rows = _quotestrs(self.rawdata)
        
        with self.database:
            tbl_create(self.database,self.tablename,self.col_defn)
            tbl_rows_insert(self.database,self.tablename,self.col_names,
                            _rows)
            
    def test_ts_values(self):
        filename = "fileA"
        tcx_analyzer = TcxAnalyzer(self.databasename)
        tcx_analyzer.get_source_data(self.tablename,'id','watts','filename',"\""+filename+"\"")
        self.assertListEqual([240,262,247],tcx_analyzer.get_ts_values())
    
    def test_buckets(self):
        filename = "fileA"
        tcx_analyzer = TcxAnalyzer(self.databasename)
        tcx_analyzer.get_source_data(self.tablename,'id','watts','filename',"\""+filename+"\"")
        self.assertListEqual([(1,'221>260'), (2,'221>260'), (3,'221>260'), (4,'221>260'), (5,'261>300'), (6,'261>300')],
                             tcx_analyzer.get_buckets('watts'))
                             
    def test_persist_new_column(self):
        filename = "fileA"
        tcx_analyzer = TcxAnalyzer(self.databasename)
        tcx_analyzer.get_source_data(self.tablename,'id','watts','filename',"\""+filename+"\"")
        rows = tcx_analyzer.get_buckets('watts')
        tcx_analyzer.add_column_to_table(self.tablename,'watt_bucket','string',rows)
        
        with self.database:
            _,row,_ = tbl_query(self.database,"select watt_bucket from "+self.tablename+" where filename=\""+filename+"\"")
   
        self.assertListEqual(row,  [[u'221>260'], [u'221>260'], [u'221>260'], [u'221>260'], [u'261>300'], [u'261>300']])

    def test_persist_new_table(self):
        filename = "fileA"
        tcx_analyzer = TcxAnalyzer(self.databasename)
        tcx_analyzer.get_source_data(self.tablename,'id','watts','filename',"\""+filename+"\"")
        row = tcx_analyzer.get_ts_values()
        tcx_analyzer.persist_ts_values(filename,'watts',row)
        
    def test_all(self):
        
        types = ['watts','hr']
        files = ['fileA','fileB']
        tcx_analyzer = TcxAnalyzer(self.databasename)
        for _type in types:
            for _file in files:
                tcx_analyzer.get_source_data(self.tablename,'id',_type,'filename',"\""+_file+"\"")
                row = tcx_analyzer.get_ts_values()
                tcx_analyzer.persist_ts_values(_file,_type,row)
                
        with self.database:
            _,watts_rows,_ = tbl_query(self.database,"select * from watts_values")
            _,hr_rows,_ = tbl_query(self.database,"select * from hr_values")
            
        self.assertListEqual(watts_rows,[[u'fileA', 240, 262, 247], [u'fileB', 306, 311, 308]])
        self.assertListEqual(hr_rows,[[u'fileA', 130, 133, 131], [u'fileB', 150, 157, 152]])      
    
    def tearDown(self):
        os_file_delete(self.databasename+".sqlite")

class Test_TcxAnalyzerAddDerivedData(unittest.TestCase):
    def setUp(self):
        self.databasename='foo'
        self.database = Database(self.databasename)
        self.rawdata = [[1,240,'fileA'],
                        [2,241,'fileA'],
                        [3,242,'fileB'],
                        [4,240,'fileB']]
    
        self.files = ['fileA','fileB']
        
        self.col_defn=[("id","integer"),
                       ("watts","integer"),
                       ("filename","string")]
        self.col_names=["id","watts","filename"]
        self.tablename = "bar"

        _rows = _quotestrs(self.rawdata)
        
        with self.database:
            tbl_create(self.database,self.tablename,self.col_defn)
            tbl_rows_insert(self.database,self.tablename,self.col_names,
                            _rows)  
            
    def test_(self):
        
        class MyTcxDerived(TcxAnalyzerAddDerivedData):
            def create_values(self,**kwargs):
                ''' to be overwritten; this is just a stub that creates copy of original data'''
                bucket_ts=[]
                for i in range(0,len(self.sourcedata)):
                    _data = self.sourcedata[i]*kwargs['multiplier']
                    bucket_ts.append((self.sourceid[i],_data))
                return bucket_ts 
        tcx_add_col = MyTcxDerived(self.databasename)
        tcx_add_col.add('bar','id','watts','filename',"\"fileA\"",
                        'bar','watts_multiplier','integer',multiplier=5)
        
        with self.database:
            _,rows,_ = tbl_query(self.database,"select id,watts,filename,watts_multiplier from bar")
            
        expected_result = [[1,240,'fileA',1200],
                           [2,241,'fileA',1205],
                           [3,242,'fileB',None],
                           [4,240,'fileB',None]]
        
        self.assertListEqual(rows,expected_result)
        
    def tearDown(self):
        os_file_delete(self.databasename+".sqlite")
    
class Test_TcxAnalyzerAddDerivedData_PassValues(unittest.TestCase):
    def setUp(self):
        self.databasename='foo'
        self.database = Database(self.databasename)
        self.rawdata = [[1,240,'fileA'],
                        [2,241,'fileA'],
                        [3,242,'fileB'],
                        [4,240,'fileB']]
    
        self.files = ['fileA','fileB']
        
        self.col_defn=[("id","integer"),
                       ("watts","integer"),
                       ("filename","string")]
        self.col_names=["id","watts","filename"]
        self.tablename = "bar"

        _rows = _quotestrs(self.rawdata)
        
        with self.database:
            tbl_create(self.database,self.tablename,self.col_defn)
            tbl_rows_insert(self.database,self.tablename,self.col_names,
                            _rows)  
            
    def test_(self):
        
        class MyTcxDerived(TcxAnalyzerAddDerivedData):
            def create_values(self,**kwargs):
                ''' to be overwritten; this is just a stub that creates copy of original data'''
                bucket_ts=[]
                for i in range(0,len(self.sourcedata)):
                    _data = self.sourcedata[i]*kwargs['multiplier']
                    bucket_ts.append((self.sourceid[i],_data))
                return bucket_ts
 
        tcx_add_col = MyTcxDerived(self.databasename)
        tcx_add_col.add('bar','id','watts','filename',"\"fileA\"",
                        'bar','foobar','integer',
                        rows=[[3,'\"foo\"'],[4,'\"bar\"']])
        
        with self.database:
            _,rows,_ = tbl_query(self.database,"select id,foobar from bar")
            
        expected_result = [[1,None],
                           [2,None],
                           [3,'foo'],
                           [4,'bar']]
        
        self.assertListEqual(rows,expected_result)
        
    def tearDown(self):
        os_file_delete(self.databasename+".sqlite")
        
if __name__ == "__main__":
    
    suite = unittest.TestSuite()
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestTcxAnalyzer))   
    #suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_TcxAnalyzerAddDerivedData))   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_TcxAnalyzerAddDerivedData_PassValues))   
    
    unittest.TextTestRunner(verbosity=2).run(suite)