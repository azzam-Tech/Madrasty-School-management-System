class TeacherTable {
  int? classTimeTableId;
  int? classId;
  String? theDay;
  List<String>? periods;

  TeacherTable(
      {this.classTimeTableId, this.classId, this.theDay, this.periods});

  TeacherTable.fromJson(Map<String, dynamic> json) {
    classTimeTableId = json['classTimeTableId'];
    classId = json['classId'];
    theDay = json['theDay'];
    periods = json['periods'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classTimeTableId'] = this.classTimeTableId;
    data['classId'] = this.classId;
    data['theDay'] = this.theDay;
    data['periods'] = this.periods;
    return data;
  }
}


// class TeacherTable {
//   int? teacherTableId;
//   int? userId;
//   String? theDay;
//   String? periodOne;
//   String? periodTow;
//   String? periodThree;
//   String? periodFour;
//   String? periodFive;
//   String? periodSix;
//   String? periodSeven;
//   String? periodEight;

//   TeacherTable(
//       {this.teacherTableId,
//       this.userId,
//       this.theDay,
//       this.periodOne,
//       this.periodTow,
//       this.periodThree,
//       this.periodFour,
//       this.periodFive,
//       this.periodSix,
//       this.periodSeven,
//       this.periodEight});

//   TeacherTable.fromJson(Map<String, dynamic> json) {
//     teacherTableId = json['teacherTableId'];
//     userId = json['userId'];
//     theDay = json['theDay'];
//     periodOne = json['periodOne'];
//     periodTow = json['periodTow'];
//     periodThree = json['periodThree'];
//     periodFour = json['periodFour'];
//     periodFive = json['periodFive'];
//     periodSix = json['periodSix'];
//     periodSeven = json['periodSeven'];
//     periodEight = json['periodEight'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['teacherTableId'] = this.teacherTableId;
//     data['userId'] = this.userId;
//     data['theDay'] = this.theDay;
//     data['periodOne'] = this.periodOne;
//     data['periodTow'] = this.periodTow;
//     data['periodThree'] = this.periodThree;
//     data['periodFour'] = this.periodFour;
//     data['periodFive'] = this.periodFive;
//     data['periodSix'] = this.periodSix;
//     data['periodSeven'] = this.periodSeven;
//     data['periodEight'] = this.periodEight;
//     return data;
//   }
// }