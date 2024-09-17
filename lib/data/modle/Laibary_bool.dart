class LaibaryBook {
  int? laibaryBookId;
  int? sectionid;
  String? laibaryBookName;
  String? laibaryBookImagePath;
  String? laibaryBookPath;

  LaibaryBook(
      {this.laibaryBookId,
      this.sectionid,
      this.laibaryBookName,
      this.laibaryBookImagePath,
      this.laibaryBookPath});

  LaibaryBook.fromJson(Map<String, dynamic> json) {
    laibaryBookId = json['laibaryBookId'];
    sectionid = json['sectionid'];
    laibaryBookName = json['laibaryBookName'];
    laibaryBookImagePath = json['laibaryBookImagePath'];
    laibaryBookPath = json['laibaryBookPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['laibaryBookId'] = this.laibaryBookId;
    data['sectionid'] = this.sectionid;
    data['laibaryBookName'] = this.laibaryBookName;
    data['laibaryBookImagePath'] = this.laibaryBookImagePath;
    data['laibaryBookPath'] = this.laibaryBookPath;
    return data;
  }
}