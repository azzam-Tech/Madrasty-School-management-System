import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Shared with ChangeNotifier {
  static String? token;
  static String? role;
  static int? id;
  static int? studentId;
  static int? stedentParent;
  static int? studentClassId;
  static int? levelId;
  static int? classId;
  static String? userName;
  static String? password;
  static bool? isSuperVaisor;
  static bool? isAuthenticated;
  int? currentTabIndex = 0;

  static Future<SharedPreferences> getinstains() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveUserInfo(Map result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint("$result");
    //role
    await prefs.setString("role", result["role"].toLowerCase());
    role = result["role"].toLowerCase();
    //tokem
    await prefs.setString("token", result["token"]);
    token = result["token"];
    //user id
    await prefs.setInt("userId", result["userId"]);
    id = result["userId"];
    //user name
    await prefs.setString("username", result["username"]);
    userName = result["username"];
    // passwprd
    await prefs.setString("password", result["password"]);
    password = result["password"];
    // isSuperVaisor
    await prefs.setBool("isSuperVaisor", result["isSuperVaisor"]);
    isSuperVaisor = result["isSuperVaisor"];
    // isAuthenticated
    await prefs.setBool("isAuthenticated", result["isAuthenticated"]);
    isAuthenticated = result["isAuthenticated"];
    // studentClassId
    await prefs.setInt("studentClassId", result["studentClassId"]);
    studentClassId = result["studentClassId"];
    // studentId
    await prefs.setInt("studentId", result["studentId"]);
    studentId = result["studentId"];
    // stedentParent
    await prefs.setInt("stedentParent", result["stedentParent"]);
    stedentParent = result["stedentParent"];
    // levelId
    await prefs.setInt("levelId", result["levelId"]);
    levelId = result["levelId"];
    // levelId
    await prefs.setInt("classId", result["classId"]);
    classId = result["classId"];
  }

  Future<void> gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", value);
    token = value;
  }

  Future<void> getrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
  }

  setrole(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("role", value.toLowerCase());
    token = value;
  }

  static Future<void> retrieveinfo() async {
    var pref = await getinstains();
    token = pref.getString("token");
    role = pref.getString("role");
    id = pref.getInt("userId");
    isSuperVaisor = pref.getBool("isSuperVaisor");
    isAuthenticated = pref.getBool("isAuthenticated");
    studentClassId = pref.getInt("studentClassId");
    studentId = pref.getInt("studentId");
    levelId = pref.getInt("levelId");
    classId = pref.getInt("classId");
    stedentParent = pref.getInt("stedentParent");
    studentClassId = pref.getInt("studentClassId");
    userName = pref.getString("username");
    password = pref.getString("password");
  }

  static Future<void> reset() async {
    var sp = await getinstains();
    sp.clear();
  }
  //   static Future<void> update(String newtoken,String newrole) async {
  //   var pref = await getinstains();
  //    pref.setString("token",newtoken);
  //    pref.setString("role",newrole);
  // }
}

class DrawerHelper {
  static const String selectedTabIndexKey = 'selectedTabIndex';
  static const String activeColorKey = 'activeColor';

  static Future<void> saveDrawerState(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(selectedTabIndexKey, index);
    await prefs.setInt(activeColorKey, color.value);
  }

  static Future<Map<String, dynamic>> getDrawerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt(selectedTabIndexKey) ?? 0;
    int colorValue = prefs.getInt(activeColorKey) ?? Colors.blue.value;
    Color color = Color(colorValue);
    return {'index': index, 'color': color};
  }
}












// class authoservice {
//   Future<bool> isloggin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return await prefs.getBool('isLoggedIn') ?? false;
//   }

//   Future<void> login() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//   }
// }
