from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, tbl_rows_get, tbl_query

import unittest
from DownloadTrainerRoadTcx import DB_COLUMN_DEFN,DB_COLUMN_NAMES,DownloadTrainerRoadTcx, TR_HOME_PAGE, TR_RIDES_URL, DOWNLOAD_DIR, log
from misc_utils import os_file_exists
from misc_utils_log import Log, logger
from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, _quotestrs
from collections import OrderedDict
import os

class TestDownloadTrainerRoadTcx_WriteToDB(unittest.TestCase):
    def setUp(self):
        self.cdefns = DB_COLUMN_DEFN
        self.cnames = DB_COLUMN_NAMES
        self.dtr_tcx = DownloadTrainerRoadTcx()
        self.dname = "foo"
        self.tname = "bar"
             
    def test_(self):
        start = "10:01"
        end = "20:02"
        new_file_name = "foo"
        ride_title = "foo_title"
        workout_type = "z2"
        
        row = _quotestrs([[start,end,new_file_name,ride_title,workout_type]])
        self.dtr_tcx._write_to_db(row,self.dname, self.tname,self.cdefns,self.cnames)
        
        expected_results = [[u'10:01', u'20:02', u'foo', u'foo_title', u'z2']]
        
        database = Database(self.dname, True)  
        with database:
            _,rows,_ = tbl_rows_get(database,self.tname)
            
        self.assertListEqual(expected_results,rows)
            
    def tearDown(self):
        pass
 
class BaseTestDownloadTrainerRoadTcx(unittest.TestCase):
    def setUp(self):
        self.baseurl = "https://www.trainerroad.com/login"
        self.ridesurl = "https://www.trainerroad.com/cycling/rides/"
        
        self.xpaths = {
            'usernameTxtBox' : "//input[@name='Username']",
            'passwordTxtBox' : "//input[@name='Password']",
            'submitButton' :   "//button[contains(text(),'Log In')]"
        }
        
        self.uname = "burtnolejusa"
        self.pword= "G0ldm@n1"
        
        self.dname = "foo"
        self.tname = "foo"
        
        log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])
        #log.echoflag = True
        
        self.dtr_tcx = DownloadTrainerRoadTcx(databasename=self.dname,
                                               tablename=self.tname)   
        self.dtr_tcx.baseurl = self.baseurl
        
        self.dtr_tcx.start_chromedriver()        
    
    def test_(self):
        pass
    
    def tearDown(self):
        del self.dtr_tcx

class TestDownloadTrainerRoadTcx_Login(BaseTestDownloadTrainerRoadTcx):
    def test_(self):
        
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)
        self.assertEquals(self.dtr_tcx.mydriver.current_url,TR_HOME_PAGE)
    
class TestDownloadTrainerRoadTcx_GetNumRides(BaseTestDownloadTrainerRoadTcx):
    def test_(self):
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)
        
        self.xpaths['rideListName'] = "//div[contains(@class,'ride-list-name')]"
        num_rides = self.dtr_tcx.get_num_rides(self.xpaths)
        self.assertEquals(num_rides,10)
        
class TestDownloadTrainerRoadTcx_LoadMore(BaseTestDownloadTrainerRoadTcx):
    def test_(self):
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)
        
        self.xpaths['rideListName'] = "//div[contains(@class,'ride-list-name')]"   
        self.xpaths['loadMore'] = "//a[@id='loadMore']"
        self.dtr_tcx.load_page_workouts(10)
        num_rides = self.dtr_tcx.get_num_rides(self.xpaths)
        self.assertEquals(num_rides,110)
        
class TestDownloadTrainerRoadTcx_GetRides(BaseTestDownloadTrainerRoadTcx):
    def test_(self):
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)

        self.xpaths['rideListName'] = "//div[contains(@class,'ride-list-name')]"
        
        rides = self.dtr_tcx.get_rides(10)
        
        self.assertEquals( len(rides),10)
        
        for _ride in rides:
            self.assertTrue(_ride.startswith(TR_RIDES_URL))
       
