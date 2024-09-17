// class StudentQeustion {
//   int? studentQeustionId;
//   String? studentName;
//   String? studentQeustionText;
//   String? teacherAnswerText;
//   String? studentQeustionDate;
//   String? teacherAnswerDate;
//   // String? teacherReplay;

//   StudentQeustion({
//     this.studentQeustionId,
//     this.studentName,
//     this.studentQeustionText,
//     this.teacherAnswerText,
//     this.studentQeustionDate,
//   });

//   StudentQeustion.fromJson(Map<String, dynamic> json) {
//     studentQeustionId = json['studentQeustionId'];
//     studentName = json['studentName'] ?? "unkonw";
//     studentQeustionText = json['studentQeustionText'];
//     // teacherAnswerText = null;
//     teacherAnswerText = json['teacherAnswerText'];
//     studentQeustionDate = json['studentQeustionDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['studentQeustionId'] = this.studentQeustionId;
//     data['studentName'] = this.studentName;
//     data['studentQeustionText'] = this.studentQeustionText;
//     data['teacherAnswerText'] = this.teacherAnswerText;
//     data['studentQeustionDate'] = this.studentQeustionDate;
//     data['teacherAnswerDate'] = this.teacherAnswerDate;
//     return data;
//   }
// }
class StudentQeustion {
  int? studentQeustionId;
  int? studentId;
  String? studentName;
  String? studentQeustionText;
  String? teacherAnswerText;
  String? studentQeustionDate;

  StudentQeustion(
      {this.studentQeustionId,
      this.studentId,
      this.studentName,
      this.studentQeustionText,
      this.teacherAnswerText,
      this.studentQeustionDate});

  StudentQeustion.fromJson(Map<String, dynamic> json) {
    studentQeustionId = json['studentQeustionId'];
    studentId = json['studentId'];
    studentName = json['studentName'] ?? "unkonw";
    studentQeustionText = json['studentQeustionText'];
    teacherAnswerText = json['teacherAnswerText'];
    studentQeustionDate = json['studentQeustionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentQeustionId'] = this.studentQeustionId;
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['studentQeustionText'] = this.studentQeustionText;
    data['teacherAnswerText'] = this.teacherAnswerText;
    data['studentQeustionDate'] = this.studentQeustionDate;
    return data;
  }
}
