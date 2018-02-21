import unittest
from misc_utils_selenium import *
import shutil
import os
import time
from datetime import datetime, timedelta
import urllib      

def parse_serving_str(serving):

    serving_qty = ""
    serving_unit = ""
        
    open_bracket_location = serving.find("(")
    if open_bracket_location > -1:
        serving = serving[:open_bracket_location]
        
    _splits = serving.rstrip().lstrip().split(" ")
    
    if len(_splits)>2:
        pass
    else:
        try:
            serving_qty = _splits[0]
            serving_unit = _splits[1]
        except IndexError:
            pass
        
    return [serving,serving_qty,serving_unit]

#TEST_SERVINGS = ["4 cups (85g)","2 Egg - Scrambled","4 slice","2 tbsp","225 g","127.13 gram","112.5 g", "225 g","0.75 Tbsp","140.01 g (1 container)","2.67 cups (85g)","170.01 gram","133.34 grams","0.67 Tbsp","1.33 tbsp","75 g","42.38 gram","37.5 g"]

#for test_serving in TEST_SERVINGS:
#    print parse_serving_str(test_serving)
        

def dates_iter(currentdt,lastdt):
    while currentdt > lastdt:
        yield currentdt
        currentdt = currentdt - timedelta(days=1)
        
def login_to_website(browser):

    url = "http://www.myfitnesspal.com/food/diary?date=2017-10-13"
    
    browser.get(url)
    
    time.sleep(0.5)
    set_input_text_element("username","burtnolejusa@gmail.com",browser)
    time.sleep(0.5)
    set_input_text_element("password","G0ldm@n1",browser)
    time.sleep(0.5)
    click_button_by_type('submit',browser)

def element_exists_by_tag_name(root,tag_name):
    
    try:
        root.find_element_by_tag_name(tag_name)
    except NoSuchElementException:
        return False
    return True

def element_exists_by_class_name(root,class_name):
    
    try:
        root.find_element_by_class_name(class_name)
    except NoSuchElementException:
        return False
    return True

#--------- MAIN ---------------------------------------------------------------
COL_NAMES = ['meal_name','food_name','food_id','calories','carbs','fat','protein','sodium','sugar']

browser = webdriver.Remote(command_executor='http://127.0.0.1:4444/wd/hub',
                           desired_capabilities=DesiredCapabilities.CHROME)

login_to_website(browser)
lastdt = datetime.strptime("2017/10/17","%Y/%m/%d")
currentdt = datetime.now()

#lastdt = datetime.strptime("2017/10/16","%Y/%m/%d")
#currentdt = datetime.strptime("2017/10/17","%Y/%m/%d")

#currentdt = datetime.now()
#lastdt = currentdt - timedelta(days=1)


for date in dates_iter(currentdt,lastdt):

    url = "http://www.myfitnesspal.com/food/diary?date="+date.strftime('%Y-%m-%d')
    #2017-10-13"

    browser.get(url)

    table = browser.find_element_by_xpath("//table[@id=\"diary-table\"]")
    table_body = table.find_element_by_tag_name("tbody")
    rows = table_body.find_elements_by_tag_name("tr")
    
    for row_element in rows:
        
        if row_element.get_attribute("class") == "meal_header":
            if element_exists_by_class_name(row_element,"first"):
                meal_name = row_element.find_element_by_class_name("first").text 
        elif row_element.get_attribute("class") == "bottom":
            pass
        # ignore 'Totals', 'Daily Goals','Remaining' rows 
        elif "total" in row_element.get_attribute("class"):
            pass
        else:
            values = [date.strftime('%m/%d/%Y') ,meal_name]
            cells = row_element.find_elements_by_tag_name("td") 
            for cell in cells:
                if element_exists_by_class_name(cell,"js-show-edit-food"):
                    food_name = cell.find_element_by_class_name("js-show-edit-food").text 
                    a_el = cell.find_element_by_tag_name("a")
                    food_id = a_el.get_attribute("data-food-entry-id")
                    values.append(food_name.split(",")[0]) # name
                    
                    values = values + parse_serving_str(food_name.split(",")[-1])
                    
                    #values.append(food_name.split(",")[-1]) # serving size
                    values.append(food_id)
                elif cell.get_attribute("class") == "delete":
                    pass
                elif element_exists_by_class_name(cell,"macro-value"):
                    macro_value = cell.find_element_by_class_name("macro-value").text 
                    values.append(macro_value)
                else:
                    values.append(cell.text)
                    
            try:
                print "^".join(values)
            except:
                value_str = "^".join(values)
                print "".join(c for c in value_str if ord(c) > 31 and ord(c) < 128)
