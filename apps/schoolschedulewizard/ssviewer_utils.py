import sys
import os

from misc_utils_log import Log, logger
log = Log(cacheflag=True,logdir="/tmp/log",verbosity=20,
          pidlogname=True,proclogname=False)

from misc_utils import nxnarraycreate, thisfuncname
from misc_utils_objectfactory import ObjFactory
from misc_utils_generic import IDGenerator
import sswizard_utils
import sswizard_query_utils
from ssviewer_utils_palette import *
#from ssviewer_utils_palette import init_formats

from database_util import Database, tbl_create
from database_table_util import dbtblgeneric, tbl_rows_get, tbl_query, tbl_rows_insert, \
     tbl_rows_update, tbl_exists, tbl_create

from ssviewer_utils_palette import dbformats_get, dbcolors_get
from collections import OrderedDict
from copy import deepcopy

dbname,_ = sswizard_utils.getdatabase()

colorpalette = dbformats_get(dbname,'bgcolor')
fontpalette = dbformats_get(dbname,'fgcolor')
colors = dbcolors_get(dbname)

class OFDuplicateRecord(Exception):
    pass

class schoolschedgeneric(dbtblgeneric):

    def __init__(self,of,database,recursion=True,**kwargs):
        self.recursion = recursion
        super(schoolschedgeneric,self).__init__(database=database,
                                                **kwargs)
        
        #self.of = of
        self.database = database
        
        for k,v in kwargs['dm'].iteritems():
            if v <> 'None':
                if recursion == True:
                    # create objects for all member attributes
                    self.attr_set(of,v,k)
                                   
    def attr_set(self,of,name,clsname):        
        datamembers = dict(objtype=clsname,
                           userobjid=name,
                           name=name)
        
        datamembers['code'] = name
        
        try:
            datamembers['enum'] = len(of.store[clsname]) + 1    
        except KeyError:    
            datamembers['enum'] = 0
            
        obj = of.new(schoolschedgeneric,
                     clsname,
                     objid=name, # unique key to store obj in of
                     constructor='datamembers',
                     database=self.database,
                     of=of,
                     modname=__name__,
                     recursion=False,
                     dm=datamembers)
        
        setattr(self,clsname,obj)
        
        '''datamembers['id'] = self.id
        datamembers['code'] = name'''
        obj.dm['id'] = obj.id
        

        return(getattr(self,clsname))
       
    def persist(self,createtable=True):

        self._metadata_set()

        # switch adult name to teacher
        try:
            _idx = self.tbl_col_defn.index('adult')
            self.tbl_col_defn.remove('adult')
            self.tbl_col_defn.insert(0,'teacher')
        except:
            pass
        

        if not tbl_exists(self.database,self.tbl_name) ==True:
            tbl_create(self.database,
                       self.tbl_name,
                       self.tbl_col_defn)

        try:
            _idx = self.tbl_col_names.index('adult')
            self.tbl_col_names.remove('adult')
            self.tbl_col_names.insert(0,'teacher')
        except:
            pass

        # and also objtype is not persisted
        try:
            _idx = self.tbl_col_names.index('objtype')
            self.tbl_col_names.pop(_idx)
            self.tbl_row_values[0].pop(_idx)
        except:
            pass
        
        # or userobjid
        try:
            _idx = self.tbl_col_names.index('userobjid')
            self.tbl_col_names.pop(_idx)
            self.tbl_row_values[0].pop(_idx)
        except:
            pass        
        
        result,exec_str = tbl_rows_insert(self.database,
                                          self.tbl_name,
                                          self.tbl_col_names,
                                          self.tbl_row_values)

        if hasattr(self,"id") == False:
            _idx = self.tbl_col_names.index('__id')
            setattr(self,"id",self.tbl_row_values[_idx])

        if self.dm.has_key('id') == False:
            _idx = self.tbl_col_names.index('__id')
            self.dm["id"] = self.tbl_row_values[0][_idx].replace('\"','')
        
        return(result,exec_str)


    def update(self,of,field,newvalue,dbname=None):

        # this is needed to get around the sqlite limitation that
        # an sqlite cursor can only be used in the thread it was instantiated in
        if dbname <> None:
            database = Database(dbname)
        else:
            database = self.database
            
        # this is over writing the base class update
        
        # these are hacks; and the datatypes id/adult need to be
        # called the same thing internally all the time
        # until then though ....

        # remove the id field as its set on the object from the
        # internal __id field for convenience but should not be repersisted
        # as the database layer will create the new __id for any revisions
        
        if hasattr(self,'id') == True:
            _oldidobj = getattr(self,'id')
        elif hasattr(self,'__id') == True:
            _oldidobj = getattr(self,'__id')
        else:
            raise Exception("cannot find an ID field")
        
        if hasattr(_oldidobj,"name") == True:
            setattr(self,"__id",_oldidobj.name)
        else:
            setattr(self,"__id",_oldidobj)
            
        delattr(self,'id')

        self.tbl_row_value_get(False)
        self.tbl_col_defn_get(False)
        self.tbl_name_get()

        # and also 
        try:
            _idx = self.tbl_col_names.index('adult')
            self.tbl_col_names.remove('adult')
            self.tbl_col_names.insert(0,'teacher')
        except:
            pass

        # and also objtype is not persisted
        try:
            _idx = self.tbl_col_names.index('objtype')
            self.tbl_col_names.pop(_idx)
            self.tbl_row_values[0].pop(_idx)
        except:
            pass

        currentrecord = dict(zip(self.tbl_col_names,self.tbl_row_values[0]))

        _id = IDGenerator().getid()
        _ts = self._gettimestamp()

        
        
        newrecord = deepcopy(currentrecord)
        newrecord['__version'] = "\"current\""
        newrecord[field] = "\"" + str(newvalue) + "\""
        newrecord['__id'] = "\""+_id+"\""
        newrecord['saveversion'] = 1

        newrecord['__timestamp'] = "\""+_ts+"\""

        #_newvalobj = of.object_get_byval(field,newvalue)
        
        if currentrecord[field] <> newrecord[field]:
            # create a new row in the database with version "current"
            
            with database:
                result,exec_str = tbl_rows_insert(database,
                                                  self.tbl_name,
                                                  newrecord.keys(),
                                                  [newrecord.values()])
    
                # update version of current row to version "version"
                tbl_rows_update(database,self.tbl_name,['__version',"\"version\"",
                                                             '__id',"\""+getattr(self,"__id")+"\""])

            # update in mem object to new val and new db version id and timestamp
            
            # assumes that field is also an objects whose value is in the name attr
            
            if field=="teacher": 
                field = "adult"
                
            _newvalobj = of.object_get_byval(field,newvalue)
            
            if _newvalobj == None:
                log.log(thisfuncname(),2,msg="tryng to update to a value that does not exist",field=field,newvalue=newvalue)
                return -1
            
            #_oldobj = getattr(self,field)
            #setattr(_oldobj,'name',newvalue)
            setattr(self,field,_newvalobj)

            # give the new updated record the same database ref id as prev version
            if hasattr(_oldidobj,"name") == True:
                #setattr(self,"__id",_oldidobj.name)
                setattr(_oldidobj,"name",_id)
            else:
                #setattr(self,"__id",_oldidobj)
                setattr(self,_oldidobj,_id)

            #setattr(_oldidobj,"name",_id)
            setattr(self,'id',_oldidobj)
            
            #setattr(self,'id',_id)
            setattr(self,'__version',"current")
            setattr(self,'__timestamp',_ts)
            
            # update internal dm
            _dm = getattr(self,"dm")
            _dm[field] = newvalue
            _dm['id'] = _id
            setattr(self,"dm",_dm)
            
        return _id
    

