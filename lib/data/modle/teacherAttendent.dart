class TeacherAttendent2 {
  int? userId;
  String? userName;
  bool? teacherAttendanceValue;
  String? teacherAttendanceDate;

  TeacherAttendent2(
      {this.userId,
      this.userName,
      this.teacherAttendanceValue,
      this.teacherAttendanceDate});

  TeacherAttendent2.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    teacherAttendanceValue = true;
    teacherAttendanceDate = json['teacherAttendanceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['teacherAttendanceValue'] = this.teacherAttendanceValue;
    data['teacherAttendanceDate'] = "${DateTime.now()}".split(" ").first;
    return data;
  }
}