from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_query, tbl_rows_insert, _quotestrs, \
     tbl_rows_get
import base64
import sys
import unittest
from excel_database_util import DatabaseQueryTable, \
     DatabaseCreateTable, DatabaseInsertRows, DatabaseBase, DatabaseMisc, \
     log, PRIORITY, DatabaseBase
from misc_utils import write_text_to_file, append_text_to_file, os_file_delete, \
     os_file_to_string, get_2darray_from_file, put_2darray_in_file, \
     b64encode, uudecode, os_dir_exists

from os import path
ROOTDIR = path.dirname(path.realpath(__file__))
assert(os_dir_exists(ROOTDIR,"test_misc")) # test files go here
TESTDIR = path.join(ROOTDIR,"test_misc")

class Test_DatabaseQueryTable(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        columns = ['col1','col2','col3']
        column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6]]
        self.qrow = _quotestrs(self.row)
        self.filename = "b64pyshell.txt"
        
        database = Database('foobar')
        
        with database:
            tbl_create(database,self.database_name,column_defn)
            tbl_rows_insert(database,self.table_name,columns,self.qrow)
        
    def test_query(self):
        qry_str = "select col1,col2,col3 from " + self.table_name
        result = DatabaseQueryTable.query(self.database_name,qry_str,delete_flag=True)
        self.assertEquals(result,self.row)
                    
    def test_query_by_file(self):
        self.filename = "unipyshell.txt"
        append_text_to_file(self.filename,"database_name:"+self.database_name + "\n")
        append_text_to_file(self.filename,"qry_str:"+"select col1,col2,col3 from " + self.table_name + "\n") 
        append_text_to_file(self.filename,"delete_flag:True" + "\n") 
        result = DatabaseQueryTable.query_by_file(self.filename)
        self.assertEquals(result,self.row)
        os_file_delete(self.filename)
        
class Test_DatabaseQueryTableEncoded(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        columns = ['col1','col2','col3']
        column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6]]
        self.qrow = _quotestrs(self.row)
        self.filename = "b64pyshell.txt"
        self.b64row = _quotestrs(DatabaseBase._encode_2darray(self.row))
        database = Database('foobar')
        
        with database:
            tbl_create(database,self.database_name,column_defn)
            tbl_rows_insert(database,self.table_name,columns,self.b64row)
    
    def test_query_encoded(self):
        qry_str = b64encode("select col1,col2,col3 from " + self.table_name)
        result = DatabaseQueryTable.query_encoded(self.database_name,qry_str,delete_flag=True)
        self.assertEquals(self.row,DatabaseBase._decode_2darray(result))

    def test_query_by_file_encoded(self):
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"qry_str:"+b64encode("select col1,col2,col3 from " + self.table_name) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n") 
        result = DatabaseQueryTable.query_by_file(self.filename)
        self.assertEquals(self.row,DatabaseBase._decode_2darray(result))
        os_file_delete(self.filename)

class Test_DatabaseInsertRows(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.columns = ['col1','col2','col3']
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6],['a','s',8],['f','a',7]]
        self.qrows = _quotestrs(self.row)
        self.filename = "b64pyshell.txt"
        self.encoding = "unicode"

        DatabaseCreateTable.create(self.database_name,self.table_name,self.column_defn)
        
    def test_insert(self):
        DatabaseInsertRows.insert(self.database_name,self.table_name,
                                  self.columns,self.row)
        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
        self.assertEqual(result,self.row)
        
    def test_insert_encoded(self):
        DatabaseInsertRows.insert(self.database_name,self.table_name,
                                  self.columns,self.row,encoding="base64")
        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)

        self.assertEqual(DatabaseBase._decode_2darray(result),self.row)
        
    def test_insert_by_file(self):
        # no encoding of input / output files
        # no encoding of database content
        self.filename = "unipyshell.txt"
        append_text_to_file(self.filename,"database_name:"+self.database_name + "\n")
        append_text_to_file(self.filename,"table_name:"+self.table_name + "\n")
        append_text_to_file(self.filename,"delete_flag:False" + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([field for field in self.columns]) + "\n")
        
        put_2darray_in_file(self.filename,self.row,suffix="rows:")
        
        DatabaseInsertRows.insert_by_file(self.filename)

        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        self.assertEqual(result,self.row)
        os_file_delete(self.filename)
        
    def test_insert_by_file_encoded(self):
        # encoding of input / output files
        # encoding of database content

        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        #append_text_to_file(self.filename,"decode_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([b64encode(field) for field in self.columns]) + "\n")
        
        put_2darray_in_file(self.filename,self.row,suffix="rows:",encoding="base64")
        
        DatabaseInsertRows.insert_by_file(self.filename)
                
        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        self.assertEqual(DatabaseBase._decode_2darray(result),self.row)        
        os_file_delete(self.filename)
        
