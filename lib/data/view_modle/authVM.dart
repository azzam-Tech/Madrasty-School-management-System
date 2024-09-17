import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/repository/app_repo.dart';
import 'package:graduation_project/utility/shared.dart';

class AuthVM{
  Future<Map<String,dynamic>>  login ( ApplicationRepo repo,String source,Map<String,dynamic> data)async{
    try{
      final response =await Dio().post(source,data: data);
      Shared instanc = Shared();
      debugPrint("date ${response.data["data"]}");
      Map result = response.data["data"];
     await instanc.saveUserInfo(result);
      return response.data["data"];
    } on DioException catch (e) {
    if (e.type == DioException.sendTimeout) {
      debugPrint('Send Timeout Exception');
      
    } else if (e.type == DioException.receiveTimeout) {
      debugPrint('Receive Timeout Exception');
    }  else {
      debugPrint('Network Error: ${e.message}');
    }
  } catch (e) {
    debugPrint('Unexpected Error: $e');
  }
   return {
      "isAuthenticated": false,
      "token": null, 
    };
  }

  
}