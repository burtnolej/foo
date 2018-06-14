from types import StringType, IntType, ListType
from utils.database.database_util import Database
from utils.database.database_table_util import tbl_query, tbl_rows_insert, tbl_row_delete, _quotestrs, tbl_rows_update,tbl_cols_get
from datetime import datetime
from app.quad.utils.data_utils import is_valid_student, _filter_data, _construct_record
import sys
from collections import OrderedDict

__all__ = ["get_student_schedule_v2", "insert_section_schedule",
           "delete_section_schedule"]


''' ----- STUDENT SCHEDULE [GET] ----- '''
def get_student_schedule_v2(database,students=[70],
                         days=['"M"','"T"','"W"','"R"','"F"'],
                         periods=[1,2,3,4,5,6,7,8,9,10,11]):
    assert isinstance(students,ListType), students
    assert is_valid_student(students), students
    assert isinstance(database,Database), database

    sql = _qry_student_schedule_v2(students,days,periods)
    with database:
        columns,results,_ = tbl_query(database,sql)

    return columns,results

def _qry_student_schedule_v2(students,days,periods):
    
    sql = ('select sub.sSubjectLongDesc, c.sCourseNm, cls.sLectureFocusArea, '
           '       f.sFacultyFirstNm, dc.cdDay, cl.idTimePeriod, cl.idLocation, '
           'cl.idSection, ctc.cdClassType, s.iFreq, cl.idSectionSched '
           

        'from SectionScheduleStudent cls, SectionSchedule cl, DayCode dc,  '
        '    Section s, Course c, Subject sub, Faculty f, ClassTypeCode ctc  '
        'where cls.idStudent in ({}) and cls.cdRowStatus = "act"  '
        'and dc.cdDay in ({}) '
        'and cl.idTimePeriod in ({})  '
        'and cls.idSectionSched = cl.idSectionSched and cl.cdRowStatus = "act"  '
        'and cl.idDay = dc.idDay and dc.cdRowStatus = "act"  '
        'and cl.idSection = s.idSection and s.cdRowStatus = "act" ' 
        'and s.idCourse = c.idCourse and c.cdRowStatus = "act"  '
        'and s.idSubject = sub.idSubject and sub.cdRowStatus = "act"  '
        'and s.idLeadTeacher = f.idFaculty and f.cdRowStatus = "act"  '
        'and s.idClassType = ctc.idClassType and ctc.cdRowStatus = "act" '
        'order by cl.idDay, cl.idTimePeriod ').format(",".join(map(str,students)),",".join(map(str,days)),",".join(map(str,periods)))
    return sql
''' ----- END STUDENT SCHEDULE ----- '''

''' ----- SCHEDULE LESSON [INSERT] ----- '''
def insert_section_schedule(database,rows,
                           columns=["idSectionSchedule","idStudent","idFaculty","idDay","idTimePeriod","idSection",
                                    "idLocation"], 
                              username="butlerj"):
    _insert_section_schedule_student(database,rows,columns) 
    _insert_section_schedule_faculty(database,rows,columns)
    _insert_section_schedule(database,rows,columns)
    return [],[]

def _insert_section_schedule_student(database,rows,
                                         columns=["idSectionSchedule","idStudent"]):

    mandatory_columns = ["idSectionSchedule","idStudent"]
    update_time = datetime.now().strftime("%Y%m%d %H:%M") # 20180301 18:37
    class_focus_area = "NOTSET"
    username="butlerj"
    dtenroll = datetime.now().strftime("%Y%m%d") # 20180301

    table = {"idSectionSched":["INTEGER",-1],
             "idStudent":["INTEGER",-1],
             "dtEnrollStart":["TEXT","\""+dtenroll+"\""],
             "dtEnrollEnd":["TEXT","\"NOTSET\""],
             "sLectureFocusArea":["TEXT","\"NOTSET\""],
             "cdRowStatus":["TEXT","\"act\""],
             "dtAdd":["TEXT","\""+update_time+"\""],
             "dtLastUpd":["TEXT","\""+update_time+"\""],
             "sAddUserNm":["TEXT","\""+username+"\""],
             "sLastUpdUserNm":["TEXT","\""+username+"\""]}

    if columns != mandatory_columns:
        rows,columns = _filter_data(rows,columns,table)

    required_rows,columns = _construct_record(table,rows,columns)

    with database:
        tbl_rows_insert(database,"SectionScheduleStudent",columns,required_rows)

