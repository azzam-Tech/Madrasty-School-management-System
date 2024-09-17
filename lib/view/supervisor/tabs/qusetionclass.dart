import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/Suggestions.dart';
import 'package:graduation_project/data/view_modle/suggestionVM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/buttoncolor.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/view/supervisor/component/drawer/custom_drawer.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// class Notification {
//   final String studentName;
//   final String studentAvatarUrl;
//   final String date;
//   final String body;
//   String? reply;

//   Notification({
//     required this.studentName,
//     required this.studentAvatarUrl,
//     required this.date,
//     required this.body,
//     this.reply,
//   });
// }

class viewquestionclass extends StatefulWidget {
  @override
  _viewquestionclassState createState() => _viewquestionclassState();
}

class _viewquestionclassState extends State<viewquestionclass> {
  late List<Suggestions> originalNotifications;
  List<Suggestions> filteredNotifications = [];
  late TextEditingController searchController;
  bool showNoResults = false;

  Future<void> fetchNotifications() async {
    final response = await Provider.of<SuggestionVN>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_SUGGESTION, 1);

    // await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    // if (response.statusCode == 200) {
    // final List<dynamic> jsonData = json.decode(response.body);
    setState(() {
      originalNotifications = response;
      // originalNotifications = jsonData.map((item) {
      //   return Notification(
      //     studentName: item['title'],
      //     studentAvatarUrl: 'https://example.com/avatar.png',
      //     date: '2024-04-01',
      //     body: item['body'],
      //   );
      // }).toList();
      filteredNotifications = List.from(originalNotifications);
    });
    // }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    searchController = TextEditingController();
  }

  // void _showAddReplyDialog(BuildContext context, Suggestions notification) {
  //   TextEditingController replyController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(notification.studentSuggestionText != null ? 'تعديل الرد' : 'اضافة رد'),
  //         content: TextField(
  //           controller: replyController..text = notification.reply ?? '',
  //           decoration: InputDecoration(hintText: "اكتب ردك هنا"),
  //           maxLines: 3,
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('الغاء'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text(notification.reply != null ? 'تعديل' : 'ارسال'),
  //             onPressed: () async {
  //               String reply = replyController.text;
  //               if (reply.isNotEmpty) {
  //                 setState(() {
  //                   notification.reply = reply;
  //                 });
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appbarchild(title: 'اقتراحات الطلاب'),
          drawer: CustomDrawer(),
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
                                        List.from(originalNotifications);
                                    showNoResults = false;
                                  } else {
                                    filteredNotifications =
                                        originalNotifications
                                            .where((notification) =>
                                                notification.studentName!
                                                    .contains(value))
                                            .toList();
                                    showNoResults =
                                        filteredNotifications.isEmpty;
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
                        if (showNoResults)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'لا توجد نتائج',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredNotifications.length,
                            itemBuilder: (context, index) {
                              var notification = filteredNotifications[index];
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
                                            backgroundImage:
                                                AssetImage("img/biology.jpg"),
                                          ),
                                          title: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              notification.studentName!,
                                              style: fonttitlestyle.fonttitle,
                                            ),
                                          ),
                                          subtitle: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              notification
                                                  .studentSuggestionDate!,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          notification.studentSuggestionText!,
                                          style: fonttitlestyle.fonttitle,
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
