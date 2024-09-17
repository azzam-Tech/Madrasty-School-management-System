class ClassM {
  int? levelId;
  int? classSopervisor;
  String? className;

  ClassM({this.levelId, this.classSopervisor, this.className});

  ClassM.fromJson(Map<String, dynamic> json) {
    levelId = json['levelId'];
    classSopervisor = json['classSopervisor'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['levelId'] = this.levelId;
    data['classSopervisor'] = this.classSopervisor;
    data['className'] = this.className;
    return data;
  }
}