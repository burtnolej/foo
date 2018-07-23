from types import StringType, IntType, ListType
from utils.database.database_util import Database
from utils.database.database_table_util import tbl_query, tbl_rows_insert, tbl_row_delete, _quotestrs, tbl_rows_update,tbl_cols_get
from datetime import datetime
from app.quad.utils.data_utils import delete_studentlevel, is_valid_student, is_valid_teacher, is_valid_section, _filter_data, _construct_record, get_all_student, get_all_subject,get_all_course,get_all_day,get_all_timeperiod,get_all_prep,get_all_studentlevel,get_all_teacher,get_all_classtypecode, delete_student, delete_teacher, delete_course, delete_subject, get_teacher, get_course, get_subject, get_studentlevel
import sys
from collections import OrderedDict

__all__ = ["get_student_schedule_v2", "insert_section_schedule","_insert_section_schedule",
           "delete_section_schedule","get_schedule_lesson_v2", 
           "get_all_section_v2","get_section_v2", 
           "get_sections_to_explode","get_max_section_schedule", 
           "_insert_section_schedule_faculty","_insert_section_schedule_student"]

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
    update_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S") # 20180301 18:37
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
    update_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S") # 20180301 18:37
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


def insert_section(database,rows,
                          columns=["idSectionSched","idDay","idTimePeriod","idSection",
                                   "idlocation"]):
    
    mandatory_columns = ["idSectionSched","idDay","idTimePeriod"]
    update_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S") # 20180301 18:37
    username="butlerj"
    pk=["idStudent","cdRowStatus"]

    #dtclassstart="NOTSET"
    #dtclassend="NOTSET"
    idsectionprep=0
    cdsectionschedstatus="NOTSET"

    table = {"idSection":["INTEGER",-1],
             "idAcadPeriod":["INTEGER",-1],
             "idCourse":["INTEGER",-1],
             "idSubject":["INTEGER",-1],
             "idClassType":["INTEGER",-1],
             "idLeadTeacher":["INTEGER",-1],
             "iFreq":["INTEGER",-1],
             "sFreqUnit":["TEXT","\"week\""],
             "iMaxCapacity":["INTEGER",-1],
             "dtSectionStart":["TEXT",-1],
             "dtSectionEnd":["TEXT",-1],
             "cdSectionStatus":["TEXT","\"act\""],
             "cdSectionGroup":["TEXT",-1],
             "idSectionPrep":["INTEGER",-1],
             "cdRowStatus":["TEXT","\"act\""],
             "dtAdd":["TEXT","\""+update_time+"\""],
             "dtLastUpd":["TEXT","\""+update_time+"\""],
             "sAddUserNm":["TEXT","\""+username+"\""],
             "sLastUpdUserNm":["TEXT","\""+username+"\""],
             "lStudentEnroll":["TEXT",-1],
             "lFacultyEnroll":["TEXT",-1]}


    if columns != mandatory_columns:
        rows,columns = _filter_data(rows,columns,table)

    required_rows,columns = _construct_record(table,rows,columns)

    with database:
        #required_rows = _quotestrs(required_rows)
        tbl_rows_insert(database,"Section",columns,required_rows)

def _insert_section_schedule(database,rows,
                          columns=["idSectionSched","idDay","idTimePeriod","idSection",
                                   "idlocation"]):

    mandatory_columns = ["idSectionSched","idDay","idTimePeriod"]
    update_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S") # 20180301 18:37
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

def delete_section(database,sections):
    for idsection in sections:
        with database:
            tbl_row_delete(database,"Section",[["idSection","=",idsection]])
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


def _qry_schedule_lesson_v2(students,days,periods,allschedulelessons=False):

    sql = ('select cls.idStudent, f.idFaculty, cl.idSection, cl.idLocation, dc.idDay, cl.idTimePeriod, cl.idSectionSched '
        'from SectionScheduleStudent cls, SectionSchedule cl, DayCode dc,Faculty f,Section s '
      
        'where dc.idDay in ({}) '
        'and cl.idTimePeriod in ({}) '
        'and cls.cdRowStatus = "act" '
        'and cl.cdRowStatus = "act" '
        'and dc.cdRowStatus = "act" '
        'and f.cdRowStatus = "act" '
        'and s.cdRowStatus = "act" '
        'and cls.idSectionSched = cl.idSectionSched '
        'and cl.idDay = dc.idDay '
        'and cl.idSection = s.idSection '
        'and s.idLeadTeacher = f.idFaculty ').format(",".join(map(str,days)),",".join(map(str,periods)))
    
    if not allschedulelessons:
        sql = sql + ('and  cls.idStudent in ({}) ').format(",".join(map(str,students)))
    
    return sql


