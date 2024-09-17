import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacherAttendent.dart';
// import 'package:graduation_project/data/modle/teacher_attendent.dart';
import 'package:graduation_project/repository/app_repo.dart';

class TeacherAttendentVM with ChangeNotifier {
   List<TeacherAttendent2> allStudentAttendnetList = [];

  Future<List<TeacherAttendent2>> getdata(
      ApplicationRepo repo, String source) async {
    try {
      List response = await repo.getData(source: "$source");
      debugPrint("response ${response}");
      allStudentAttendnetList =
          response.map((e) => TeacherAttendent2.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allStudentAttendnetList;
  }

  Future<List<TeacherAttendent2>> sendDate(ApplicationRepo repo, String source,
      List<TeacherAttendent2> studentList) async {
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
    allStudentAttendnetList[index].teacherAttendanceValue =
        !allStudentAttendnetList[index].teacherAttendanceValue!;
    ChangeNotifier();
  }
}