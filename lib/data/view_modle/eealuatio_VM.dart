import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/evaluatio.dart';
import 'package:graduation_project/repository/app_repo.dart';

class EvaluatioVM with ChangeNotifier {
  List<Evaluatio> allEvaluatioList = [];

  Future<List<Evaluatio>> getdata(
      ApplicationRepo repo, String source) async {
    try {
      List response = await repo.getData(source: "$source");
      debugPrint("response ${response}");
      allEvaluatioList = response.map((e) => Evaluatio.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allEvaluatioList;
  }

  Future sendDate(
      ApplicationRepo repo, String source, Evaluatio evaluatio) async {
    Map<String, dynamic> dataToSend = evaluatio.toJson();
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut =
        await repo.updateData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    // allGradList.add(StudentQeustion.fromJson(reslut));
    ChangeNotifier();
    // return allGradList;
  }
}
