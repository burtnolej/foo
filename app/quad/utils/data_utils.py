from types import StringType, IntType, ListType
from utils.database.database_util import Database
from utils.database.database_table_util import tbl_query

__all__ = ["get_basic_student_info","get_basic_teacher_info",
           "get_student_schedule","get_teacher_schedule",
           "get_students_per_class_by_teacher",
           "get_all_basic_student_info","get_all_basic_teacher_info",
           "get_all_basic_course_info","get_basic_course_info",
           "get_all_basic_subject_info","get_basic_subject_info",
           "get_all_basic_prep_info","get_all_basic_timeperiod_info",
           "get_all_basic_day_info"]

def is_valid_course(course_id):
    return True
def is_valid_subject(subject_id):
    return True

def is_valid_student(student_id):
    return True
def is_valid_teacher(teacher_id):
    return True

def get_all_basic_student_info(database):
    return get_basic_student_info(database, allstudents=True)

def get_basic_student_info(database,students=[70],allstudents=False):
    assert isinstance(students,ListType), students
    assert is_valid_student(students), students
    assert isinstance(database,Database), database
    
    sql = _qry_basic_student_info(students,allstudents)
    with database:
        columns,results,_ = tbl_query(database,sql)
    
    return columns,results

def get_all_basic_teacher_info(database):
    return get_basic_teacher_info(database,allteachers=True)
    
def get_basic_teacher_info(database,teachers=[30],allteachers=False):
    assert isinstance(teachers,ListType), teachers
    assert is_valid_teacher(teachers),teachers
    assert isinstance(database,Database), database
    
    sql = _qry_basic_teacher_info(teachers,allteachers)
    with database:
        columns,results,_ = tbl_query(database,sql)
    
    return columns,results

def get_all_basic_prep_info(database):
    assert isinstance(database,Database), database
    
    sql = _qry_prep_info()
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def get_all_basic_timeperiod_info(database):
    assert isinstance(database,Database), database
    
    sql = _qry_timeperiod_info()
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def get_all_basic_day_info(database):
    assert isinstance(database,Database), database
    
    sql = _qry_day_info()
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def get_all_basic_course_info(database):
    return get_basic_course_info(database,allcourses=True)
    
def get_basic_course_info(database,courses=[1],allcourses=False):
    assert isinstance(courses,ListType), courses
    assert is_valid_course(courses),courses
    assert isinstance(database,Database), database
    
    sql = _qry_course_info(courses,allcourses)
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def get_all_basic_subject_info(database):
    return get_basic_subject_info(database,allsubjects=True)
    
def get_basic_subject_info(database,subjects=[1],allsubjects=False):
    assert isinstance(subjects,ListType), subjects
    assert is_valid_course(subjects),subjects
    assert isinstance(database,Database), subjects
    
    sql = _qry_subject_info(subjects,allsubjects)
    with database:
        columns,results,_ = tbl_query(database,sql)
    return columns,results

def get_student_schedule(database,students=[70],
                         days=['"M"','"T"','"W"','"R"','"F"'],
                         periods=[1,2,3,4,5,6,7,8,9,11]):
    assert isinstance(students,ListType), students
    assert is_valid_student(students), students
    assert isinstance(database,Database), database
    
    sql = _qry_student_schedule(students,days,periods)
    with database:
        columns,results,_ = tbl_query(database,sql)
        
    return columns,results
    
def get_teacher_schedule(database,teachers=[3],
                         days=['"M"','"T"','"W"','"R"','"F"'],
                         periods=[1,2,3,4,5,6,7,8,9,11]):
    assert isinstance(teachers,ListType), teachers
    assert is_valid_teacher(teachers),teachers
    assert isinstance(database,Database), database
    
    sql = _qry_teacher_schedule(teachers,days,periods)
    with database:
        columns,results,_ = tbl_query(database,sql)
        
    return columns,results
        
def get_students_per_class_by_teacher(database,teacher_id=3,
                                      class_ids='22,320'):
    assert isinstance(teacher_id,IntType), teacher_id
    assert is_valid_teacher(teacher_id),teacher_id
    assert isinstance(database,Database), database
    
    sql = _qry_students_per_class_by_teacher(teacher_id,class_ids)
    with database:
        columns,results,_ = tbl_query(database,sql)
        
    return columns,results


def _qry_day_info():
    sql = ('select idDay,sDayDesc,cdDay '
           'from DayCode '
           ' where cdRowStatus = "act" ')
    return sql

def _qry_timeperiod_info():
    sql = ('select idTimePeriod, dtPeriodStart, dtPeriodEnd '
           'from TimePeriodCode '
           ' where cdRowStatus = "act" ')
    return sql

def _qry_prep_info():
    sql = ('select idPrep, sPrepNm '
           'from PrepCode '
           ' where cdRowStatus = "act" ')
    return sql

def _qry_subject_info(subjects,allsubjects=False):
    sql = ('select sSubjectLongDesc,idSubject '
           'from Subject '
           ' where cdRowStatus = "act" ')
           
    if not allsubjects:
        sql = sql + ('and idSubject in ({}) ').format(",".join(map(str,subjects)))
    return sql
           
def _qry_course_info(courses,allcourses=False):
    sql = ('select sCourseNm,idCourse,idSubject '
           'from Course '
           ' where cdRowStatus = "act" ')
    
    if not allcourses:
        sql = sql + ('and idCourse in ({}) ').format(",".join(map(str,courses)))
    return sql

