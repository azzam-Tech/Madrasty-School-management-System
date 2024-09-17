import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/Solutions.dart';
import 'package:graduation_project/repository/app_repo.dart';

class SolutionVm with ChangeNotifier {
  List<Solutions> allSolutionsList = [];
  Future<List<Solutions>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allSolutionsList = response.map((e) => Solutions.fromJson(e)).toList();
      debugPrint("allSolutionsList $allSolutionsList");
      // ChangeNotifier();
    } catch (e) {
      debugPrint("error $e");
    }
    return allSolutionsList;
  }

  Future<Solutions> sendDate(ApplicationRepo repo, String source,
      Solutions solution, int homeworkId) async {
    FormData dataToSend = await solution.toJson(homeworkId);
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: ${dataToSend.fields}");
    debugPrint("source $source");
    final reslut =
        await repo.postDataFormData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    allSolutionsList.add(Solutions.fromJson(reslut));
    ChangeNotifier();
    return Solutions.fromJson(reslut);
  }

  Future<Solutions> editDate(
    ApplicationRepo repo,
    String source,
    Solutions solution,
  ) async {
    Map<String, dynamic> dataToSend = await solution.toJson2();
    // dataToSend ["subjectClassId"] = subjectId;
    debugPrint("dataToSend: ${dataToSend}");
    debugPrint("source $source/${solution.solutionId}");
    final reslut = await repo.updateData(
        dataToSend: dataToSend, source: "$source/${solution.solutionId}");
    debugPrint("reslult ${reslut}");
    allSolutionsList.add(Solutions.fromJson(reslut));
    ChangeNotifier();
    return Solutions.fromJson(reslut);
  }
}
