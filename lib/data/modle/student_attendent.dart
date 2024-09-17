class StudentAttendent {
  int? studentId;
  int? termId;
  String? studentName;
  bool? studentAttendanceValue;
  String? studentAttendanceDate;

  StudentAttendent(
      {this.studentId,
      this.termId,
      this.studentName,
      this.studentAttendanceValue,
      this.studentAttendanceDate});

  StudentAttendent.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    termId = json['termId'];
    studentName = json['studentName'];
    studentAttendanceValue = true;
    studentAttendanceDate = json['studentAttendanceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['termId'] = 1;
    // data['studentName'] = this.studentName;
    data['studentAttendanceValue'] = this.studentAttendanceValue;
    data['studentAttendanceDate'] = "${DateTime.now()}".split(" ").first;
    return data;
  }
}