class TestDownloadTrainerRoadTcx_GetRideFileName(BaseTestDownloadTrainerRoadTcx):
    def test_(self):
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)
    
        self.xpaths['rideListName'] = "//div[contains(@class,'ride-list-name')]"
    
        rides = self.dtr_tcx.get_rides(1)
        
        self.dtr_tcx.mydriver.get(rides[0])
        
        self.xpaths['rideListDate']="//p[contains(@class,'gray-light')]/span"
        self.xpaths['rideTitle']="//h1[contains(@class,'mb0')]/a"
        
        ride_file_name = self.dtr_tcx._get_ride_file_name(rides[0],self.xpaths)
        
        self.assertTrue(ride_file_name.startswith("burtnolejusa-"))
            
class TestDownloadTrainerRoadTcx_DownloadRide_WithMeta(BaseTestDownloadTrainerRoadTcx):
    ''' this will take the latest workout from the trainerroad site; to pass this test then
    meta data needs to be put in the notes section of the workouts webpage '''
    def test_(self):
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)

        self.xpaths['rideListName'] = "//div[contains(@class,'ride-list-name')]"
        
        rides = self.dtr_tcx.get_rides(1)
        
        self.xpaths['downloadRide']="//a[contains(@class,'downloadRide')]"
        self.xpaths['rideListDate']="//p[contains(@class,'gray-light')]/span"
        self.xpaths['rideTitle']="//h1[contains(@class,'mb0')]/a"
        self.xpaths['notes']="//textarea[contains(@class,'form-control')]"
        
        self.dtr_tcx.download_rides(rides,self.xpaths)
       
        database = Database(self.dname,True)
        
        with database:
            _,rows,_ = tbl_rows_get(database,self.tname)
            
            self.assertTrue(len(rows),1)
            self.assertTrue(len(rows[0]),4)
          
        self.xpaths['rideListDate']="//p[contains(@class,'gray-light')]/span"
        self.xpaths['rideTitle']="//h1[contains(@class,'mb0')]/a"
    
        # get the file name that would have been downloaded
        # check it has been downloaded and then delete it
        self.dtr_tcx.mydriver.get(rides[0])
        
        ride_file_name = self.dtr_tcx._get_ride_file_name(rides[0],self.xpaths) 
            
        self.assertTrue(os_file_exists(DOWNLOAD_DIR+"\\"+ride_file_name))    
        
        os.remove(DOWNLOAD_DIR+"\\"+ride_file_name)
            
class TestDownloadTrainerRoadTcx_DownloadRide_NoMeta(BaseTestDownloadTrainerRoadTcx):
    def test_(self):
        self.dtr_tcx.load_page(self.baseurl)
        self.dtr_tcx.login(self.xpaths,self.uname,self.pword)

        self.xpaths['rideListName'] = "//div[contains(@class,'ride-list-name')]"
        
        rides = self.dtr_tcx.get_rides(1)
        
        self.xpaths['downloadRide']="//a[contains(@class,'downloadRide')]"
        self.xpaths['rideListDate']="//p[contains(@class,'gray-light')]/span"
        self.xpaths['rideTitle']="//h1[contains(@class,'mb0')]/a"
        self.xpaths['notes']="//textarea[contains(@class,'form-control')]"
        
        self.dtr_tcx.download_rides(rides,self.xpaths)

        # get the file name that would have been downloaded
        # check it has been downloaded and then delete it
        self.dtr_tcx.mydriver.get(rides[0])
        
        ride_file_name = self.dtr_tcx._get_ride_file_name(rides[0],self.xpaths) 
            
        self.assertTrue(os_file_exists(DOWNLOAD_DIR+"\\"+ride_file_name))    
        
        os.remove(DOWNLOAD_DIR+"\\"+ride_file_name)

if __name__ == "__main__":
    
    suite = unittest.TestSuite()
      
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_Login))   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_GetNumRides))   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_LoadMore))   
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_GetRides))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_DownloadRide_WithMeta))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_DownloadRide_NoMeta))
    
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_GetRideFileName))
    suite.addTest(unittest.TestLoader().loadTestsFromTestCase(TestDownloadTrainerRoadTcx_WriteToDB))
    
    unittest.TextTestRunner(verbosity=2).run(suite)