def _getpage(grid,pagelen,pagenum):
    
    numrows = len(grid)
     
    startrow = 0
    if pagenum <> 1:
        startrow = ((pagenum-1)*pagelen)
     
    endrow=pagelen
    if numrows > pagelen:
        endrow =  (pagenum*pagelen)-1
        
    if endrow > numrows:
        endrow = numrows-1
         
    if startrow > numrows:
        startrow = numrows-pagelen
        endrow = numrows-1
    return(startrow,endrow)
    
def dataset_list(of,enums=None,objtype='lesson',pagelen=30,pagenum=1,
                 constraints=[],columns=None):
    
    try:
        source_objs = of.query_advanced(objtype,constraints)
    except KeyError:
        log.log(thisfuncname(),3,msg="list requested and no members found",objtype=objtype,constraints=constraints)
        return [],[]
    
    grid = []
    colnames = list(source_objs[0].dm.keys())

    # first row is the column headers; if specific columns are provided
    # then remove from colnames before adding
    if columns<>None and columns<>[]:
        colnames = columns
        
    grid.append(colnames)
            

    startrow,endrow = _getpage(source_objs,pagelen,pagenum)

    for i in range(startrow,endrow+1):
        if columns==None or columns==[]:
            columns = colnames
            #grid.append(source_objs[i].dm.values())
        #else:
        _l=[]
        for col in columns:
            try:
                _l.append(source_objs[i].dm[col])
            except:
                _l.append("none")
        grid.append(_l)

    return grid,colnames

