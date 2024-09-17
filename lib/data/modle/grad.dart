// class Grad {
//   int? studentDegreeId;
//   double? studentDegreeValue;
//   String? studentName;

//   Grad({this.studentDegreeId, this.studentDegreeValue, this.studentName});

//   Grad.fromJson(Map<String, dynamic> json) {
//     studentDegreeId = json['studentDegreeId'];
//     studentDegreeValue = json['studentDegreeValue'];
//     studentName = json['studentName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['studentDegreeId'] = this.studentDegreeId;
//     data['studentDegreeValue'] = this.studentDegreeValue;
//     // data['studentName'] = this.studentName;
//     return data;
//   }
// }

import 'package:graduation_project/utility/shared.dart';

class Grad {
  int? studentDegreeId;
  int? degreeTypeId;
  double? studentDegreeValue;
  String? studentName;
  String? subjectName;

  Grad(
      {this.studentDegreeId,
      this.degreeTypeId,
      this.studentDegreeValue,
      this.studentName});

  Grad.fromJson(Map<String, dynamic> json) {
    if (Shared.role == "teacher") studentDegreeId = json['studentDegreeId'];
    degreeTypeId = json['degreeTypeId'];
    studentDegreeValue = json['studentDegreeValue'];
    studentName = json['studentName'];
    if (Shared.role == "student" || Shared.role == "parent")
      subjectName = json['subjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentDegreeId'] = this.studentDegreeId;
    data['degreeTypeId'] = this.degreeTypeId;
    data['studentDegreeValue'] = this.studentDegreeValue;
    data['studentName'] = this.studentName;
    return data;
  }
}
