from module_utils import __load_module__ as load_module
from misc_utils import os_file_exists, add2dict
import unittest
from types import ListType, StringType
import sys
from os import walk, getcwd
from os.path import join, splitext
from types import ListType, BooleanType
from getopt import getopt, GetoptError, gnu_getopt
from pprint import pprint

def usage():
    print 
    print "usage:"
    print "test_utils.py --inc_module     = only run tests for these modules (comma delim)"
    print "              --inc_testcase   = only run these testcase (comma delim)"
    print "              --rootdir    = run all discovered test under this dir" 
    print "              --dryrun     = report tests that would be run" 
    print "              --usage      = this message" 
    

def parse_args(argv):
    try:
        opts, args = getopt(argv[1:], "udm:t:r:e:", ["usage","dryrun","rootdir=","exc_module=","inc_module=","inc_testcase="])

        opt_config = {} # optional flags
        
        for flag, value in opts:
            if flag in ("-m", "--inc_module"):
                opt_config[flag.replace("--","")] = value.split(",")
                continue
            elif flag in ("-t", "--inc_testcase"):
                opt_config[flag.replace("--","")] = value.split(",")
                continue
            elif flag in ("-e", "--exc_module"):
                opt_config[flag.replace("--","")] = value.split(",")
                continue
            elif flag in ("-r", "--rootdir"):
                pass
            elif flag in ("-d","--dryrun"):
                opt_config[flag.replace("--","")] = True
                continue
            elif flag in ("-u", "--usage"):
                usage()
                exit()
            else:
                assert GetoptError(flag + " unhandled option")
                
            opt_config[flag.replace("--","")] = value
                    
    except GetoptError as err:
        print err
        usage()
        sys.exit(2)
        
    return opt_config    
    
def _initresult(this_result_type,result_types):
    """ init a results dict for purposed of summarizing test results, will increment 'this_result_type'
    :param this_result_type: string, member of result_types list
    :param result_types: list, set of allowed types
    rtype:dict of results {type1:0,type2:0}}
    """
    assert isinstance(this_result_type,StringType),this_result_type
    assert isinstance(result_types,ListType),result_types
    assert this_result_type in result_types
    
    _result ={}
    for result_type in result_types:
        _result[result_type] = 0
    _result[this_result_type] = 1
    return _result

def summarise_testresults(results):
    """ print out results in summarized form so its easy to see which test modules had the most fails
    :param results:unittest.TextTestResult, completed result set
    rtype:dict of results {module_name:{failed:0,success:0,error:0}}
    """
    assert isinstance(results,unittest.TextTestResult),results
    result_sum = {}
    
    result_types = ['errors','failures']
    
    for result_type in result_types:
        _detail = getattr(results,result_type)
        for i in range(len(_detail)):
            module_name = type(_detail[i][0]).__module__
            if result_sum.has_key(module_name) == False:
                result_sum[module_name] = _initresult(result_type,result_types)
            else:
                result_sum[module_name][result_type]+=1
    return result_sum
                       
def testrunner(rootdir="C:\\Users\\burtnolej\\Development",
               inc_testcase=[],inc_module=[],exc_module=[],dryrun=False):
    
    assert isinstance(inc_testcase,ListType), inc_testcase
    assert isinstance(inc_module,ListType), inc_module
    assert isinstance(dryrun,BooleanType), dryrun
    assert os_file_exists(rootdir),rootdir
        
    suite = unittest.TestSuite()
    testsummary = {}

    for root,cwd,files in walk(rootdir):
        for file in files:
            if file.startswith("test_") and splitext(file)[1] == ".py":
                if inc_module != [] and file not in inc_module: continue
                if exc_module != [] and file in exc_module: continue
                _module = load_module(join(root,file))  
                for item in dir(_module):
                    if item.startswith('Test'):
                        if inc_testcase != [] and item not in inc_testcase: continue
                        suite.addTest(unittest.TestLoader().loadTestsFromTestCase(getattr(_module,item)))
                        add2dict(testsummary,file,item)    
    if dryrun:
        pprint(testsummary)
    else:
        results = unittest.TextTestRunner(verbosity=3,buffer=True).run(suite)
        pprint(summarise_testresults(results))
    
if __name__ == "__main__":
    
    opt_config = parse_args(sys.argv)
    testrunner(**opt_config)