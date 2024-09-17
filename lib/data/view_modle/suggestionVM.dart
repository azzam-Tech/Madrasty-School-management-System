import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/Suggestions.dart';
import 'package:graduation_project/repository/app_repo.dart';
import 'package:graduation_project/utility/shared.dart';

class SuggestionVN with ChangeNotifier {
  List<Suggestions> allSuggestionList = [];

  Future<List<Suggestions>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allSuggestionList = response.map((e) => Suggestions.fromJson(e)).toList();
      debugPrint("allSuggestionList : $allSuggestionList");
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allSuggestionList;
  }

  Future<Suggestions> sendDate2(ApplicationRepo repo, String source,
      Suggestions question) async {
    Map<String, dynamic> dataToSend = await question.toJson();
    // dataToSend ["subjectClassId"] = subjectId;
    // dataToSend["subjectClassId"] = subjectID;
    dataToSend["studentId"] = Shared.studentId;
    dataToSend["classId"] = Shared.studentClassId;
    debugPrint("dataToSend: $dataToSend");
    debugPrint("source $source");
    final reslut = await repo.postData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    allSuggestionList.add(Suggestions.fromJson(reslut));
    ChangeNotifier();
    return Suggestions.fromJson(reslut);
  }
}
