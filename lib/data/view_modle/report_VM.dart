import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/report.dart';
import 'package:graduation_project/repository/app_repo.dart';

class ReportVM with ChangeNotifier {
  List<Report> allReportList = [];

  Future<List<Report>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allReportList = response.map((e) => Report.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allReportList;
  }

  Future<List<Report>> getdata2(
      ApplicationRepo repo, String source, int id, String date) async {
    try {
      debugPrint("${source}/$id/$date");
      List response = await repo.getData(source: "${source}/$id/$date");
      debugPrint("response ${response}");
      allReportList = response.map((e) => Report.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allReportList;
  }

  Future<Report> sendDate(
      ApplicationRepo repo, String source, Report report) async {
    Map<String, dynamic> dataToSend = report.toJson();
    debugPrint("$dataToSend");
    debugPrint("source $source");
    final reslut = await repo.postData(dataToSend: dataToSend, source: source);
    debugPrint("reslult ${reslut}");
    allReportList.add(Report.fromJson(reslut));
    ChangeNotifier();
    return Report.fromJson(reslut);
  }
}