def _insert_section_schedule_faculty(database,rows,
                                     columns=["idSectionSched","idFaculty"]):

    mandatory_columns = ["idFaculty","idSectionSched"]
    update_time = datetime.now().strftime("%Y%m%d %H:%M") # 20180301 18:37
    username="butlerj"
    pk=["idStudent","cdRowStatus"]
    dtenroll = datetime.now().strftime("%Y%m%d") # 20180301
    table = {"idSectionSched":["INTEGER",-1],
             "idFaculty":["INTEGER",-1],
             "dtEnrollStart":["TEXT","\""+dtenroll+"\""],
             "dtEnrollEnd":["TEXT","\"NOTSET\""],
             "cdRowStatus":["TEXT","\"act\""],
             "dtAdd":["TEXT","\""+update_time+"\""],
             "dtLastUpd":["TEXT","\""+update_time+"\""],
             "sAddUserNm":["TEXT","\""+username+"\""],
             "sLastUpdUserNm":["TEXT","\""+username+"\""]}

    if columns != mandatory_columns:
        rows,columns = _filter_data(rows,columns,table)

    required_rows,columns = _construct_record(table,rows,columns)

    with database:
        #required_rows = _quotestrs(required_rows)
        tbl_rows_insert(database,"SectionScheduleFaculty",columns,required_rows)

def _insert_section_schedule(database,rows,
                          columns=["idSectionSched","idDay","idTimePeriod","idSection",
                                   "idlocation"]):

    mandatory_columns = ["idSectionSched","idDay","idTimePeriod"]
    update_time = datetime.now().strftime("%Y%m%d %H:%M") # 20180301 18:37
    username="butlerj"
    pk=["idStudent","cdRowStatus"]

    dtclassstart="NOTSET"
    dtclassend="NOTSET"
    idacademicperiod=0
    cdsectionschedstatus="NOTSET"

    table = {"idSectionSched":["INTEGER",-1],
             "idSection":["INTEGER",-1],
             "idAcadPeriod":["TEXT","\""+str(idacademicperiod)+"\""],
             "idDay":["TEXT",-1],
             "idTimePeriod":["TEXT",-1],
             "idLocation":["TEXT",-1],
             "dtLectureStart":["TEXT","\""+dtclassstart+"\""],
             "dtLectureEnd":["TEXT","\""+dtclassend+"\""],
             "cdSectionSchedStatus":["TEXT","\""+cdsectionschedstatus+"\""],
             "cdRowStatus":["TEXT","\"act\""],
             "dtAdd":["TEXT","\""+update_time+"\""],
             "dtLastUpd":["TEXT","\""+update_time+"\""],
             "sAddUserNm":["TEXT","\""+username+"\""],
             "sLastUpdUserNm":["TEXT","\""+username+"\""]}


    if columns != mandatory_columns:
        rows,columns = _filter_data(rows,columns,table)

    required_rows,columns = _construct_record(table,rows,columns)

    with database:
        #required_rows = _quotestrs(required_rows)
        tbl_rows_insert(database,"SectionSchedule",columns,required_rows)
        
        
def delete_section_schedule(database,sectionschedules):
    _delete_section_schedule_student(database,sectionschedules) 
    _delete_section_schedule_teacher(database,sectionschedules)
    _delete_section_schedule(database,sectionschedules)

    return [],[]

def _delete_section_schedule_student(database,sectionschedules,allsectionschedules=False):
    for idsectionschedule in sectionschedules:
        with database:
            tbl_row_delete(database,"SectionScheduleStudent",[["idSectionSched","=",idsectionschedule]])

def _delete_section_schedule_teacher(database,sectionschedules,allsectionschedules=False):
    for idsectionschedule in sectionschedules:
        with database:
            tbl_row_delete(database,"SectionScheduleFaculty",[["idSectionSched","=",idsectionschedule]])
            
def _delete_section_schedule(database,sectionschedules,allsectionschedules=False):
    for idsectionschedule in sectionschedules:
        with database:
            tbl_row_delete(database,"SectionSchedule",[["idSectionSched","=",idsectionschedule]])
