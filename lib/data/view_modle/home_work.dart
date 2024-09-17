import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/homework.dart';
import 'package:graduation_project/repository/app_repo.dart';

class HomeworkVM with ChangeNotifier {
  List<HomeworkClass> allHomeWorkList = [];

  Future<List<HomeworkClass>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allHomeWorkList = response.map((e) => HomeworkClass.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allHomeWorkList;
  }

  Future sendDate(ApplicationRepo repo, String source,
      HomeworkClass homework, int subjectId) async {
    FormData dataToSend = await homework.toJson(subjectId);
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut =
        await repo.postDataFormData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    // allHomeWorkList.add(HomeworkClass.fromJson(reslut));
    ChangeNotifier();
    // return HomeworkClass.fromJson(reslut);
  }
}
