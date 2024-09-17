import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HomeworkClass {
  int? homeWorkId;
  double? homeWorkDegree;
  String? homeWorkTitle;
  String? homeWorkdescription;
  String? homeWorkText;
  String? homeWorkImagePath;
  DateTime? homeWorkDeadline;
  DateTime? homeWorkDate;

  HomeworkClass(
      {this.homeWorkId,
      this.homeWorkDegree,
      this.homeWorkTitle,
      this.homeWorkdescription,
      this.homeWorkText,
      this.homeWorkImagePath,
      this.homeWorkDeadline,
      this.homeWorkDate});

  HomeworkClass.fromJson(Map<String, dynamic> json) {
    homeWorkId = json['homeWorkId'];
    homeWorkDegree = json['homeWorkDegree'];
    homeWorkTitle = json['homeWorkTitle'];
    homeWorkdescription = json['homeWorkdescription'];
    homeWorkText = json['homeWorkText'];
    homeWorkImagePath = json['homeWorkImagePath'];
    homeWorkDeadline = DateTime.now();
    // homeWorkDeadline = json['homeWorkDeadline'];
    // homeWorkDate =
    //     DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['homeWorkDate']);
    homeWorkDate = DateTime.now();
  }

  Future<FormData> toJson(int subjectId) async {
    final FormData data =  FormData.fromMap({
      "termId": 1,
      "subjectClassId": subjectId,
      "homeWorkDegree":  this.homeWorkDegree,
      "HomeWorkTitle":  this.homeWorkTitle,
      "homeWorkdescription":  this.homeWorkdescription,
      "homeWorkText":  this.homeWorkText,
      "homeWorkImagePath":await MultipartFile.fromFile(this.homeWorkImagePath!, filename: 'image.txt')  ,
      "homeWorkDeadline":  "${this.homeWorkDeadline}".split(" ").first.toString()
      
    });

    // data["termId"] = 1;
    // // data['homeWorkId'] = this.homeWorkId;
    // data['homeWorkDegree'] = this.homeWorkDegree;
    // data['HomeWorkTitle'] = this.homeWorkTitle;
    // data['homeWorkdescription'] = this.homeWorkdescription;
    // data['homeWorkText'] = this.homeWorkText;
    // data['homeWorkImagePath'] = this.homeWorkImagePath;
    // data['homeWorkDeadline'] =
    //     "${this.homeWorkDeadline}".split(" ").first.toString();
    // data['homeWorkDate'] = this.homeWorkDate.toString();
    return data;
  }
}
