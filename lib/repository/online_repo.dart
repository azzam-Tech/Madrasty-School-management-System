import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/helper/dio_connection.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:graduation_project/repository/app_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlineRepo extends ApplicationRepo {
  @override
  Future<List<dynamic>> getData({required String source}) async {
    try {
      Response<String> serverResponse = await DioConnection.connect().get(
          source,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Authorization": "Bearer ${Shared.token}"}));

      Map<String, dynamic> content = jsonDecode(serverResponse.data!);
      print(content);
      return content['data'];
      return content['users'];
    } catch (ex, stack) {
      print(stack);

      debugPrint(ex.toString());

      return [];
    }
  }

  @override
  Future postData(
      {required Map<String, dynamic> dataToSend,
      required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().post(source,
        data: dataToSend,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    debugPrint("response ${serverResponse.data}");
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");

      return serverResponse.data["data"];
    } else {
      print("فشلت العمليه ");
      return serverResponse.data;
    }
  }

  @override
  Future postDataFormData(
      {required FormData dataToSend, required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().post(source,
        data: dataToSend,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    debugPrint("response ${serverResponse.data}");
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");

      return serverResponse.data["data"];
    } else {
      print("فشلت العمليه ");
      return serverResponse.data;
    }
  }

  // @override
  // Future postDataFormData(
  //     {required Map<String, dynamic> dataToSend,
  //     required String source}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token') ?? Shared.token;

  //   Response serverResponse = await DioConnection.connect().post(source,
  //       data: dataToSend,
  //       options: Options(
  //           followRedirects: false,
  //           validateStatus: (status) => true,
  //           headers: {"Authorization": "Bearer $token"}));
  //   debugPrint("response ${serverResponse.data}");
  //   if ([201, 200].contains(serverResponse.statusCode)) {
  //     print("تم بنجاح ");

  //     return serverResponse.data["data"];
  //   } else {
  //     print("فشلت العمليه ");
  //     return serverResponse.data;
  //   }
  // }

  @override
  Future updateData(
      {required Map<String, dynamic> dataToSend,
      required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().put(source,
        data: dataToSend,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");
      return serverResponse.data;
    } else {
      print("فشلت العمليه ");
      return serverResponse.data;
    }
  }

  @override
  Future updateDataList(
      {required List<Map<String, dynamic>> dataToSend,
      required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().put(source,
        data: dataToSend,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");
      return serverResponse.data;
    } else {
      print("فشلت العمليه ");
      return serverResponse.data;
    }
  }

  @override
  Future postDataList(
      {required List<Map<String, dynamic>> dataToSend,
      required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().post(source,
        data: dataToSend,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");
      return serverResponse.data;
    } else {
      print("فشلت العمليه ");
      print("${serverResponse.statusCode}");
      return serverResponse.data;
    }
  }

  @override
  Future delete(
      {required Map<String, dynamic> dataToSend,
      required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().delete(source,
        data: dataToSend,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");
      return serverResponse.data;
    } else {
      print("فشلت العمليه ");
      return serverResponse.data;
    }
  }

  
  @override
  Future<bool> deletesoucw(
      {
      required String source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? Shared.token;

    Response serverResponse = await DioConnection.connect().delete(source,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {"Authorization": "Bearer $token"}));
    if ([201, 200].contains(serverResponse.statusCode)) {
      print("تم بنجاح ");
      return true;
    } else {
      print("فشلت العمليه ");
      return false;
    }
  }

  @override
  Future getoneData({required String source}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token') ?? Shared.token;
      Response<String> serverResponse = await DioConnection.connect().get(
          source,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Authorization": "Bearer $token"}));

      Map<String, dynamic> content = jsonDecode(serverResponse.data!);

      return content;
    } catch (ex, stack) {
      print(stack);
      debugPrint(ex.toString());
      return {"code": 404};
    }
  }
}
