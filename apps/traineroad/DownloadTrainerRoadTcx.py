from selenium import webdriver
import os
import time
import sys
from datetime import datetime
from misc_utils import os_file_exists
from database_util import Database, tbl_create, tbl_exists
from database_table_util import tbl_rows_insert, _quotestrs
from misc_utils_log import Log, logger, PRIORITY
from misc_utils import thisfuncname
from collections import OrderedDict

DB_COLUMN_DEFN=[("start","text"),("end","text"),("filename","text"),("title","text"),("workout_type","text")]
DB_COLUMN_NAMES=["start","end","filename","title","workout_type"]
TR_HOME_PAGE="https://www.trainerroad.com/career/burtnolejusa"
TR_RIDES_URL="https://www.trainerroad.com/cycling/rides/"
DOWNLOAD_DIR = "C:\\Users\\burtnolej\\Downloads"

xpaths = {
    'usernameTxtBox' : "//input[@name='Username']",
    'passwordTxtBox' : "//input[@name='Password']",
    'submitButton' :   "//button[contains(text(),'Log In')]",
    'downloadButton' : "//button[contains(text(),'Download')]",
    'rideListName' : "//div[contains(@class,'ride-list-name')]",
    'downloadRide' : "//a[contains(@class,'downloadRide')]",
    'loadMore' : "//a[@id='loadMore']",
    'rideListDate': "//p[contains(@class,'gray-light')]/span",
    'rideTitle':"//h1[contains(@class,'mb0')]/a",
    'notes':"//textarea[contains(@class,'form-control')]",
}

if sys.platform == "win32":
    LOGDIR = "./"
else:
    LOGDIR = "/tmp/log"


log = Log(cacheflag=False,logdir=LOGDIR,verbosity=5,pidlogname=True,proclogname=False)
log.config =OrderedDict([('now',12),('type',10),('class',15),('funcname',15),('module',20),('msg',-1)])

