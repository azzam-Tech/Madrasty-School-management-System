import 'package:graduation_project/utility/shared.dart';
import 'package:intl/intl.dart';

class Report {
  int? subjectClassId;
  int? classId;
  int? termId;
  String? followUpNoteBookText;
  String? subjectName;
  DateTime? followUpNoteBookDate;

  Report(
      {this.subjectClassId,
      this.classId,
      this.termId,
      this.followUpNoteBookText,
      this.followUpNoteBookDate});

  Report.fromJson(Map<String, dynamic> json) {
    subjectClassId = json['subjectClassId'];
    classId = json['classId'];
    termId = json['termId'];
    followUpNoteBookText = json['followUpNoteBookText'];
    if (Shared.role == "student") subjectName = json['subjectName'];
    followUpNoteBookDate =
        DateFormat("yyyy-MM-dd").parse(json['followUpNoteBookDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectClassId'] = this.subjectClassId;
    data['classId'] = this.classId;
    data['termId'] = this.termId;
    data['followUpNoteBookText'] = this.followUpNoteBookText;
    data['followUpNoteBookDate'] =
        "${this.followUpNoteBookDate}".split(" ").first.toString();
    return data;
  }
}
