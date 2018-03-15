from types import StringType, IntType
from database_util import Database
from database_table_util import tbl_query

__all__ = ["get_basic_student_info","get_basic_teacher_info",
           "get_student_schedule","get_teacher_schedule",
           "get_students_per_class_by_teacher"]

def is_valid_student(student_id):
    return True
def is_valid_teacher(teacher_id):
    return True

def get_basic_student_info(database,student_id=70):
    assert isinstance(student_id,IntType), student_id
    assert is_valid_student(student_id), student_id
    assert isinstance(database,Database), database
    
    sql = _qry_basic_student_info(student_id)
    with database:
        _,results,_ = tbl_query(database,sql)
    
    return results
    
def get_basic_teacher_info(database,teacher_id=30):
    assert isinstance(teacher_id,IntType), teacher_id
    assert is_valid_teacher(teacher_id),teacher_id
    assert isinstance(database,Database), database
    
    sql = _qry_basic_teacher_info(teacher_id)
    with database:
        _,results,_ = tbl_query(database,sql)
    
    return results
    
def get_student_schedule(database,studentid=70,
                         days='"M","T","W","R","F"',
                         periods='1,2,3,4,5,6,7,8,9,11'):
    assert isinstance(studentid,IntType), studentid
    assert is_valid_student(studentid), studentid
    assert isinstance(database,Database), database
    
    sql = _qry_student_schedule(studentid,days,periods)
    with database:
        _,results,_ = tbl_query(database,sql)
        
    return results
    
def get_teacher_schedule(database,teacher_id=3,
                         days='"M","T","W","R","F"',
                         periods='1,2,3,4,5,6,7,8,9,11'):
    assert isinstance(teacher_id,IntType), teacher_id
    assert is_valid_teacher(teacher_id),teacher_id
    assert isinstance(database,Database), database
    
    sql = _qry_teacher_schedule(teacher_id,days,periods)
    with database:
        _,results,_ = tbl_query(database,sql)
        
    return results
        
def get_students_per_class_by_teacher(database,teacher_id=3,
                                      class_ids='22,320'):
    assert isinstance(teacher_id,IntType), teacher_id
    assert is_valid_teacher(teacher_id),teacher_id
    assert isinstance(database,Database), database
    
    sql = _qry_students_per_class_by_teacher(teacher_id,class_ids)
    with database:
        _,results,_ = tbl_query(database,sql)
        
    return results
        
def _qry_basic_student_info(student_id):
    sql = ('select st.sStudentFirstNm, st.sStudentLastNm, st.idStudent, stl.idPrep, pc.sPrepNm '
           'from Student st, StudentLevel stl, PrepCode pc '
           'where st.idStudent = {} and st.cdRowStatus = "act" '
           'and st.idStudent = stl.idStudent and stl.cdRowStatus = "act" and stl.idAcadPeriod = 1 '
           'and stl.idPrep = pc.idPrep and pc.cdRowStatus = "act" ').format(student_id)
    return sql

def _qry_basic_teacher_info(teacher_id):
    sql = ('select f.sFacultyFirstNm, f.sFacultyLastNm, f.idFaculty '
           'from Faculty f '
           'where f.idFaculty = {} '
           'and f.cdRowStatus = "act" '
           'and f.cdEmployeeStatus = "act" ').format(teacher_id)
    return sql
    
def _qry_student_schedule(student_id,days,periods):
    sql = ('select sub.sSubjectLongDesc, c.sCourseNm, cls.sClassFocusArea, '
           '       f.sFacultyFirstNm, dc.cdDay, cl.idTimePeriod, cl.idLocation, '
           '       cl.idSection, ctc.cdClassType, s.iFreq, cl.idClassLecture '
           'from ClassLectureStudentEnroll cls, ClassLecture cl, DayCode dc, '
           '     Section s, Course c, Subject sub, Faculty f, ClassTypeCode ctc '
           'where cls.idStudent = {} and cls.cdRowStatus = "act" '
           'and dc.cdDay in ({}) '
           'and cl.idTimePeriod in ({}) '
           'and cls.idClassLecture = cl.idClassLecture and cl.cdRowStatus = "act" '
           'and cl.idDay = dc.idDay and dc.cdRowStatus = "act" '
           'and cl.idSection = s.idSection and s.cdRowStatus = "act" '
           'and s.idCourse = c.idCourse and c.cdRowStatus = "act" '
           'and s.idSubject = sub.idSubject and sub.cdRowStatus = "act" '
           'and s.idLeadTeacher = f.idFaculty and f.cdRowStatus = "act" '
           'and s.idClassType = ctc.idClassType and ctc.cdRowStatus = "act" '
           'order by cl.idDay, cl.idTimePeriod ').format(student_id,days,periods)
    return sql

def _qry_teacher_schedule(teacher_id,days,periods):
    sql = ('select sub.sSubjectLongDesc, c.sCourseNm, f.sFacultyFirstNm, dc.cdDay, '
           '       cl.idTimePeriod, cl.idLocation, cl.idSection, ctc.cdClassType, '
           '       s.iFreq, cl.idClassLecture '
           'from ClassLectureFacultyEnroll clf, ClassLecture cl, DayCode dc, Section s, Course c, '
           'Subject sub, Faculty f, ClassTypeCode ctc '
           'where clf.idFaculty = {} and clf.cdRowStatus = "act" '
           'and dc.cdDay in ({}) '
           'and cl.idTimePeriod in ({}) '
           'and clf.idClassLecture = cl.idClassLecture and cl.cdRowStatus = "act" '
           'and cl.idDay = dc.idDay and dc.cdRowStatus = "act" '
           'and cl.idSection = s.idSection and s.cdRowStatus = "act" '
           'and s.idCourse = c.idCourse and c.cdRowStatus = "act" '
           'and s.idSubject = sub.idSubject and sub.cdRowStatus = "act" '
           'and s.idLeadTeacher = f.idFaculty and f.cdRowStatus = "act" '
           'and s.idClassType = ctc.idClassType and ctc.cdRowStatus = "act" '
           'order by cl.idDay, cl.idTimePeriod ').format(teacher_id,days,periods)
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
