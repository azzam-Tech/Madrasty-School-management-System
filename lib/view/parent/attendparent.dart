// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:graduation_project/constant/appbarchild.dart';
// import 'package:graduation_project/constant/fontstyle.dart';
// import 'package:graduation_project/view/parent/drawer/custom_drawer.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class attendparent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           // appBar: appbarchild(title: "الحضور"),
//           drawer: Drawerparent(),
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: MyCard(),
//           ),
//         ));
//   }
// }

// class MyCard extends StatelessWidget {
//   final bool isAbsent = true; // قيمة تحدد ما إذا كانت "غائب"

//   @override
//   Widget build(BuildContext context) {
//     if (isAbsent) {
//       // حفظ التقرير اليومي إذا كان الحالة غائب
//       _saveDailyReport();
//     }

//     return isAbsent
//         ? Card(
//             elevation: 8,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     'غائب',
//                     style: TextStyle(fontSize: 20, color: Colors.red),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     _getFormattedDate(),
//                     style:fonttitlestyle.fonttitle,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     _getArabicDay(DateTime.now().weekday),
//                     style:fontstyle.fontheading,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : Container(); // لا يتم عرض أي شيء إذا كان isAbsent هو false
//   }

//   String _getArabicDay(int weekday) {
//     switch (weekday) {
//       case DateTime.saturday:
//         return 'السبت';
//       case DateTime.sunday:
//         return 'الأحد';
//       case DateTime.monday:
//         return 'الاثنين';
//       case DateTime.tuesday:
//         return 'الثلاثاء';
//       case DateTime.wednesday:
//         return 'الأربعاء';
//       case DateTime.thursday:
//         return 'الخميس';
//       case DateTime.friday:
//         return 'الجمعة';
//       default:
//         return '';
//     }
//   }

//   String _getFormattedDate() {
//     DateTime now = DateTime.now();
//     return '${now.day} - ${_getArabicMonth(now.month)} - ${now.year}'; // تنسيق التاريخ
//   }

//   String _getArabicMonth(int month) {
//     switch (month) {
//       case DateTime.january:
//         return '1';
//       case DateTime.february:
//         return '2';
//       case DateTime.march:
//         return '3';
//       case DateTime.april:
//         return '4';
//       case DateTime.may:
//         return '5';
//       case DateTime.june:
//         return '6';
//       case DateTime.july:
//         return '7';
//       case DateTime.august:
//         return '8';
//       case DateTime.september:
//         return '9';
//       case DateTime.october:
//         return '10';
//       case DateTime.november:
//         return '11';
//       case DateTime.december:
//         return '12';
//       default:
//         return '';
//     }
//   }

//   void _saveDailyReport() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String currentDateKey =
//         'daily_report_${DateTime.now().millisecondsSinceEpoch}'; // مفتاح فريد لكل تقرير يومي
//     Map<String, dynamic> report = {
//       'day': _getArabicDay(DateTime.now().weekday),
//       'date': _getFormattedDate(),
//       'status': 'غائب', // حالة الحضور تكون غائب إذا كان isAbsent هو true
//     };
//     String reportJson = jsonEncode(report);
//     await prefs.setString(currentDateKey, reportJson);
//   }
// }
import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/childern.dart';
import 'package:graduation_project/data/view_modle/teacher_attendentVM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class attendparent extends StatefulWidget {
  Childern child;
  attendparent({required this.child});
  @override
  State<attendparent> createState() => _attendteacherState();
}

class _attendteacherState extends State<attendparent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feachdate();
  }

  feachdate() async {
    await Provider.of<TeacherAttendetVN>(context, listen: false).getdata(
        OnlineRepo(),
        API_URL.STUDENT_ATTENDENT_BY_PAERNT,
        widget.child.studentId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TAVN = Provider.of<TeacherAttendetVN>(context);
    return
        // Directionality(
        //     textDirection: TextDirection.rtl,
        // child:
        Scaffold(
      // appBar: appbarchild(title: "الحضور"),
      body: TAVN.allTeacherAttendentList.isEmpty
          ? Center(
              child: Text("لا يو جد غياب"),
            )
          : Column(
              children: TAVN.allTeacherAttendentList
                  .map(
                    (element) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'غائب',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${element.studentAttendanceDate}"
                                    .split("T")
                                    .first,
                                style: fonttitlestyle.fonttitle,
                              ),
                              SizedBox(height: 20),
                              Text(
                                getDayOfWeek(DateFormat("yyyy-MM-dd")
                                    .parse("${element.studentAttendanceDate}")),
                                style: fontstyle.fontheading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  String getDayOfWeek(DateTime date) {
    List<String> daysOfWeek = [
      'الاحد',
      'الاثنين',
      'الثلاثاء',
      'الاربعاء',
      'الخميش',
      'الجمعه',
      'السبت'
    ];

    int dayIndex = date.weekday % 7;

    return daysOfWeek[dayIndex];
  }
}
