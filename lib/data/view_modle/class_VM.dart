import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/ckass.dart';
import 'package:graduation_project/repository/app_repo.dart';
import 'package:http/http.dart';

class classVM with ChangeNotifier{
  List<ClassM> allClass = [];

  Future<List<ClassM>> getdata(
      ApplicationRepo repo, String source) async {
    try {
      debugPrint("source class ${source}");
      List response = await repo.getData(source:"$source");
      debugPrint("response ${response}");
      allClass = response.map((e) => ClassM.fromJson(e)).toList();
      ChangeNotifier();
    } catch (e) {
      debugPrint("errpe $e");
    }

    return allClass;
  }

  // Future<List<ClassM>> getData(ApplicationRepo repo,String source) async {
  //    List result=await  repo.getData(source: source);
  //   debugPrint("$result");
  //   return [];
  // }

}