def dataset_record(of,clsname,objid,new=False):
    
    if of.object_exists(clsname,objid) == True:   
        obj = of.object_get(clsname,objid)
        return(obj.dm)

    return({})

@logger(log) 
def dataset_pivot(of,enums,yaxis_type,xaxis_type,ztypes, source_type,source_value,
           conflicts_only='N',constraints=None,wratio=None,formatson=False,rollupson=False):
    
    ''' query in memory objects; pivot data and create a table of results; return in 2d array '''
        
    log.log(thisfuncname(),3,yaxis_type=yaxis_type,xaxis_type=xaxis_type,ztypes=ztypes,source_type=source_type,source_value=source_value,
               conflicts_only=conflicts_only,constraints=constraints,wratio=wratio,formatson=formatson,rollupson=rollupson)
    
    if source_value == "":
        source_objs = of.query(source_type)
    else:
        source_objs = [of.object_get(source_type,source_value)]
        
    xaxis_obj = of.query(xaxis_type)
    yaxis_obj = of.query(yaxis_type)

    count=1
    
    # uncomment here to make DOW's present in order
    yaxis_enum = OrderedDict() 
    #yaxis_enum = {}
    for _yaxis_obj in yaxis_obj:
        yaxis_enum[_yaxis_obj.name] = count
        count+=1
     
    count=1   
    xaxis_enum = OrderedDict()
    #xaxis_enum = {}
    for _xaxis_obj in xaxis_obj:
        xaxis_enum[_xaxis_obj.name] = count
        count+=1
        
    # use these if want to drive pivot axes from ref table rather than the  values
    # used so far by actual objects
    #xaxis_enum = enums[xaxis_type]['name2enum']
    
    values = [] # contains the values displayed on the grid

    values = [['']]
    for yval in yaxis_enum.keys():
        values[0].append(yval)
        
    for xval in xaxis_enum.keys():
        values.append([xval])

    ymax = len(values[0])
    xmax = len(values)-1
    
    def _additem(celltext,item):
        
        if len(celltext) == 0:
            celltext.append(item)
        else:
            try:
                celltext.index(item)
            except:
                celltext.append(item)
        return(celltext)
            
    for yval,y in yaxis_enum.iteritems():
        
        for xval,x in xaxis_enum.iteritems():
            celltext=[]
            
            for source_obj in source_objs:
                if source_obj.lessons.has_key(yval):
                    if source_obj.lessons[yval].has_key(xval):

                        _vals = source_obj.lessons[yval][xval]

                        for _val in _vals:
                            
                            if constraints <> None and constraints <> []:
                                flag=False
                                
                                
                                for objtype,objval in constraints:

                                    lobjvals = objval.split(",")
                                    
                                    match=None
                                    for lobjval in lobjvals:
                                        if str(getattr(_val,objtype).name) <> str(lobjval):
                                            if match <> False:
                                                match=True
                                        else:
                                            match=False
                                    if match==True:
                                        flag=True
                                            
                                if flag == True:
                                    continue
                                
                            if ztypes == ['*']:
                                if celltext == []:
                                    celltext.append(1)
                                else:
                                    celltext[0] = celltext[0] + 1
                                continue

                            _celltext = []
                            
                            for ztype in ztypes:
                                if hasattr(_val,ztype) == True:
                                    zval = getattr(_val,ztype)
                                    
                                    try:
                                        _celltext.index(zval.name)
                                    except:
                                        if hasattr(zval,'name'):
                                            _celltext = _additem(_celltext,zval.name)
                                        else:
                                            _celltext = _additem(_celltext,zval)
                                        pass
                                        
                            try:      
                                celltext.index(tuple(_celltext))
                            except:
                                celltext.append(tuple(_celltext))
                                
            values[x].append(celltext)

    sswizard_utils.gridreduce(values,[[]])
    
    if rollupson == True:
        sswizard_utils.gridrollup(values,['subject','adult'],dict(ztypes='subject,adult,student'))

    return values


