import 'package:graduation_project/data/modle/defaultmodel.dart';

class ResponseModel {
  bool? success;
  String? codestate;
  String? message;
  String? errors;
  List<DefaultModel>? data;

  ResponseModel(
      {this.success, this.codestate, this.message, this.errors, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    codestate = json['codestate'];
    message = json['message'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <DefaultModel>[];
      json['data'].forEach((v) {
        data!.add(new DefaultModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['codestate'] = this.codestate;
    data['message'] = this.message;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}