import sys

from os import walk, getcwd
from os.path import basename, splitext, join, isdir, abspath, isabs, dirname, isfile
import unittest
sys.path.append("/home/burtnolej/Development/pythonapps3/clean/utils")
from module_utils import __load_module__ as load_module
from getopt import getopt, GetoptError, gnu_getopt
from unittest import suite


def _ignoredir_test(thisdir,ignore_dir):
    for _ignoredir in ignore_dir:
        if thisdir.startswith(_ignoredir):
            return True
    return False
    
def _get(root,dirs,files,testsummary,suite,ignoredir,allowdupe,specific_tests=[]):

    def _addtest(module,item,testsummary):
        
        if not hasattr(module,item):
            raise Exception("test",item,"is not in module",module)
        
        suite.addTest(unittest.TestLoader().loadTestsFromTestCase(getattr(module,item)))
        if not testsummary.has_key(file) == True:
            testsummary[file] = []
        testsummary[file].append(str(item))
        
    if _ignoredir_test(root,ignoredir) == False:
        for file in files:   
            if file.startswith("test_") and splitext(file)[1] == ".py":
                try:
                    print "info:searching",root
                    module = load_module(join(root,file),allowdupe)
                    
                    if specific_tests <> []:
                        for specific_test in specific_tests:
                            _addtest(module,specific_test,testsummary)
                            return
                        
                    for item in dir(module):
                        if item.startswith('Test'):
                            _addtest(module,item,testsummary)
                                
                except ImportError, e:
                    print "error: loading module",join(root,file),e
                    raise e
    else:
        print "info: ignoring",root

    
def testsuite_get(rootdir=None,allowdupe=False,ignoredir=[],
                  specific_files=[],specific_tests=[]):
    
    print "info:rootdir={0},allowdupe={1},ignoredir={2},specific_files={3},specific_tests={4}".format(rootdir,
                                                                                                      allowdupe,
                                                                                                      ignoredir,
                                                                                                      specific_files,
                                                                                                      specific_tests)

    # this requires abspaths for rootdir and ignoredir
    cwd = getcwd()
    
    if rootdir==None:
        rootdir=cwd
        
    suite = unittest.TestSuite() 
    testsummary={}
    
    print "\n\n==",rootdir,"================================================="

    if specific_files == []:
        
        for root, dirs, files in walk(rootdir): 
            _get(root,dirs,files,testsummary,suite,ignoredir,allowdupe)
    else:
        for specific_file in specific_files:
            
            _get(join(rootdir, dirname(specific_file)),[],[basename(specific_file)],
                 testsummary,suite,ignoredir,allowdupe,specific_tests)
            
    #return(rootdir, testsummary)
    return(suite, testsummary)

def testsuite_run(suite):
    return(unittest.TextTestRunner(verbosity=3,buffer=True).run(suite))
    
def _parsetesttrace(trace):
    
    ''' returns : the error message
                : the line no that failed
                : the test function that has failed '''
                  
    # trace as string will have newlines embedded
    if len(trace.split("\n")) == 0:
        raise Exception("expecting a trace as a string got ",trace)
       
    _trace = trace.split("\n")
    return(_trace[-2], _trace[1].split(",")[1], _trace[1].split(",")[2][4:])

def _parsetestcase(testcase):
    print type(testcase)
    print testcase.__class__.__name__
    
    #return(testcase.split(" ")[1][1:-1])
                        
def testsuite_results(testresult):
    
    import pprint
    
    if not isinstance(testresult,unittest.TextTestResult):
        raise Exception("expecting a TextTestResult but got",type(result))
    result={}
    
    result['#tests'] = testresult.testsRun
    
    for error_type in ['failures','errors']:
        results = getattr(testresult,error_type)
        result['#'+error_type] = len(results)
        result[error_type]=[]
        
        for testcase,trace in results:
            _result = {}
            _result['name'] = testcase.__class__.__name__
            _result['trace'] = _parsetesttrace(trace)
            result[error_type].append(_result)
            
    print "info:executing, results"
    pprint.pprint(result)

    return(result)
    
def printusage(msg):
    print "\nusage: --rootdir [valid dir]"
    print msg
    exit()

if __name__ == "__main__":
    rules = ['rootdir=','ignoredir=','specific_file=','specific_test=']
    input_file = None
    params={}
    
    try:
        options,remainder = getopt(sys.argv[1:],'',rules)
    except GetoptError, e:
        printusage("error:"+e.msg)
    
    args={}
    for option, value in options:
        if option == '--rootdir':
            args[option[2:]] = abspath(value)
        if option == '--ignoredir':
            args[option[2:]] = abspath(value)
        if option == '--specific_file':
            args[option[2:]] = abspath(value)
        if option == '--specific_test':
            args[option[2:]] = value
                                       
    if not args.has_key('rootdir'):
        printusage("error: --rootdir arg must be set to a real directory")
        
    cwd = getcwd()
    if not isdir(args['rootdir']) or not isabs(args['rootdir']):
        printusage("error: --ignoredir arg must be an abspath of a real directory")
    else:
        params['rootdir']=args['rootdir']
        
        
    if args.has_key('ignoredir') and isdir(args['ignoredir']):
        if not isabs(args['ignoredir']):
            printusage("error: --ignoredir must be an abspath of a real directory")
        params['ignoredir']=[args['ignoredir']]        
            
    if args.has_key('specific_file') and isfile(args['specific_file']):
        if not isfile(args['specific_file']):
            printusage("error: --specific_file must be a specific file")
        params['specific_files']=[args['specific_file']]
        
        # can only specify a test if you have already specified a file
        if args.has_key('specific_test'):
            params['specific_tests']=[args['specific_test']]
    
    suite, testsummary = testsuite_get(**params)
    testresult = testsuite_results(testsuite_run(suite))
    