def dataset_serialize(values,formatson,schema=None):

    #if formatson==True:                
        for x in range(len(values)):
            for y in range(len(values[x])):
                _value = values[x][y]

                if isinstance(_value,list) == True:
                    if _value <> []:
                        values[x][y] = []
                        ''' uncomment if want to generate conflicts report'''
                        #if len(_value) == 1 and conflicts_only <> "Y":
                        if len(_value) == 1:
                            if isinstance(_value[0],tuple) == True:
                                # 1 item, multi attributes
                                bgs,fgs = _color_get_multi(_value[0])
                                
                                _formats = []
                                for i in range(len(_value[0])):
                                    args = dict(value=_value[0][i])
                                    #args = dict(value=_value[0][i],bgcolor=bgs[i],fgcolor=fgs[i])
                                    if schema<>None: args['valuetype'] = schema['ztypes'][i]
                                    
                                    
                                    if formatson==True:
                                        args['bgcolor'] = bgs[i]
                                        args['fgcolor'] = fgs[i]
                                        
                                    _formats.append(args)
                                    
                                    
                                values[x][y].append(tuple(_formats))
                            elif isinstance(_value[0],list) == False:
                                # 1 item, single value
                                _formats = []
                                
                                args = dict(value=_value[0])
                                
                                if formatson==True:
                                    args['bgcolor'] = bgs[i]
                                    args['fgcolor'] = fgs[i]
                                         
                                _formats.append(args)
                                values[x][y].append(tuple(_formats))
                                
                        # multiple items
                        ''' uncomment if want to generate conflicts report'''
                        #if len(_value) > 1 and conflicts_only == "Y":
                        if len(_value) > 1:
                            for __value in _value:
                                bgs,fgs = _color_get_multi(__value)
                                _formats = []
                                for i in range(len(__value)):
                                    #args = dict(value=__value[i],bgcolor=bgs[i],fgcolor=fgs[i])
                                    args = dict(value=__value[i])
                                    if schema<>None: args['valuetype'] = schema['ztypes'][i]
                                    
                                    if formatson==True:
                                        if formatson==True:
                                            args['bgcolor'] = bgs[i]
                                            args['fgcolor'] = fgs[i]
                                    _formats.append(args)

                                    
                                values[x][y].append(tuple(_formats))
                else:
                    #if x == 0 or y == 0:
                    if x == 0:
                        
                        args = dict(value=_value,bgcolor=colors.black,fgcolor=colors.white)
                        if schema<>None: 
                            #if isinstance(schema['yaxis'],list):
                            args['valuetype'] = schema['yaxis']
                        values[x][y] = args
                    elif y == 0:
                        args = dict(value=_value,bgcolor=colors.black,fgcolor=colors.white)
                        if schema<>None: args['valuetype'] = schema['xaxis']
                        values[x][y] = args
                    else:
                        
                        bg,fg = color_get(_value)
                        #bgs,fgs = _color_get_multi(_value)
                        args = dict(value=_value,bgcolor=bg,fgcolor=fg)
                        if schema<>None: args['valuetype'] = schema['colnames'][y]
                        values[x][y] = args
                
        return values
    
