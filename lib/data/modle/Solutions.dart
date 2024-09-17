// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:dio/dio.dart';
import 'package:graduation_project/utility/shared.dart';

class Solutions {
  int? solutionId;
  String? studentName;
  String? solutionFile;
  String? solutionDate;
  double? solutionDegree;
  String? solutionnote;

  Solutions(
      {this.solutionId,
      this.studentName,
      this.solutionFile,
      this.solutionDate,
      this.solutionDegree,
      this.solutionnote});

  Solutions.fromJson(Map<String, dynamic> json) {
    print(json);
    solutionId = json['solutionId'];
    studentName = json['studentName'] ??= "unkonn";
    solutionFile = json['solutionFile'] ??= "unkonn";
    solutionDate = json['solutionDate'] ??= "unkonn";
    solutionDegree = json['solutionDegree'] ??= 0.0;
    solutionnote = json['solutionnote'] ??= "unkonn";
  }

  Future<FormData> toJson(int homeworkId) async {
    final FormData data = FormData.fromMap({
      "homeWorkId": homeworkId,
      "studentId": Shared.studentId,
      "solutionFile": await MultipartFile.fromFile(this.solutionFile!,
          filename: 'image.txt'),
      "solutionDate": this.solutionDate,
    });
    // data['solutionId'] = this.solutionId;
    // data['studentName'] = this.studentName;
    // data['studentId'] = Shared.studentId;
    // data['solutionFile'] = this.solutionFile;
    // data['solutionDate'] = this.solutionDate;
    // data['solutionDegree'] = this.solutionDegree;
    // data['solutionnote'] = this.solutionnote;
    return data;
  }

  Map<String, dynamic> toJson2() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['solutionDegree'] = this.solutionDegree;
    data['solutionnote'] = this.solutionnote;
    return data;
  }
}
