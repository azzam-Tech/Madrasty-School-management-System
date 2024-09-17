import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/section.dart';
import 'package:graduation_project/repository/app_repo.dart';

class SectionVm with ChangeNotifier {
  List<Section> allSectionList = [];
  Future<List<Section>> getdata(
      ApplicationRepo repo, String source) async {
    try {
      List response = await repo.getData(source: "$source");
      debugPrint("response ${response}");
      allSectionList = response.map((e) => Section.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allSectionList;
  }
}