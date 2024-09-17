import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/grad.dart';
import 'package:graduation_project/repository/app_repo.dart';

class GradVM with ChangeNotifier {
  List<Grad> allGradList = [];
  List<Grad> allGradList2 = [];

  Future<List<Grad>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "$source");
      debugPrint("response ${response}");
      allGradList = response.map((e) => Grad.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allGradList;
  }

  Future<List<Grad>> getdata2(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "$source/$id");
      debugPrint("response ${response}");
      allGradList2 = response.map((e) => Grad.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allGradList2;
  }

  Future<List<Grad>> sendDate(
      ApplicationRepo repo, String source, List<Grad> grads) async {
    List<Map<String, dynamic>> dataToSend =
        grads.map((value) => value.toJson()).toList();
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut =
        await repo.updateDataList(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    // allGradList.add(StudentQeustion.fromJson(reslut));
    ChangeNotifier();
    return allGradList;
  }
}
