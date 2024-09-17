import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacher_table.dart';
import 'package:graduation_project/repository/app_repo.dart';

class TeacherTableVM with ChangeNotifier {
  List<TeacherTable> allTeacherTableList = [];
  Map<String, List<List<String>>> temp = {};

  Future<List<TeacherTable>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allTeacherTableList =
          response.map((e) => TeacherTable.fromJson(e)).toList();
      // temp = convertTeacherTable(allTeacherTableList);
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allTeacherTableList;
  }

//   convertTeacherTable(List<TeacherTable> items) {
//     Map<String, List<List<String>>> temp = {};
//     items.forEach((element) {
//       temp[element.theDay!] = [
//         ['8:00 AM', '${element.periodOne}', 'حصة 1'],
//         ['8:00 AM', '${element.periodTow}', 'حصة 2'],
//         ['8:00 AM', '${element.periodThree}', 'حصة 3'],
//         ['8:00 AM', '${element.periodFour}', 'حصة 4'],
//         ['8:00 AM', '${element.periodFive}', 'حصة 5'],
//         ['8:00 AM', '${element.periodSix}', 'حصة 6'],
//         ['8:00 AM', '${element.periodSeven}', 'حصة 7'],
//         ['8:00 AM', '${element.periodEight}', 'حصة 8'],
//       ];
//     });
//     // allTeacherTableList.clear();
//     ChangeNotifier();
//     return temp;
//   }
}
// 'الأحد': [
//       ['8:00 AM', 'C', 'حصة 1'],
//       ['9:00 AM', 'Class 2', 'حصة 2'],
//       ['10:00 AM', 'Class 3', 'حصة 3'],
//     ],