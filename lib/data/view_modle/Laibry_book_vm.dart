import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/Laibary_bool.dart';
import 'package:graduation_project/repository/app_repo.dart';

class LibaryBookVN with ChangeNotifier{
   List<LaibaryBook> allLibaryBooList = [];
  Future<List<LaibaryBook>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      List response = await repo.getData(source: "${source}/$id");
      debugPrint("response ${response}");
      allLibaryBooList = response.map((e) => LaibaryBook.fromJson(e)).toList();
      debugPrint("allSolutionsList $allLibaryBooList");
      // ChangeNotifier();
    } catch (e) {
      debugPrint("error $e");
    }
    return allLibaryBooList;
  }
}