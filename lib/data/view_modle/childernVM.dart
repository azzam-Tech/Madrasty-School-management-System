import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/childern.dart';
import 'package:graduation_project/repository/app_repo.dart';

class Childernvm with ChangeNotifier {
  List<Childern> allChildernList = [];

  Future<List<Childern>> getdata(
      ApplicationRepo repo, String source, int id) async {
    try {
      debugPrint("$source/$id");
      List response = await repo.getData(source: "$source/$id");
      debugPrint("response ${response}");
      allChildernList = response.map((e) => Childern.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allChildernList;
  }
}
