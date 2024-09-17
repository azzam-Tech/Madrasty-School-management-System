class Suggestions {
  int? studentSuggestionId;
  String? studentName;
  String? studentSuggestionText;
  String? studentSuggestionDate;

  Suggestions(
      {this.studentSuggestionId,
      this.studentName,
      this.studentSuggestionText,
      this.studentSuggestionDate});

  Suggestions.fromJson(Map<String, dynamic> json) {
    studentSuggestionId = json['studentSuggestionId'];
    studentName = json['studentName'];
    studentSuggestionText = json['studentSuggestionText'];
    studentSuggestionDate = "${json['studentSuggestionDate']}".split("T").first;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentSuggestionId'] = this.studentSuggestionId;
    data['studentName'] = this.studentName;
    data['studentSuggestionText'] = this.studentSuggestionText;
    data['studentSuggestionDate'] = this.studentSuggestionDate;
    return data;
  }
}
