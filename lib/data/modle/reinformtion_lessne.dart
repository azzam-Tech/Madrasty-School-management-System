import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class ReinforcementLesso {
  int? reinforcementlessonId;
  String? reinforcementlessonTitle;
  String? reinforcementlessondescription;
  String? reinforcementlessonFile;
  String? reinforcementlessonlink;
  DateTime? reinforcementlessonDate;

  ReinforcementLesso(
      {this.reinforcementlessonId,
      this.reinforcementlessonTitle,
      this.reinforcementlessondescription,
      this.reinforcementlessonFile,
      this.reinforcementlessonlink,
      this.reinforcementlessonDate});

  ReinforcementLesso.fromJson(Map<String, dynamic> json) {
    reinforcementlessonId = json['reinforcementlessonId'];
    reinforcementlessonTitle = json['reinforcementlessonTitle'];
    reinforcementlessondescription = json['reinforcementlessondescription'];
    reinforcementlessonFile = json['reinforcementlessonFile'];
    reinforcementlessonlink = json['reinforcementlessonlink'];
    reinforcementlessonDate = json['reinforcementlessonDate'] != null
        ? DateFormat("yyyy-MM-dd").parse(json['reinforcementlessonDate'])
        : DateTime.now();
  }

  Future<FormData> toJson(int subjectId) async {
    final FormData data = FormData.fromMap({
      "termId": 1,
      "subjectClassId": subjectId,
      "reinforcementlessonTitle": this.reinforcementlessonTitle,
      "reinforcementlessondescription": this.reinforcementlessondescription,
      "reinforcementlessonFile": await MultipartFile.fromFile(
          this.reinforcementlessonFile!,
          filename: 'image.txt'),
      "reinforcementlessonlink": this.reinforcementlessonlink,
      "reinforcementlessonDate": this.reinforcementlessonDate
    });
    // data['reinforcementlessonId'] = this.reinforcementlessonId;
    // data['reinforcementlessonTitle'] = this.reinforcementlessonTitle;
    // data['reinforcementlessondescription'] =
    //     this.reinforcementlessondescription;
    // data['reinforcementlessonFile'] = this.reinforcementlessonFile;
    // data['reinforcementlessonlink'] = this.reinforcementlessonlink;
    // data['reinforcementlessonDate'] = this.reinforcementlessonDate;
    return data;
  }
}
