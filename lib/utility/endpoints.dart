class API_URL {
  //الرابط الاساسي
  static const String ROOT = "http://schoolasasystem.runasp.net/api";
  //  static const String ROOT = "https://dummyjson.com";
  //روابط الapi

  static const String LOGIN = "$ROOT/Auth/token";
  static const String Grads = "$ROOT/users";
  
  static const String CLASSES = "$ROOT/Classes";
  static const String HOMEWORK_DELETE = "$ROOT/HomeWorks/Delete";
  static const String REINFORCEMENTLESSO_DELETE = "$ROOT/Reinforcementlessons/Delete";
  static const String STUDENT_DELETE = "$ROOT/StudentQeustions/Delete";
  static const String SOLUTION_DEGREE = "$ROOT/Solutions/update";
  static const String SUBJECTS = "$ROOT/Subjects/GetSubjectBylevelId";
  static const String SUBJECTS_BY_LIVLEID = "$ROOT/SublectClasses/GetByClassId";
  static const String STUDENT_SOLUTION = "$ROOT/Solutions/Create";
  static const String STUDENT_SUGGESTION_CREATE = "$ROOT/StudentSuggestions";
  static const String STUDENT_QEUSTIONS = "$ROOT/StudentQeustions/Create";
  static const String STUDENT_DEGREES_BY_STUDENT =
      "$ROOT/StudentDegrees/GetByStudentIdandDegreeTypeId";
  static const String TEACHER_CLASSES = "$ROOT/SublectClasses/GetByTeacherId";
  static const String HOMEWORK_BY_CLASS = "$ROOT/HomeWorks/GetBySubjectClassId";
  static const String HOMEWORK_BY_CREATE = "$ROOT/HomeWorks/Create";
  static const String TEACHER_REPLAY = "$ROOT/TeacherAnswers/create";
  static const String STUDENT_DEGREES_EIDT = "$ROOT/StudentDegrees/Edit";
  static const String TEACHER_ATTENDENT_POST = "$ROOT/TeacherAttendances";
  static const String TEACHER_ATTENDET_BY_MANGER =
      "$ROOT/TeacherAttendances/prepareTeacherforattendance";
  static const String STUDENT_ATTENDENT = "$ROOT/Students/GetStudentByClassId";
  static const String STUDENT_BY_PAERNT = "$ROOT/Students/GetStudentByParentId";
  static const String TEACHER_EAVLUATION =
      "$ROOT/TeacherEvaluations/GetAllwithnameAsync";
  static const String STUDENT_ATTENDENT_BY_PAERNT =
      "$ROOT/StudentAttendances/GetAllBySoneIdAsync";
  static const String BOOK_LAIBRY = "$ROOT/LibraryBooks/GetBySectionId";
  static const String SECTION_GET = "$ROOT/Sections/GetAll";
  static const String STUDENT_TABLE = "$ROOT/ClassTimeTables/GetByClassId";
  static const String TEACHER_EAVLUATION_BY_STUDENT =
      "$ROOT/TeacherEvaluations/update";

  static const String STUDENT_FOLLOW_UP =
      "$ROOT/FollowUpNoteBooks/GetByDateClassAsync";
  static const String STUDENT_DEGREES_BY_SUPER =
      "$ROOT/StudentDegrees/GetBySbjectClassIdandDegreeTypeId";
  static const String STUDENT_ATTENDENT_CREATE =
      "$ROOT/StudentAttendances/create";
  static const String TEACHER_ATTENDETN =
      "$ROOT/TeacherAttendances/GetAllByTeacherIdAsync";
  static const String STUDENT_SUGGESTION =
      "$ROOT/StudentSuggestions/GetByClassIdAsync";
  static const String STUDENT_DEGREES =
      "$ROOT/StudentDegrees/GetBySbjectClassIdandDegreeTypeId";
  static const String REPORT_BY_TEACHER_CREATE =
      "$ROOT/FollowUpNoteBooks/Create";
  static const String REPORT_BY_TEACHER_GET =
      "$ROOT/FollowUpNoteBooks/GetByClassSubjectId";
  static const String STUDENT_SOLUTION_GET =
      "$ROOT/Solutions/GetByHomeworkIdAsync";
  static const String REINFORCEMENTLESSO_BY_CLASS =
      "$ROOT/Reinforcementlessons/GetBySubjectClassId";
  static const String REINFORCEMENTLESSO_CREATE =
      "$ROOT/Reinforcementlessons/Create";
  static const String STUDENT_QEUSTIONS_BY_CLASS =
      "$ROOT/StudentQeustions/GetBySubjectClassIdAsync";
  static const String TEACHER_TABLE = "$ROOT/TeacherTables/GetByTeacherId";
  
}
// TeacherTables/GetByTeacherId