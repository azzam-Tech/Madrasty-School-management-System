import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/reinformtion_lessne.dart';
import 'package:graduation_project/repository/app_repo.dart';

class ReinforcementLessoVM with ChangeNotifier {
  List<ReinforcementLesso> allReinforcementLessoList = [];

  Future<List<ReinforcementLesso>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allReinforcementLessoList =
          response.map((e) => ReinforcementLesso.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allReinforcementLessoList;
  }

  Future sendDate(ApplicationRepo repo, String source,
      ReinforcementLesso homework, int subjectId) async {
    FormData dataToSend = await homework.toJson(subjectId);
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut =
        await repo.postDataFormData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    // allReinforcementLessoList.add(ReinforcementLesso.fromJson(reslut));
    ChangeNotifier();
    // return ReinforcementLesso.fromJson(reslut);
  }
}
