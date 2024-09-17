class Section {
  int? sectionId;
  String? sectionName;

  Section({this.sectionId, this.sectionName});

  Section.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionId'] = this.sectionId;
    data['sectionName'] = this.sectionName;
    return data;
  }
}