class Test_DatabaseQueryTableSetRuntimePath(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.columns = ['col1','col2','col3']
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6]]
        self.qrow = _quotestrs(self.row)
        self.filename = "b64pyshell.txt"
        self.b64row = DatabaseBase._encode_2darray(self.row)
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([b64encode(field) for field in self.columns]) + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name) +"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")
        append_text_to_file(self.filename,"qry_str:"+b64encode("select col1,col2,col3 from " + self.table_name) + "\n") 
    
        put_2darray_in_file(self.filename,self.b64row,suffix="rows:")
        DatabaseCreateTable.create_by_file(self.filename,runtime_path=self.runtime_path)
        DatabaseInsertRows.insert_by_file(self.filename,runtime_path=self.runtime_path)
        
    def test_(self):
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n") 
        result = DatabaseQueryTable.query_by_file(self.filename,runtime_path=self.runtime_path)
        self.assertEqual(DatabaseBase._decode_2darray(result),self.row)     
        
    def tearDown(self):
        os_file_delete(self.filename)
        os_file_delete(self.runtime_path + "\\" + self.database_name + ".sqlite")
        
class Test_DatabaseCreateTable(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.column_defn = [('col1','text'),('col2','text'),
                            ('col3','integer')] 
        self.filename = "unipyshell.txt"
        
    def test_create(self):
        DatabaseCreateTable.create(self.database_name,self.table_name,self.column_defn)
        database =  Database(self.database_name,True)
        with database:
            self.assertTrue(tbl_exists(database,self.table_name))
    
    def test_create_by_file_encoded(self):
        self.filename = "b64pyshell.txt"
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name) +"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")
        DatabaseCreateTable.create_by_file(self.filename)
        
        database =  Database(self.database_name,True)
        with database:
            self.assertTrue(tbl_exists(database,self.table_name))
            
        os_file_delete(self.filename)
        
    def test_create_by_file(self):
        
        append_text_to_file(self.filename,"database_name:"+self.database_name + "\n")
        append_text_to_file(self.filename,"table_name:"+self.table_name + "\n")
        append_text_to_file(self.filename,"delete_flag:False" + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([_name +"^" + _type for _name,_type in self.column_defn]) + "\n")
        DatabaseCreateTable.create_by_file(self.filename)
        
        database =  Database(self.database_name,True)
        with database:
            self.assertTrue(tbl_exists(database,self.table_name))
            
        os_file_delete(self.filename)
        
    def test_create_by_file_encoded_an_set_runtime_path(self):
        self.filename = "b64pyshell.txt"
        runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name) +"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")
        DatabaseCreateTable.create_by_file(self.filename,runtime_path=runtime_path)
        
        database =  Database(runtime_path + "\\" + self.database_name + ".sqlite",True)
        
        with database:
            self.assertTrue(tbl_exists(database,self.table_name))
            
        os_file_delete(self.filename)

