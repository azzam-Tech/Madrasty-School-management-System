import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacher_attendent.dart';
import 'package:graduation_project/repository/app_repo.dart';

class TeacherAttendetVN with ChangeNotifier {
  List<TeacherAttendent> allTeacherAttendentList = [];

  Future<List<TeacherAttendent>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      debugPrint("response ${source}/$id");
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      debugPrint("response ${source}/$id");
      allTeacherAttendentList =
          response.map((e) => TeacherAttendent.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allTeacherAttendentList;
  }
}
