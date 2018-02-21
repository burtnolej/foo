from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_query, tbl_rows_insert, _quotestrs, \
     tbl_rows_get
import base64
import sys
import unittest
from excel_database_util import DatabaseQueryTable, \
     DatabaseCreateTable, DatabaseInsertRows, DatabaseBase, DatabaseMisc, \
     log, PRIORITY
from misc_utils import write_text_to_file, append_text_to_file, os_file_delete, \
     os_file_to_string, get_2darray_from_file, put_2darray_in_file, \
     uuencode, uudecode


class Test_DatabaseQueryTable(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        columns = ['col1','col2','col3']
        column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6]]
        self.qrow = _quotestrs(self.row)
        self.filename = "pyshell.txt"
        
        database = Database('foobar')
        
        with database:
            tbl_create(database,self.database_name,column_defn)
            tbl_rows_insert(database,self.table_name,columns,self.qrow)
        
    def test_query(self):
        qry_str = "select col1,col2,col3 from " + self.table_name
        result = DatabaseQueryTable.query(self.database_name,qry_str,delete_flag=True)
        self.assertEquals(result,self.row)
        
    def test_query_bad_table_name(self):
        qry_str = "select col1,col2,col3 from " + "foofoo"
        result = DatabaseQueryTable.query(self.database_name,qry_str,delete_flag=True)
        self.assertEqual(result,[-1])
                
    def test_query_encoded(self):
        qry_str = uuencode("select col1,col2,col3 from " + self.table_name)
        result = DatabaseQueryTable.query_encoded(self.database_name,qry_str,delete_flag=True)
        self.assertEquals(result,self.row)
        
    def test_query_encoded_by_file(self):
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"qry_str:"+uuencode("select col1,col2,col3 from " + self.table_name) + "\n") 
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n") 
        result = DatabaseQueryTable.query_encoded_by_file(self.filename)
        self.assertEquals(result,self.row)
        os_file_delete(self.filename)
        
class Test_DatabaseQueryTableSetRuntimePath(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.columns = ['col1','col2','col3']
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6]]
        self.qrow = _quotestrs(self.row)
        self.filename = "pyshell.txt"
        
        self.runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+uuencode("True") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")
        append_text_to_file(self.filename,"qry_str:"+uuencode("select col1,col2,col3 from " + self.table_name) + "\n") 
    
        put_2darray_in_file(self.filename,self.row,suffix="rows:")
        
        DatabaseCreateTable.create_encoded_by_file(self.filename,
                                                   runtime_path=self.runtime_path)

        DatabaseInsertRows.insert_encoded_by_file(self.filename,
                                                  runtime_path=self.runtime_path)
        
    def test_(self):
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n") 
        
        result = DatabaseQueryTable.query_encoded_by_file(self.filename,
                                                          runtime_path=self.runtime_path)
        self.assertEquals(result,self.row)
        
    
    def tearDown(self):
        os_file_delete(self.filename)
        os_file_delete(self.runtime_path + "\\" + self.database_name + ".sqlite")
        
        
