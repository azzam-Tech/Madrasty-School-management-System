import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/repository/app_repo.dart';

class TeacherClassVM with ChangeNotifier {
  List<TeacherClass> allTeacherClassList = [];
  List<TeacherClass> allTeacherClassList2 = [];

  getdata(ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allTeacherClassList =
          response.map((e) => TeacherClass.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {}
  }

  getdata2(ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allTeacherClassList2 =
          response.map((e) => TeacherClass.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {}
  }
}
