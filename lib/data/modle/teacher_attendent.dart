class TeacherAttendent {
  int? teacherAttendanceId;
  int? userId;
  bool? teacherAttendanceValue;
  bool? studentAttendanceValue;
  String? teacherAttendanceDate;
  String? studentAttendanceDate;
  TeacherAttendent(
      {this.teacherAttendanceId,
      this.userId,
      this.teacherAttendanceValue,
      this.teacherAttendanceDate});

  TeacherAttendent.fromJson(Map<String, dynamic> json) {
    teacherAttendanceId = json['teacherAttendanceId'];
    userId = json['userId'];
    teacherAttendanceValue = json['teacherAttendanceValue'];
    studentAttendanceValue = json['studentAttendanceValue'];
    teacherAttendanceDate = json['teacherAttendanceDate'];
    studentAttendanceDate = json['studentAttendanceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacherAttendanceId'] = this.teacherAttendanceId;
    data['userId'] = this.userId;
    data['teacherAttendanceValue'] = this.teacherAttendanceValue;
    data['teacherAttendanceDate'] = this.teacherAttendanceDate;
    return data;
  }
}
