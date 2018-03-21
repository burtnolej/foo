from win32com.client import gencache
from utils.database.database_util import Database, tbl_remove
from utils.database.database_table_util import tbl_query
from os import path

RUNTIMEDIR = "C:\\Users\\burtnolej\\Documents\\runtime"
DBPATH = path.join(RUNTIMEDIR,"foobar.sqlite")

excel = gencache.EnsureDispatch('Excel.Application')    
excel.Visible = False

workbook = excel.Workbooks.Open("C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\vba_source_new.xlsm")

vba_exec = ["Test_Utils.ProjectTestRunner",
            "Test_Array_Utils,Test_Entry_Utils"]

with database:
    tbl_remove(database,"foobar")

print excel.Run(*vba_exec)

database = Database(DBPATH,False)


sql = ('select test_result,count(*) from foobar where time = "111638" '
       'group by test_result')

with database:
    _,tbl_rows,_ = tbl_query(database,sql)

print tbl_rows
excel.DisplayAlerts = False 
workbook.Close(False)
excel.Quit()