def _lesson_change(lesson,delete=False):

    def _add(obj,xtype,ytype,lesson):
        
        xtype_id = getattr(lesson,xtype).objid
        ytype_id = getattr(lesson,ytype).objid

        if obj.lessons.has_key(xtype_id) == False:
            obj.lessons[xtype_id] = {} 

        if obj.lessons[xtype_id].has_key(ytype_id) == False:
            obj.lessons[xtype_id][ytype_id] = []
           
        # add if this object not already indexed 
        try:
            obj.lessons[xtype_id][ytype_id].index(lesson)
        except ValueError:
            obj.lessons[xtype_id][ytype_id].append(lesson)
            
    def _delete(obj,xtype,ytype,lesson):
        xtype_id = getattr(lesson,xtype).objid
        ytype_id = getattr(lesson,ytype).objid
        try:
            obj.lessons[xtype_id][ytype_id].remove(lesson)
        except:
            pass
        
    source_types = ['adult','student','subject']
    xaxes = yaxes = ['dow','period','recordtype','subject','student','adult']
    
    for source_type in source_types:
        lesson_attr = getattr(lesson,source_type)
        for xaxis in xaxes:
            for yaxis in yaxes:
                if xaxis <> yaxis:
                    if hasattr(lesson_attr,'lessons') == False:
                        setattr(lesson_attr,'lessons',{})
                        
                    if delete==True:
                        _delete(lesson_attr,xaxis,yaxis,lesson)
                    else:
                        _add(lesson_attr,xaxis,yaxis,lesson)
          
def dataset_refdata(database,objtype=None,itemname=None):

    # objtype is set if you dont want all ref data
    # itemname is set if you want the label in xml to not be the name of the objtype
    # this could because the webpage is using this data to create an element and it needs to
    # have a specific name
    _refdata = {}
    
    if objtype==None:
        objtype="all"
        
    if objtype <> "all": 
        
        # so if just doing one not all
        with database:
            _,values,_ = sswizard_query_utils._refexecfunc(database,objtype)
        
        reftype=objtype
        if itemname<>None: # and if itemname is being overridden
            reftype=itemname
            
        _refdata[reftype] = [value[0] for value in values]
        
        return _refdata

    else:
        reftypes = ['subject','student','period','dow','recordtype','adult']
    
    
    with database:
        for reftype in reftypes:
            _,values,_ = sswizard_query_utils._refexecfunc(database,reftype)
            _refdata[reftype] = [value[0] for value in values]

    return _refdata
                
    
def dataset_new(source_type):
    
    if source_type == "lesson":
        cols = ['adult','subject','dow','period','student','recordtype']
    elif source_type == "student":
        cols = ['code','name','prep']
    else:
        cols = ['code','name']
        
    return(dict((col,"") for col in cols))