'''
def _qry_schedule_lesson_v2(students,days,periods):
    sql = ('select cls.idStudent, f.idFaculty, cl.idSection, cl.idLocation, dc.idDay, cl.idTimePeriod, cl.idSectionSched '
        'from SectionScheduleStudent cls, SectionSchedule cl, DayCode dc,Faculty f,Section s '
        'where cls.idStudent in ({}) '
        'and dc.idDay in ({}) '
        'and cl.idTimePeriod in ({}) '
        'and cls.cdRowStatus = "act" '
        'and cl.cdRowStatus = "act" '
        'and dc.cdRowStatus = "act" '
        'and f.cdRowStatus = "act" '
        'and s.cdRowStatus = "act" '
        'and cls.idSectionSched = cl.idSectionSched '
        'and cl.idDay = dc.idDay '
        'and cl.idSection = s.idSection '
        'and s.idLeadTeacher = f.idFaculty ').format(",".join(map(str,students)),",".join(map(str,days)),",".join(map(str,periods)))
    
    return sql
'''

def get_schedule_lesson_v2(database,students=[70],
                        days=[1,2,3,4,5],
                        periods=[1,2,3,4,5,6,7,8,9,10,11]):
    assert isinstance(students,ListType), students
    assert is_valid_student(students), students
    assert isinstance(database,Database), database
    allschedulelessons = False

    if students == [0]:
        allschedulelessons=True
    sql = _qry_schedule_lesson_v2(students,days,periods,allschedulelessons)
    with database:
        columns,results,_ = tbl_query(database,sql)

    return columns,results

def get_all_section_v2(database):
    return get_section_v2(database,allsections=True)

def get_course_v2(database,courses,allcourses=False):
    return get_course(database,courses,allcourses)

def get_subject_v2(database,subjects,allsubjects=False):
    return get_subject(database,subjects,allsubjects)

def get_sections_to_explode(database):
    sql = ('select idSection,idCourse,idSubject,idClassType, '
           'idLeadTeacher,lStudentEnroll,lFacultyEnroll, '
           'iFreq,iMaxCapacity '
           'from Section where idAcadPeriod = 2' )
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def get_max_section_schedule(database):
    sql = ('select max(idSectionSched) '
           'from SectionSchedule ')
    with database:
        columns,results,_ = tbl_query(database,sql)
    return results[0][0]

def get_section_v2(database,sections=[700],allsections=False):
    assert isinstance(sections,ListType), sections
    assert is_valid_section(sections),sections
    assert isinstance(database,Database), database
    
    sql = _qry_section_v2(sections,allsections)
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def _qry_section_v2(sections,allsections=False):
    
    sql = ('select  idSection, idAcadPeriod, idCourse, idSubject,  '
        'idClassType,idLeadTeacher, '
        'iFreq,sFreqUnit,iMaxCapacity,dtSectionStart,dtSectionEnd,  '
        'cdSectionGroup,idSectionPrep,lStudentEnroll,lFacultyEnroll '
        'from Section  '
        'where cdRowStatus = "act" ')
        
    if not allsections:
        sql = sql + ('and idSection in ({}) ').format(",".join(map(str,sections)))
    return sql

def get_all_student_v2(database):
    return get_all_student(database)

def get_all_teacher_v2(database):
    return get_teacher_v2(database,allteachers=True)

#def get_teacher_v2(database,teachers,allteachers=False):
#    return get_teacher(database,teachers,allteachers)

def get_all_prep_v2(database):
    return get_all_prep(database)

def get_studentlevel_v2(database,studentlevels):
    return get_studentlevel(database,studentlevels)

def get_all_studentlevel_v2(database):
    return get_all_studentlevel(database)

def get_all_timeperiod_v2(database):
    return get_all_timeperiod(database)

def get_all_day_v2(database):
    return get_all_day(database)

def get_all_course_v2(database):
    return get_all_course(database)
def get_all_classtypecode_v2(database):
    return get_all_classtypecode(database)
def get_all_subject_v2(database):
    return get_all_subject(database)
def delete_student_v2(database,students):
    delete_student(database,students)
    return [],[]
def delete_studentlevel_v2(database,studentlevels,idacadperiods=[1]):
    students=studentlevels
    delete_studentlevel(database,students,idacadperiods)
    return [],[]

