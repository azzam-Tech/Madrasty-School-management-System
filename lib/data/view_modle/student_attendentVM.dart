import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/student_attendent.dart';
import 'package:graduation_project/repository/app_repo.dart';

class StudentAttendentVM with ChangeNotifier {
  List<StudentAttendent> allStudentAttendnetList = [];

  Future<List<StudentAttendent>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allStudentAttendnetList =
          response.map((e) => StudentAttendent.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allStudentAttendnetList;
  }

  Future<List<StudentAttendent>> sendDate(ApplicationRepo repo, String source,
      List<StudentAttendent> studentList) async {
    List<Map<String, dynamic>> dataToSend =
        studentList.map((value) => value.toJson()).toList();
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut =
        await repo.postDataList(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    // allGradList.add(StudentQeustion.fromJson(reslut));
    ChangeNotifier();
    return allStudentAttendnetList;
  }

  triger(int index) {
    allStudentAttendnetList[index].studentAttendanceValue =
        !allStudentAttendnetList[index].studentAttendanceValue!;
    ChangeNotifier();
  }
}
