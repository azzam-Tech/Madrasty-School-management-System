class TeacherClass {
  int? subjectClassId;
  int? levelId;
  int? classId;
  int? subjectId;
  int? subjectTeacher;
  String? subjectClassName;
  String? subjectClassImage;

  TeacherClass(
      {this.subjectClassId,
      this.levelId,
      this.classId,
      this.subjectId,
      this.subjectTeacher,
      this.subjectClassName,
      this.subjectClassImage});

  TeacherClass.fromJson(Map<String, dynamic> json) {
    subjectClassId = json['subjectClassId'];
    levelId = json['levelId'];
    classId = json['classId'];
    subjectId = json['subjectId'];
    subjectTeacher = json['subjectTeacher'];
    subjectClassName = json['subjectClassName'];
    subjectClassImage = json['subjectClassImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectClassId'] = this.subjectClassId;
    data['levelId'] = this.levelId;
    data['classId'] = this.classId;
    data['subjectId'] = this.subjectId;
    data['subjectTeacher'] = this.subjectTeacher;
    data['subjectClassName'] = this.subjectClassName;
    data['subjectClassImage'] = this.subjectClassImage;
    return data;
  }
}

// class TeacherClass {
//   int? subjectClassId;
//   int? levelId;
//   int? classId;
//   int? subjectId;
//   int? subjectTeacher;
//   String? subjectClassName;

//   TeacherClass(
//       {this.subjectClassId,
//       this.levelId,
//       this.classId,
//       this.subjectId,
//       this.subjectTeacher,
//       this.subjectClassName});

//   TeacherClass.fromJson(Map<String, dynamic> json) {
//     subjectClassId = json['subjectClassId'];
//     levelId = json['levelId'];
//     classId = json['classId'];
//     subjectId = json['subjectId'];
//     subjectTeacher = json['subjectTeacher'];
//     subjectClassName = json['subjectClassName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['subjectClassId'] = this.subjectClassId;
//     data['levelId'] = this.levelId;
//     data['classId'] = this.classId;
//     data['subjectId'] = this.subjectId;
//     data['subjectTeacher'] = this.subjectTeacher;
//     data['subjectClassName'] = this.subjectClassName;
//     return data;
//   }
// }



// class TeacherClass  {
//   int? subjectClassId;
//   int? classId;
//   int? subjectId;
//   int? subjectTeacher;
//   String? subjectClassName;

//   TeacherClass(
//       {this.subjectClassId,
//       this.classId,
//       this.subjectId,
//       this.subjectTeacher,
//       this.subjectClassName});

//   TeacherClass.fromJson(Map<String, dynamic> json) {
//     subjectClassId = json['subjectClassId'];
//     classId = json['classId'];
//     subjectId = json['subjectId'];
//     subjectTeacher = json['subjectTeacher'];
//     subjectClassName = json['subjectClassName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['subjectClassId'] = this.subjectClassId;
//     data['classId'] = this.classId;
//     data['subjectId'] = this.subjectId;
//     data['subjectTeacher'] = this.subjectTeacher;
//     data['subjectClassName'] = this.subjectClassName;
//     return data;
//   }
// }