class Test_DatabaseInsertRowsSetRuntimePath(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.columns = ['col1','col2','col3']
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6],['a','s',8],['f','a',7]]
        self.qrows = _quotestrs(self.row)
        self.filename = "b64pyshell.txt"
        self.runtime_path = "C:\\Users\\burtnolej"
        DatabaseCreateTable.create(self.database_name,self.table_name,self.column_defn,runtime_path=self.runtime_path)
        
    def test_insert_encoded_by_file(self):
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+b64encode("True") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([b64encode(field) for field in self.columns]) + "\n")
        
        put_2darray_in_file(self.filename,self.row,suffix="rows:",encoding="base64")
        DatabaseInsertRows.insert_by_file(self.filename,runtime_path=self.runtime_path)
        database =  Database(self.runtime_path + "\\" + self.database_name + ".sqlite",True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        self.assertEqual(DatabaseBase._decode_2darray(result),self.row)    
        
    def tearDown(self):
        os_file_delete(self.filename)
       
class Test_DatabaseInsertRowsLarge(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.column_defn = [('FirstName','text'),('LastName','text'),
                            ('Country','text'),('Description','text'),
                            ('Age','integer')] 
        self.columns= ['FirstName','LastName','Country','Description','Age'] 
        
        self.filename = "unipyshell.txt"

        append_text_to_file(self.filename,"database_name:"+self.database_name + "\n")
        append_text_to_file(self.filename,"table_name:"+self.table_name+ "\n")
        append_text_to_file(self.filename,"delete_flag:"+"False" + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([_name+"^" + _type for _name,_type in self.column_defn]) + "\n")

        DatabaseCreateTable.create_by_file(self.filename)

    def test_(self):
        append_text_to_file(self.filename,"columns:"+"$$".join([field for field in self.columns]) + "\n")
        rows = get_2darray_from_file(path.join(TESTDIR,"testdata.csv"),[("'","")])
        put_2darray_in_file(self.filename,rows,suffix="rows:")
    
        DatabaseInsertRows.insert_by_file(self.filename)


        database =  Database(self.database_name,True)
        with database:        
            columns,rows,_ = tbl_query(database,"select Description from foobar where LastName = \"Osborn\"")
        
        expected_results = ["dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et"]
        self.assertListEqual(rows[0],expected_results)
        
    def tearDown(self):
        os_file_delete(self.filename)
        
class Test_DatabaseInsertRowsLargeEncoded(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.column_defn = [('FirstName','text'),('LastName','text'),
                            ('Country','text'),('Description','text'),
                            ('Age','integer')] 
        self.columns= ['FirstName','LastName','Country','Description','Age'] 
        
        self.filename = "b64pyshell.txt"

        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name)+ "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name)+"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")

        DatabaseCreateTable.create_by_file(self.filename)

    def test_(self):
        append_text_to_file(self.filename,"columns:"+"$$".join([b64encode(field) for field in self.columns]) + "\n")
        rows = get_2darray_from_file(path.join(TESTDIR,"testdata.csv"))
        put_2darray_in_file(self.filename,rows,suffix="rows:",encoding="base64")
    
        DatabaseInsertRows.insert_by_file(self.filename)
       
        database =  Database(self.database_name,True)
        with database:        
            columns,rows,_ = tbl_query(database,"select Description from foobar where LastName = \""+b64encode("Osborn")+"\"")
        
        expected_results = [b64encode("dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et")]
        self.assertListEqual(rows[0],expected_results)
        
    def tearDown(self):
        os_file_delete(self.filename)

class Test_DatabaseMisc(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.filename = "b64pyshell.txt"
        self.column_defn = [('FirstName','text'),('LastName','text'),
                                ('Country','text'),('Description','text'),
                                ('Age','integer')] 

        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name) +"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")

        DatabaseCreateTable.create_by_file(self.filename)

    def test_(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n")
        self.assertTrue(DatabaseMisc.table_exists_by_file(self.filename))

    def test_fail(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode("foofoo") + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n")

        self.assertFalse(DatabaseMisc.table_exists_by_file(self.filename))
 
    def test_fail_database(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+b64encode("foofoo") + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n")

        self.assertFalse(DatabaseMisc.database_exists_by_file(self.filename))
        os_file_delete(self.database_name+".sqlite")
        
    def test_get_columns(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n")

        self.assertEquals(DatabaseMisc.get_table_info_by_file(self.filename),
                              [(u'FirstName', u'text'), (u'LastName', u'text'), (u'Country', u'text'), (u'Description', u'text'), (u'Age', u'integer')])

    def test_get_table_list(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n")
        
        self.assertEquals(DatabaseMisc.get_table_list_by_file(self.filename),
                          [u'foobar'])

    def tearDown(self):
        os_file_delete(self.filename)
        
class Test_DatabaseFileParser(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.column_defn = [('FirstName','text'),('LastName','text'),
                            ('Country','text'),('Description','text'),
                            ('Age','integer')] 
        self.columns= ['FirstName','LastName','Country','Description','Age'] 
        
        self.filename = "b64pyshell.txt"

    def test_(self):
        
        rows = get_2darray_from_file(path.join(TESTDIR,"testdata_2rows.csv"))
        
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([b64encode(field) for field in self.columns]) + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name) +"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")
    
        put_2darray_in_file(self.filename,rows,suffix="rows:",encoding="base64")
    
        clsobj = DatabaseBase._parse_input_file(self.filename,mandatory_fields=['database_name',
                                                                                'table_name',
                                                                                'delete_flag',
                                                                                'decode_flag',
                                                                                'columns',
                                                                                'column_defns'],
                                                              encoding="base64")
        
        self.assertEqual(clsobj.database_name,self.database_name)
        self.assertEqual(clsobj.table_name,self.table_name)
        self.assertEqual(clsobj.delete_flag,False)
        self.assertEqual(clsobj.decode_flag,False)
        self.assertEqual(clsobj.runtime_path,".")
        self.assertEqual(clsobj.columns,self.columns)
        self.assertEqual(clsobj.column_defns,self.column_defn)
        self.assertEqual(len(clsobj.rows),2)
        self.assertEqual(len(clsobj.rows[0]),5)

    def test_set_runtimepath(self):
        
        rows = get_2darray_from_file(path.join(TESTDIR,"testdata_2rows.csv"))
        
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+b64encode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+b64encode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+b64encode("True") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([b64encode(field) for field in self.columns]) + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([b64encode(_name) +"^" + b64encode(_type) for _name,_type in self.column_defn]) + "\n")
    
        put_2darray_in_file(self.filename,rows,suffix="rows:",encoding="base64")
    
        clsobj = DatabaseBase._parse_input_file(self.filename,mandatory_fields=['database_name',
                                                                                'table_name',
                                                                                'delete_flag',
                                                                                'decode_flag',
                                                                                'columns',
                                                                                'column_defns'],
                                                              encoding="base64",
                                                              runtime_path="C:\Users\burtnolej")
        self.assertEqual(clsobj.runtime_path,"C:\Users\burtnolej")
    
        self.assertEqual(clsobj.database_name,self.database_name)
        
    def tearDown(self):
        os_file_delete(self.filename)
        pass

class Test_DatabaseQueryTableFileResult(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        columns = ['col1','col2','col3']
        column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6]]
        self.qrow = _quotestrs(self.row)
        self.filename = "b64pyshell.txt"
        self.result_filename = "C:\\Users\\burtnolej\\pyshell_result.txt"
    
        self.b64row = _quotestrs(DatabaseBase._encode_2darray(self.row))
    
        database = Database('foobar')
        
        with database:
            tbl_create(database,self.database_name,column_defn)
            tbl_rows_insert(database,self.table_name,columns,self.b64row)
            
    def test_query_encoded_by_file(self):
        append_text_to_file(self.filename,"database_name:"+b64encode(self.database_name) + "\n")
        append_text_to_file(self.filename,"qry_str:"+b64encode("select col1,col2,col3 from " + self.table_name) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+b64encode("True") + "\n") 
        result = DatabaseQueryTable.query_by_file(self.filename,
                                                  result_file=self.result_filename)
        
        self.assertEqual("eA==^eQ==^Ng==",os_file_to_string(self.result_filename).split("\n")[0])
    
    def tearDown(self):
        #os_file_delete(self.result_filename)
        pass
        

if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRows))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseQueryTable))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseQueryTableEncoded))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseQueryTableSetRuntimePath))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseCreateTable))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRowsSetRuntimePath))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRowsLarge))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRowsLargeEncoded))    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseFileParser))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseMisc))    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseQueryTableFileResult))
    unittest.TextTestRunner(verbosity=2).run(suite)