class DownloadTrainerRoadTcx(object):
    
    def __init__(self,databasename="trainerroad",tablename="metadata"):
        self.databasename =databasename
        self.tablename =tablename
        log.log(PRIORITY.INFO,msg="DownloadTrainerRoadTcx instance created [db="+databasename+"] [tablename="+tablename+"]")
        
    @classmethod
    def run(cls,baseurl,xpaths,uname,pword,
            num_rides=None,load_page_num=10,
            databasename="trainerroad",tablename="metadata"):
        '''
        pass in a numrides of 1 to just process 1 file
        pass in load_page_num of 0 to not load multi pages
        '''
        
        cls1 = cls(databasename=databasename,tablename=tablename)
        cls1.start_chromedriver()
        cls1.baseurl = baseurl
        cls1.load_page(baseurl)
        cls1.login(xpaths,uname,pword)
        cls1.load_page_workouts(load_page_num)
            
        if num_rides == None:
            num_rides =cls1.get_num_rides(xpaths)
        
        rides = cls1.get_rides(num_rides)
        cls1.download_rides(rides)
        
        return(cls1)
    
    def start_chromedriver(self):
        try:
            chromedriver = "chromedriver"
            os.environ["webdriver.chrome.driver"] = chromedriver
            self.mydriver = webdriver.Chrome(chromedriver)
        except Exception, e:
            log.log(PRIORITY.FAILURE,msg="Failed to launch chromedriver ["+e.message+"]")
            raise e
        else:  
            log.log(PRIORITY.SUCCESS,msg="launched chromedriver")
 
    def load_page(self,url):
        self.mydriver.get(url)

    def login(self,xpaths,uname,pword):
        try:
            #Clear Username TextBox if already allowed "Remember Me"
            self.mydriver.find_element_by_xpath(xpaths['usernameTxtBox']).clear()
    
            #Write Username in Username TextBox
            self.mydriver.find_element_by_xpath(xpaths['usernameTxtBox']).send_keys(uname)
    
            #Clear Password TextBox if already allowed "Remember Me"
            self.mydriver.find_element_by_xpath(xpaths['passwordTxtBox']).clear()
    
            #Write Password in password TextBox
            self.mydriver.find_element_by_xpath(xpaths['passwordTxtBox']).send_keys(pword)
    
            #Click Login button
            self.mydriver.find_element_by_xpath(xpaths['submitButton']).click()
    
        except Exception, e:
            log.log(PRIORITY.FAILURE,msg="could not log into ["+self.baseurl+"] with uname=["+xpaths['usernameTxtBox']+"] pword=["+xpaths['passwordTxtBox']+"]")
            raise e
        else:  
            log.log(PRIORITY.SUCCESS,msg="logged into ["+self.baseurl+"]")
            
    def load_page_workouts(self,count,xpaths=xpaths):
        #Get a pointer to the LoadMore button that loads more workouts on the page
        loadmoreButton = self.mydriver.find_element_by_xpath(xpaths['loadMore'])
        
        i=0
        for i in range(count):
            try:
                
                time.sleep(1)
                #self.mydriver.execute_script("arguments[0].checked = true;",loadmoreButton)
                self.mydriver.execute_script("arguments[0].scrollIntoView();",loadmoreButton)
                time.sleep(1)
                loadmoreButton.click()
            except Exception,e:
                # sometimes the website refuses so regrab the reference
                #loadmoreButton = self.mydriver.find_element_by_xpath(xpaths['loadMore'])
                log.log(PRIORITY.FAILURE,msg="loading more on the ["+str(i)+"] iteration [" + e.__class__.__name__ + "]")
                time.sleep(10)
                i-=1
        log.log(PRIORITY.SUCCESS,msg="loaded [" + str(i) + "] more workouts ")

    def get_num_rides(self,xpaths=xpaths):
        
        try:
            num_rides = len(self.mydriver.find_elements_by_xpath(xpaths['rideListName']))
        except Exception, e:
            log.log(PRIORITY.FAILURE,msg="failed to get number of rides["+e.message+"]")
            raise e
        else:  
            log.log(PRIORITY.SUCCESS,msg="located ["+str(num_rides)+"] of rides")        
        return num_rides

    def get_rides(self,num_rides,xpaths=xpaths):
        rides = []
        for i in range(num_rides):
        
            try:
                nextRide = self.mydriver.find_elements_by_xpath(xpaths['rideListName'])[i]
                header = nextRide.find_element_by_css_selector("h3")
                attr = header.find_element_by_css_selector("a").get_attribute("href")
                rides.append(attr)
            except Exception,e:
                log.log(PRIORITY.FAILURE,msg="cannot get detail url for [" +str(i) + "] ride on page")
            finally:
                log.log(PRIORITY.SUCCESS,msg="got detail for [" +str(i) + "] ride on page")
            
        return rides

    def _write_to_db(self,row,dname,tname,cdefn,cnames):
        
        database = Database(dname)

        with database:
            if tbl_exists(database,tname) == False:
                tbl_create(database,tname,cdefn)
            tbl_rows_insert(database,tname,cnames,row)
            
    def _persist_ride_meta(self,xpaths=xpaths):
        # persist the meta data in the database from the current web page
        
        # get the name that the tcxParser will call the file so we can put the notes into a database
        new_file_name = self.dt.strftime("%Y%m%d")+"_"+self.rideid
    
        # get the notes
        notes = self.mydriver.find_element_by_xpath(xpaths['notes'])
        start,end,workout_type=notes.text.split(",")
        
        # prepare the row and write to the db
        row = _quotestrs([[start,end,new_file_name,self.ride_title,workout_type]])
        self._write_to_db(row,self.databasename,self.tablename,DB_COLUMN_DEFN, DB_COLUMN_NAMES)
        
    def _click_download(self,xpaths=xpaths):
        # click the download button on the current web page
        time.sleep(0.5)
        downloadButton = self.mydriver.find_element_by_xpath(xpaths['downloadRide'])
        downloadButton.click()
        time.sleep(0.5)
        
    def _get_ride_file_name(self,ride,xpaths=xpaths):
        # build the name of the download file so we can check if its already been downloaded
        # then exit as the workouts are downloaded in LIFO order, so a file that already exists
        # will signify the last new file to download
        # burtnolejusa-2017-12-28-free-ride-120-8019968.tcx
        self.rideid = ride.split("/")[-1].split("-")[0]    
        ride_list_date = self.mydriver.find_element_by_xpath(xpaths['rideListDate'])
        self.ride_title = self.mydriver.find_element_by_xpath(xpaths['rideTitle']).text.replace(" ","-").lower()
        self.dt = datetime.strptime(ride_list_date.text,"%A, %b %d, %Y at %H:%M %p")
        ride_file_name = "burtnolejusa-" + self.dt.strftime("%Y-%m-%d")+"-"+self.ride_title+"-"+self.rideid+".tcx"        
        return(ride_file_name)
    
    def download_rides(self,rides,xpaths=xpaths):
        for ride in rides:
            try:
                self.mydriver.get(ride) 
            except Exception,e:
                log.log(PRIORITY.FAILURE,msg="cannot load page for [" +ride+ "] ["+e.message+"]")
                continue
            else:
                log.log(PRIORITY.SUCCESS,msg="loaded page for [" +ride+ "]")
        
            ride_file_name = self._get_ride_file_name(ride,xpaths=xpaths)
              
            if os_file_exists(DOWNLOAD_DIR + "\\"+ ride_file_name)==True:
                #print "skipping",ride_file_name,"already downloaded, exitting"
                log.log(PRIORITY.INFO,msg="skipping, already downloaded [" +ride_file_name+ "] exitting")
                exit()
            else:
                try:
                    self._click_download(xpaths=xpaths)
                    try:
                        self._persist_ride_meta(xpaths=xpaths)
                    except Exception,e:
                        log.log(PRIORITY.FAILURE,msg="failed to download meta  [" +ride_file_name+ "] ["+e.message+"]")
                    else:
                        log.log(PRIORITY.SUCCESS,msg="downloaded meta for [" +ride_file_name+ "]")
                        
                except Exception,e:
                    log.log(PRIORITY.FAILURE,msg="cannot download tcx file for  [" +ride_file_name+ "] ["+e.message+"]")
                    continue
                else:
                    log.log(PRIORITY.SUCCESS,msg="downloaded tcx file for  [" +ride_file_name+ "]")
                    

            self.mydriver.back()
            time.sleep(0.5)

    def __del__(self):
        if hasattr(self,"mydriver"):
            self.mydriver.close()
        
if __name__ == "__main__":

    baseurl = "https://www.trainerroad.com/login"
    ridesurl = "https://www.trainerroad.com/cycling/rides/"
    
    uname = "burtnolejusa"
    pword= "G0ldm@n1"

    dtr_tcx = DownloadTrainerRoadTcx.run(baseurl,xpaths,uname,pword,
                                         num_rides=1,load_page_num=0)
    
    ''' to just download the most recent, set num_rides =1; if num_rides is not set
    app will download all the rides on the career page; that number will be defined by 
    the number of load_page_num performed '''
    
    #dtr_tcx = DownloadTrainerRoadTcx.run(baseurl,xpaths,uname,pword,
    #                                     load_page_num=10)
    
    del dtr_tcx
    