class User {
  String? message;
  bool? isAuthenticated;
  String? username;
  String? password;
  String? role;
  String? token;
  String? expiresOn;
  String? initialInfo;

  User(
      {this.message,
      this.isAuthenticated,
      this.username,
      this.password,
      this.role,
      this.token,
      this.expiresOn,
      this.initialInfo});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isAuthenticated = json['isAuthenticated'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    token = json['token'];
    expiresOn = json['expiresOn'];
    initialInfo = json['initialInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['isAuthenticated'] = this.isAuthenticated;
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['token'] = this.token;
    data['expiresOn'] = this.expiresOn;
    data['initialInfo'] = this.initialInfo;
    return data;
  }
}