def dataset_add(database,refdatabase,of,enums,prepmap,datamembers,objtype='lesson',
                keepversion=False):
    '''
    in the datamembers dict needs to come 'period','student','dow','adult','subject','recordtype
    values need to be the names for dow, so 'Monday','Tuesday' etc'''
    _objid = None
    _userobjid = None
    
    if objtype == "lesson":
        
        if (datamembers.has_key('adult') == False and datamembers.has_key('teacher') == True):
            datamembers['adult'] = datamembers['teacher']
            datamembers.pop('teacher')
            
        datamembers['session'] = ".".join([datamembers['adult'],datamembers['subject'],datamembers['dow'],
                                   sswizard_utils._isname(enums,'period',datamembers['period'])])
        
        datamembers['userobjid'] = sswizard_utils._getuserobjid(enums,['period','dow','student','adult','subject'],datamembers)
        
        # check that the userobjid does not already exist
        if of.object_exists('lesson',datamembers['userobjid']) == True:
            raise OFDuplicateRecord("id already in use",datamembers['userobjid'])
        
        datamembers['objtype'] = 'lesson'   
        datamembers['substatus'] = 'complete'
        datamembers['status'] = 'master'
        datamembers['prep'] = int(prepmap[datamembers['student']])
        datamembers['source']="manual"

        #datamembers['saveversion']=1
            
        # switch to code
        datamembers['dow'] = sswizard_utils._iscode(enums,'dow',datamembers['dow'])
        
        lesson = of.new(schoolschedgeneric,'lesson',objid=datamembers['userobjid'],
                             constructor='datamembers',database=database,
                             of=of,modname=__name__,dm=datamembers)
        
        
        _lesson_change(lesson)
        
        log.log(thisfuncname(),10,msg="lesson obj added",objtype=objtype,dm=datamembers)
        
        with database:
            lesson.keepversion=keepversion
            lesson.persist()
            
        return(lesson)
    
    else:
        
        if objtype == "student":
            prepmap[datamembers['name']] = datamembers['prep']
            
        with database:
            _,_obj_count,_ = sswizard_query_utils._rowcount(database,objtype)
            _enum = int(_obj_count[0][0])+1
            
        sswizard_utils._addenum(enums,objtype,datamembers['name'],  datamembers['code'],_enum)  

    if _userobjid == None:
        _userobjid = datamembers['name'] # set the of unique id (use name for all non lesson objects
        
    if _objid == None:
        _objid = datamembers['name']

    datamembers['userobjid'] = _userobjid
    datamembers['enum'] = _enum
    datamembers['objtype'] = objtype 
    
    obj = of.new(schoolschedgeneric,str(objtype),objid=_objid,constructor='datamembers',database=database,
                         of=of,modname=__name__,recursion=False,dm=datamembers)

    log.log(thisfuncname(),10,msg="lesson obj added",objtype=objtype,dm=datamembers)
        
    with database:
        obj.persist()
        
    return(obj)
    
    

