import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/student_qeustion.dart';
import 'package:graduation_project/repository/app_repo.dart';
import 'package:graduation_project/utility/shared.dart';

class StudentQeustionVM with ChangeNotifier {
  List<StudentQeustion> allStudentQeutionList = [];

  getdata(ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allStudentQeutionList =
          response.map((e) => StudentQeustion.fromJson(e)).toList();
      ChangeNotifier();
      return allStudentQeutionList;
    } catch (e) {}
  }

  Future sendDate(
      ApplicationRepo repo, String source, StudentQeustion question) async {
    Map<String, dynamic> dataToSend = await question.toJson();
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut = await repo.postData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    // allStudentQeutionList.add(StudentQeustion.fromJson(reslut));
    ChangeNotifier();
    // return StudentQeustion.fromJson(reslut);
  }

  Future<StudentQeustion> sendDate2(ApplicationRepo repo, String source,
      StudentQeustion question, subjectID) async {
    Map<String, dynamic> dataToSend = await question.toJson();
    // dataToSend ["subjectClassId"] = subjectId;
    dataToSend["subjectClassId"] = subjectID;
    dataToSend["studentId"] = Shared.studentId;
    dataToSend["termId"] = 1;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut = await repo.postData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    allStudentQeutionList.add(StudentQeustion.fromJson(reslut));
    ChangeNotifier();
    return StudentQeustion.fromJson(reslut);
  }
}
