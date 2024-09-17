class Book {
  int? levelId;
  String? subjectName;
  List<String>? subjecBooks;

  Book({this.levelId, this.subjectName, this.subjecBooks});

  Book.fromJson(Map<String, dynamic> json) {
    levelId = json['levelId'];
    subjectName = json['subjectName'];
    subjecBooks = json['subjecBooks'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['levelId'] = this.levelId;
    data['subjectName'] = this.subjectName;
    data['subjecBooks'] = this.subjecBooks;
    return data;
  }
}