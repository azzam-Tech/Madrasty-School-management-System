import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/student_qeustion.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/student_qeustion.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/buttoncolor.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/view/teacher/components/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class Notification {
  final String studentName;
  final String studentAvatarUrl;
  final String date;
  final String body;
  String? reply;

  Notification({
    required this.studentName,
    required this.studentAvatarUrl,
    required this.date,
    required this.body,
    this.reply,
  });
}

class ViewQuestion extends StatefulWidget {
  ViewQuestion({required this.instanc});
  TeacherClass instanc;
  @override
  _ViewQuestionState createState() => _ViewQuestionState();
}

class _ViewQuestionState extends State<ViewQuestion> {
  // late List<StudentQeustion> originalNotifications;
  List<StudentQeustion> filteredNotifications = [];
  late TextEditingController searchController;
  bool showNoResults = false;

  Future<void> fetchNotifications() async {
    debugPrint(
        "${API_URL.STUDENT_QEUSTIONS_BY_CLASS}/${widget.instanc.classId}");

    Provider.of<StudentQeustionVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_QEUSTIONS_BY_CLASS,
            widget.instanc.classId!)
        .then((value) {
      debugPrint("vlaue $value");
      filteredNotifications = value;

      setState(() {});
    });
    // final response =
    //     await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = json.decode(response.body);
    //   setState(() {
    //     originalNotifications = jsonData.map((item) {
    //       return Notification(
    //         studentName: item['title'],
    //         studentAvatarUrl: 'https://example.com/avatar.png',
    //         date: '2024-04-01',
    //         body: item['body'],
    //       );
    //     }).toList();
    //     filteredNotifications = List.from(originalNotifications);
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    setState(() {});
    searchController = TextEditingController();
  }

  void _showAddReplyDialog(BuildContext context, StudentQeustion notification) {
    TextEditingController replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification.teacherAnswerText != null
              ? 'تعديل الرد'
              : 'اضافة رد'),
          content: TextField(
            controller: replyController
              ..text = notification.teacherAnswerText ?? '',
            decoration: InputDecoration(hintText: "اكتب ردك هنا"),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                  notification.teacherAnswerText != null ? 'تعديل' : 'ارسال'),
              onPressed: () async {
                String reply = replyController.text;
                notification.teacherAnswerText = replyController.text;
                notification.studentQeustionDate =
                    "${DateTime.now()}".split(" ").first;

                if (reply.isNotEmpty) {
                  Provider.of<StudentQeustionVM>(context, listen: false)
                      .sendDate(
                          OnlineRepo(), API_URL.TEACHER_REPLAY, notification);
                  setState(() {
                    notification.teacherAnswerText = reply;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SQVM = Provider.of<StudentQeustionVM>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appbarchild(
            title: 'اسئلة الطلاب',
          ),
          drawer: CustomDrawer(
            instanc: widget.instanc,
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 9,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    filteredNotifications =
                                        List.from(SQVM.allStudentQeutionList);
                                    showNoResults = false;
                                  } else {
                                    filteredNotifications = SQVM
                                        .allStudentQeutionList
                                        .where((notification) => notification
                                            .studentName!
                                            .contains(value))
                                        .toList();
                                    showNoResults =
                                        filteredNotifications.isEmpty;
                                    debugPrint("result ${showNoResults}");
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'ابحث...',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        showNoResults
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'لا توجد نتائج',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: filteredNotifications.length,
                                  itemBuilder: (context, index) {
                                    // debugPrint("result loab ${showNoResults}");
                                    filteredNotifications =
                                        filteredNotifications.reversed.toList();
                                    var notification =
                                        filteredNotifications[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading: const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "img/biology.jpg"),
                                                ),
                                                title: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    notification.studentName!,
                                                    style: fonttitlestyle
                                                        .fonttitle,
                                                  ),
                                                ),
                                                subtitle: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    notification
                                                        .studentQeustionDate!,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                notification
                                                    .studentQeustionText!,
                                                style: fonttitlestyle.fonttitle,
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color: Colors.grey.shade300,
                                                endIndent: 5,
                                                indent: 5,
                                              ),
                                              if (notification
                                                      .teacherAnswerText !=
                                                  null)
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  child: ListTile(
                                                    title: Text(
                                                      ' ${notification.teacherAnswerText}',
                                                      style: fonttitlestyle
                                                          .fonttitle,
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 20),
                                                child: CustomGradientButton(
                                                  buttonText: notification
                                                              .teacherAnswerText !=
                                                          null
                                                      ? 'تعديل الجواب'
                                                      : 'اضافة الجواب',
                                                  onPressed: () {
                                                    _showAddReplyDialog(
                                                        context, notification);
                                                  },
                                                  hasHomework: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