def delete_teacher_v2(database,teachers):
    delete_teacher(database,teachers)
    return [],[]
def delete_course_v2(database,courses):
    delete_course(database,courses)
    return [],[]
def delete_subject_v2(database,subjects):
    delete_subject(database,subjects)
    return [],[]


def get_all_student_v2(database):
    return get_student_v2(database, allstudents=True)

def get_student_v2(database,students=[70],allstudents=False):
    assert isinstance(students,ListType), students
    assert is_valid_student(students), students
    assert isinstance(database,Database), database
    
    sql = _qry_student_v2(students,allstudents)
    with database:
        columns,results,_ = tbl_query(database,sql)
    
    return columns,results

def get_teacher_v2(database,teachers=[30],allteachers=False):
    assert isinstance(teachers,ListType), teachers
    assert is_valid_teacher(teachers),teachers
    assert isinstance(database,Database), database
    
    sql = _qry_teacher_v2(teachers,allteachers)
    with database:
        columns,results,_ = tbl_query(database,sql)
    
    return columns,results

def _qry_student_v2(students,allstudents=False):
    sql = ('select st.sStudentFirstNm, st.sStudentLastNm, st.idStudent, stl.idPrep, stl.iGradeLevel, pc.sPrepNm, stl.idAcadPeriod,st.sStudentFullName  '
           'from Student st, StudentLevel stl, PrepCode pc '
           'where st.cdRowStatus = "act" ')
    
    if not allstudents:
        sql = sql + ('and st.idStudent in ({}) ').format(",".join(map(str,students)))
    
    sql = sql + ('and st.idStudent = stl.idStudent and stl.cdRowStatus = "act" '                 
           'and stl.idPrep = pc.idPrep and pc.cdRowStatus = "act" ')

    # 7/2/18 removed the idAcadPeriod pred
    #sql = sql + ('and st.idStudent = stl.idStudent and stl.cdRowStatus = "act" and stl.idAcadPeriod = 1 '                 
    #       'and stl.idPrep = pc.idPrep and pc.cdRowStatus = "act" ')
    return sql


def _qry_teacher_v2(teachers,allteachers=False):
    sql = ('select f.sFacultyFirstNm, f.sFacultyLastNm, f.idFaculty, f.sFacultyFullName '
           'from Faculty f '
           'where f.cdRowStatus = "act" ')
    
    if not allteachers:
        sql = sql + ('and f.idFaculty in ({}) ').format(",".join(map(str,teachers)))
        
    sql = sql + ('and f.cdEmployeeStatus = "act" ')
    return sql


''' ----- STUDENT [INSERT]-----  '''

def insert_student_v2(database,rows,
                              columns=["idStudent","sStudentFirstNm","sStudentLastNm","idPrep"], 
                              username="butlerj"):
    _insert_student(database,rows,columns) 
    _insert_student_level_v2(database,rows,columns)
    return [],[]
        
        
def _insert_studentlevel_v2(database,rows,columns=["idStudent","idAcadPeriod","idPrep","iGradeLevel","dtPrepStart","dtPrepEnd","sStudentLevelNote"]):
    
    mandatory_columns = ["idStudent","idAcadPeriod","iGradeLevel"]
    update_time = datetime.now().strftime("%Y%m%d %H:%M") # 20180301 18:37
    username="butlerj"
    pk=["idStudent","cdRowStatus"]
    table = {"idStudent":["INTEGER",-1],
             "idAcadPeriod":["INTEGER",-1],
             "idPrep":["INTEGER",-1],
             "iGradeLevel":["INTEGER",-1],
             "dtPrepStart":["TEXT",-1],
             "dtPrepEnd":["TEXT",-1],
             "sStudentLevelNote":["TEXT","\"NOTSET\""]
             }

    if columns != mandatory_columns:
        rows,columns = _filter_data(rows,columns,table)
        
    required_rows,columns = _construct_record(table,rows,columns)
    
    with database:
        tbl_rows_insert(database,"StudentLevel",columns,required_rows)
        
        
        
def _qry_timeperiod_v2():
    sql = ('select idTimePeriod, dtPeriodStart, dtPeriodEnd, sTimePeriodLabel, idAcadPeriod '
           'from TimePeriodCode '
           ' where cdRowStatus = "act" ')
    return sql        


def get_all_timeperiod_v2(database):
    assert isinstance(database,Database), database
    
    sql = _qry_timeperiod_v2()
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results