class Test_DatabaseCreateTable(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.column_defn = [('col1','text'),('col2','text'),
                            ('col3','integer')] 
        self.filename = "pyshell.txt"
        
    def test_create(self):
        DatabaseCreateTable.create(self.database_name,
                                   self.table_name,
                                   self.column_defn)
        
        database =  Database(self.database_name,True)
        with database:
            self.assertTrue(tbl_exists(database,self.table_name))
    
    def test_create_encoded_by_file(self):
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")

        DatabaseCreateTable.create_encoded_by_file(self.filename)
        
        database =  Database(self.database_name,True)
        with database:
            self.assertTrue(tbl_exists(database,self.table_name))
            
        os_file_delete(self.filename)
        
    def test_create_encoded_by_file_an_set_runtime_path(self):

        runtime_path = "C:\\Users\\burtnolej"
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")

        DatabaseCreateTable.create_encoded_by_file(self.filename,runtime_path=runtime_path)
        
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
        self.filename = "pyshell.txt"

        self.runtime_path = "C:\\Users\\burtnolej"
        
        
        DatabaseCreateTable.create(self.database_name,
                                   self.table_name,
                                   self.column_defn,
                                   runtime_path=self.runtime_path)
        
    def test_insert_encoded_by_file(self):
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+uuencode("True") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        
        put_2darray_in_file(self.filename,self.row,suffix="rows:")
        

        DatabaseInsertRows.insert_encoded_by_file(self.filename,
                                                  runtime_path=self.runtime_path)
        
        database =  Database(self.runtime_path + "\\" + self.database_name + ".sqlite",True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        self.assertEqual(result,self.row)
        
    def tearDown(self):
        os_file_delete(self.filename)
        #os_file_delete(self.runtime_path + "\\" + self.database_name + ".sqlite")
        
class Test_DatabaseInsertRows(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.columns = ['col1','col2','col3']
        self.column_defn = [('col1','text'),('col2','text'),('col3','integer')] 
        self.row =[['x','y',6],['a','s',8],['f','a',7]]
        self.qrows = _quotestrs(self.row)
        self.filename = "pyshell.txt"

        DatabaseCreateTable.create(self.database_name,
                                   self.table_name,
                                   self.column_defn)
        
    def test_insert(self):
        DatabaseInsertRows.insert(self.database_name,self.table_name,
                                  self.columns,
                                  self.qrows)
        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        self.assertEqual(result,self.row)
        
    def test_insert_bad_row(self):
        result = DatabaseInsertRows.insert(self.database_name,self.table_name,
                                           self.columns,
                                           [['a','b','c','d']],delete_flag=True)
        
        self.assertEqual(result,[-1])

    def test_insert_encoded_by_file(self):
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        
        put_2darray_in_file(self.filename,self.row,suffix="rows:")
        
        DatabaseInsertRows.insert_encoded_by_file(self.filename)
        
        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        self.assertEqual(result,self.row)
        
        os_file_delete(self.filename)
        
    def test_insert_encoded_by_file_stored_encoded(self):
        ''' don't decode the rows before storing in the database '''
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        
        put_2darray_in_file(self.filename,self.row,suffix="rows:")
        
        DatabaseInsertRows.insert_encoded_by_file(self.filename)
        
        def tryint(value):
            result = value
            try:
                result = int(value)
            except:
                pass
            return result
                
                
        database =  Database(self.database_name,True)
        with database:        
            _,result,_ = tbl_rows_get(database,self.table_name)
            
        _uresult =[]
        for resultrow in result:
            _uresult.append([tryint(uudecode(_field)) for _field in resultrow])

        print _uresult
        self.assertEqual(_uresult,self.row)
        
        os_file_delete(self.filename)

class Test_DatabaseInsertRowsLarge(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.column_defn = [('FirstName','text'),('LastName','text'),
                            ('Country','text'),('Description','text'),
                            ('Age','integer')] 
        self.columns= ['FirstName','LastName','Country','Description','Age'] 
        
        self.filename = "pyshell.txt"

        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")
        DatabaseCreateTable.create_encoded_by_file(self.filename)

    def test_(self):

        append_text_to_file(self.filename,"decode_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        
        rows = get_2darray_from_file("testdata.csv")
        put_2darray_in_file(self.filename,rows,suffix="rows:")
    
        DatabaseInsertRows.insert_encoded_by_file(self.filename)

        ulastname = uuencode("Audra")
        
        database =  Database(self.database_name,True)
        with database:        
            columns,rows,_ = tbl_query(database,"select Description from foobar where FirstName = \""+ulastname+"\"")
        
        urows = [uudecode(_row[0]) for _row in rows]
        
        expected_results = ["natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare",
                            "Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet"]
                            
        self.assertListEqual(urows,expected_results)
        
    def tearDown(self):
        os_file_delete(self.filename)
    

class Test_DatabaseMisc(unittest.TestCase):
    def setUp(self):
        self.database_name = 'foobar'
        self.table_name = 'foobar'
        self.filename = "pyshell.txt"
        self.column_defn = [('FirstName','text'),('LastName','text'),
                                ('Country','text'),('Description','text'),
                                ('Age','integer')] 

        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")

        DatabaseCreateTable.create_encoded_by_file(self.filename)

    def test_(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n")
        self.assertTrue(DatabaseMisc.table_exists_by_file(self.filename))

    def test_fail(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode("foofoo") + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n")

        self.assertFalse(DatabaseMisc.table_exists_by_file(self.filename))
 
    def test_fail_database(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+uuencode("foofoo") + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n")

        self.assertFalse(DatabaseMisc.database_exists_by_file(self.filename))
        os_file_delete(self.database_name+".sqlite")
        
    def test_get_columns(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n")

        self.assertEquals(DatabaseMisc.get_table_info_by_file(self.filename),
                              [(u'FirstName', u'text'), (u'LastName', u'text'), (u'Country', u'text'), (u'Description', u'text'), (u'Age', u'integer')])

    def test_get_table_list(self):
        os_file_delete(self.filename)
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("True") + "\n")
        
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
        
        self.filename = "pyshell.txt"

    def test_(self):
        
        rows = get_2darray_from_file("testdata_2rows.csv")
        
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")
    
        put_2darray_in_file(self.filename,rows,suffix="rows:")
    
        clsobj = DatabaseBase._parse_input_file(self.filename)
        
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
        
        rows = get_2darray_from_file("testdata_2rows.csv")
        
        append_text_to_file(self.filename,"database_name:"+uuencode(self.database_name) + "\n")
        append_text_to_file(self.filename,"table_name:"+uuencode(self.table_name) + "\n")
        append_text_to_file(self.filename,"delete_flag:"+uuencode("False") + "\n")
        append_text_to_file(self.filename,"decode_flag:"+uuencode("True") + "\n")
        append_text_to_file(self.filename,"columns:"+"$$".join([uuencode(field) for field in self.columns]) + "\n")
        append_text_to_file(self.filename,"column_defns:"+"$$".join([uuencode(_name) +"^" + uuencode(_type) for _name,_type in self.column_defn]) + "\n")
    
        put_2darray_in_file(self.filename,rows,suffix="rows:")
    
        clsobj = DatabaseBase._parse_input_file(self.filename,
                                                runtime_path="C:\Users\burtnolej")
        self.assertEqual(clsobj.runtime_path,"C:\Users\burtnolej")
    
        self.assertEqual(clsobj.database_name,self.database_name)
        
    def tearDown(self):
        os_file_delete(self.filename)


if __name__ == "__main__":
    suite = unittest.TestSuite()   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseQueryTable))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseCreateTable))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRows))    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRowsLarge))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseFileParser))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseMisc))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseInsertRowsSetRuntimePath))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(Test_DatabaseQueryTableSetRuntimePath))

    unittest.TextTestRunner(verbosity=2).run(suite)