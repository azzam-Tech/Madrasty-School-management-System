
class Evaluatio {
  int? teacherEvaluationId;
  int? userId;
  String? userName;
  double? teacherEvaluationValueOne;
  double? teacherEvaluationValueTow;

  Evaluatio(
      {this.teacherEvaluationId,
      this.userId,
      this.userName,
      this.teacherEvaluationValueOne,
      this.teacherEvaluationValueTow});

  Evaluatio.fromJson(Map<String, dynamic> json) {
    teacherEvaluationId = json['teacherEvaluationId'];
    userId = json['userId'];
    userName = json['userName'];
    teacherEvaluationValueOne = json['teacherEvaluationValueOne'];
    teacherEvaluationValueTow = json['teacherEvaluationValueTow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacherEvaluationId'] = this.teacherEvaluationId;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['teacherEvaluationValueOne'] = this.teacherEvaluationValueOne;
    data['teacherEvaluationValueTow'] = this.teacherEvaluationValueTow;
    return data;
  }
}

// class Evaluatio {
//   int? teacherEvaluationValueOne;
//   int? teacherEvaluationValueTow;

//   Evaluatio({this.teacherEvaluationValueOne, this.teacherEvaluationValueTow});

//   Evaluatio.fromJson(Map<String, dynamic> json) {
//     teacherEvaluationValueOne = json['teacherEvaluationValueOne'];
//     teacherEvaluationValueTow = json['teacherEvaluationValueTow'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['teacherEvaluationValueOne'] = this.teacherEvaluationValueOne;
//     data['teacherEvaluationValueTow'] = this.teacherEvaluationValueTow;
//     return data;
//   }
// }