def _qry_basic_student_info(students,allstudents=False):
    sql = ('select st.sStudentFirstNm, st.sStudentLastNm, st.idStudent, stl.idPrep, pc.sPrepNm '
           'from Student st, StudentLevel stl, PrepCode pc '
           'where st.cdRowStatus = "act" ')
    
    if not allstudents:
        sql = sql + ('and st.idStudent in ({}) ').format(",".join(map(str,students)))
    
    sql = sql + ('and st.idStudent = stl.idStudent and stl.cdRowStatus = "act" and stl.idAcadPeriod = 1 '                 
           'and stl.idPrep = pc.idPrep and pc.cdRowStatus = "act" ')
    return sql

def _qry_basic_teacher_info(teachers,allteachers=False):
    sql = ('select f.sFacultyFirstNm, f.sFacultyLastNm, f.idFaculty '
           'from Faculty f '
           'where f.cdRowStatus = "act" ')
    
    if not allteachers:
        sql = sql + ('and f.idFaculty in ({}) ').format(",".join(map(str,teachers)))
        
    sql = sql + ('and f.cdEmployeeStatus = "act" ')
    return sql
    
def _qry_student_schedule(students,days,periods):
    sql = ('select sub.sSubjectLongDesc, c.sCourseNm, cls.sClassFocusArea, '
           '       f.sFacultyFirstNm, dc.cdDay, cl.idTimePeriod, cl.idLocation, '
           '       cl.idSection, ctc.cdClassType, s.iFreq, cl.idClassLecture '
           'from ClassLectureStudentEnroll cls, ClassLecture cl, DayCode dc, '
           '     Section s, Course c, Subject sub, Faculty f, ClassTypeCode ctc '
           'where cls.idStudent in ({}) and cls.cdRowStatus = "act" '
           'and dc.cdDay in ({}) '
           'and cl.idTimePeriod in ({}) '
           'and cls.idClassLecture = cl.idClassLecture and cl.cdRowStatus = "act" '
           'and cl.idDay = dc.idDay and dc.cdRowStatus = "act" '
           'and cl.idSection = s.idSection and s.cdRowStatus = "act" '
           'and s.idCourse = c.idCourse and c.cdRowStatus = "act" '
           'and s.idSubject = sub.idSubject and sub.cdRowStatus = "act" '
           'and s.idLeadTeacher = f.idFaculty and f.cdRowStatus = "act" '
           'and s.idClassType = ctc.idClassType and ctc.cdRowStatus = "act" '
           'order by cl.idDay, cl.idTimePeriod ').format(",".join(map(str,students)),",".join(map(str,days)),",".join(map(str,periods)))
    return sql

def _qry_teacher_schedule(teachers,days,periods):
    sql = ('select sub.sSubjectLongDesc, c.sCourseNm, f.sFacultyFirstNm, dc.cdDay, '
           '       cl.idTimePeriod, cl.idLocation, cl.idSection, ctc.cdClassType, '
           '       s.iFreq, cl.idClassLecture '
           'from ClassLectureFacultyEnroll clf, ClassLecture cl, DayCode dc, Section s, Course c, '
           'Subject sub, Faculty f, ClassTypeCode ctc '
           'where clf.idFaculty = ({}) and clf.cdRowStatus = "act" '
           'and dc.cdDay in ({}) '
           'and cl.idTimePeriod in ({}) '
           'and clf.idClassLecture = cl.idClassLecture and cl.cdRowStatus = "act" '
           'and cl.idDay = dc.idDay and dc.cdRowStatus = "act" '
           'and cl.idSection = s.idSection and s.cdRowStatus = "act" '
           'and s.idCourse = c.idCourse and c.cdRowStatus = "act" '
           'and s.idSubject = sub.idSubject and sub.cdRowStatus = "act" '
           'and s.idLeadTeacher = f.idFaculty and f.cdRowStatus = "act" '
           'and s.idClassType = ctc.idClassType and ctc.cdRowStatus = "act" '
           'order by cl.idDay, cl.idTimePeriod ').format(",".join(map(str,teachers)),",".join(map(str,days)),",".join(map(str,periods)))
    return sql

def _qry_students_per_class_by_teacher(teacher_id,class_ids):
    sql = ('select cls.idClassLecture, st.sStudentFirstNm, st.sStudentLastNm, c.sCourseNm, '
           'cls.sClassFocusArea, dc.cdDay, cl.idTimePeriod, '
           'cl.idLocation, cl.idSection, ctc.cdClassType, s.iFreq, cl.idClassLecture '
           'from ClassLectureStudentEnroll cls, ClassLecture cl, DayCode dc, Section s, Course c, '
           'Subject sub, Student st, ClassTypeCode ctc '
           'where cls.idClassLecture in ({}) and cls.cdRowStatus = "act" '
           'and cls.idClassLecture = cl.idClassLecture and cl.cdRowStatus = "act" '
           'and cl.idDay = dc.idDay and dc.cdRowStatus = "act" '
           'and cl.idSection = s.idSection and s.cdRowStatus = "act" '
           'and s.idCourse = c.idCourse and c.cdRowStatus = "act" '
           'and s.idSubject = sub.idSubject and sub.cdRowStatus = "act" '
           'and cls.idStudent = st.idStudent and st.cdRowStatus = "act" '
           'and s.idClassType = ctc.idClassType and ctc.cdRowStatus = "act" '
           'order by cl.idClassLecture, cl.idDay, cl.idTimePeriod ').format(class_ids)
    return sql