def dataset_load(database,refdatabase,of,enums,saveversion=1,unknown='N',prep=-1,period="all",
                 dow="all",teacher="all",student="all",source="dbinsert",keepversion=False):
    
    of.reset()
    
    whereclause = []
    if keepversion==True:
        ''' if versioning enabled make sure to only recover the latest/current version '''
        whereclause = [['__version','=',"\"current\""]]
    
    # saveversion
    log.log(thisfuncname(),3,msg="loading",saveversion=str(saveversion))
    whereclause.append(['saveversion',"=",saveversion])
    
    # unknown
    if unknown=='N':
        whereclause.append(['student',"<>","\"??\""])
        whereclause.append(['subject',"<>","\"??\""])
        whereclause.append(['teacher',"<>","\"??\""])
    log.log(thisfuncname(),3,msg="loading",unknown=str(unknown))
        
    # prep
    if  prep <> -1:
        whereclause.append(['prep',"=",prep])
    log.log(thisfuncname(),3,msg="loading",prep=str(prep))
    
    # period
    if period <> "all":
        whereclause.append(['period',"=","\""+period+"\""])            
    log.log(thisfuncname(),3,msg="loading",prep=str(prep))

    # dow
    if dow <> "all":
        whereclause.append( ['dow',"=","\""+dow+"\""])
    log.log(thisfuncname(),3,msg="loading",dow=str(dow))
    
    # teacher
    if teacher <> "all":
        whereclause.append( ['teacher',"=","\""+teacher+"\""])
    log.log(thisfuncname(),3,msg="loading",teacher=str(teacher))      
    
    # student
    if student <> "all":
        whereclause.append( ['student',"=","\""+student+"\""])
    log.log(thisfuncname(),3,msg="loading",student=str(student))
    
    # source
    #if source <> "dbinsert":
    _sources = ["\"" + _source + "\"" for _source in source.split(",")]
    whereclause.append( ['source',"in","("+",".join(_sources)+")"])
    log.log(thisfuncname(),3,msg="loading",source=str(source))

    # load from database
    #cols = ['period','student','session','dow','prep','teacher','subject','userobjid','status','substatus','recordtype','source','__id','record']        
    cols = ['period','student','session','dow','prep','teacher','subject','userobjid','status','substatus','recordtype','source','__id']        

    with database:
        
        colndefn,rows,exec_str = tbl_rows_get(database,'lesson',cols,whereclause)
    
        log.log(thisfuncname(),9,msg="dbread",exec_str=exec_str)
    
    #cols = ['period','student','session','dow','prep','adult','subject','userobjid','status','substatus','recordtype','source','id','record']
    cols = ['period','student','session','dow','prep','adult','subject','userobjid','status','substatus','recordtype','source','id']
    
    # parse rows
    for row in rows:
        datamembers = {}
        for i in range(len(cols)):
            datamembers[cols[i]] = row[i]
            
        # this is a hack to quickly get a clean lessontype into the server
        datamembers['recordtype'] = datamembers['recordtype'].split(".")[0]
        if datamembers['recordtype'] == "subject": datamembers['recordtype'] = "academic"
            
        _,lessontype_code,_,_ = datamembers['session'].split(".")
        datamembers['objtype'] = 'lesson'                               

        lesson = of.new(schoolschedgeneric,'lesson',objid=datamembers['userobjid'],
                             constructor='datamembers',database=database,
                             of=of,modname=__name__,dm=datamembers)
        
        _lesson_change(lesson)
                        
        log.log(thisfuncname(),3,msg="loading row",dm=datamembers)

    # post log with results
    log.log(thisfuncname(),3,msg="db rows loaded",num=len(rows))        
    for i in range(len(cols)):
        if of.store.has_key(cols[i]):
            log.log(thisfuncname(),3,msg="lesson obj created",num=len(of.store[cols[i]]))
        else:
            log.log(thisfuncname(),3,msg="no records found to be loaded for",record=cols[i])
    

def dataset_loadref(database,refdatabase,of,objtype,saveversion=1,unknown='N',
                    keepversion=False,whereclause=[]):

    # load from database
    cols = ['name','code','enum']
    if objtype == "student":
        cols.append("prep")
        
    with database:
        colndefn,rows,exec_str = tbl_rows_get(database,objtype,cols,whereclause)
        log.log(thisfuncname(),9,msg="dbread",exec_str=exec_str)
    
    # parse rows
    for row in rows:
        datamembers = {}
        for i in range(len(cols)):
            datamembers[cols[i]] = row[i]
        
        datamembers['objtype'] = objtype
        datamembers['userobjid'] = datamembers['name']
        
        obj = of.new(schoolschedgeneric,objtype,objid=datamembers['name'],
                     constructor='datamembers',database=database,
                     of=of,modname=__name__,recursion=False,dm=datamembers)
    
        log.log(thisfuncname(),10,msg="loading row",objtype=objtype,
                dm=datamembers)
        
        #with database:
        #    obj.persist()