// // import 'package:collasable_drawer/wedgits/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/constant/appbar.dart';
// import 'package:graduation_project/data/view_modle/teacher_table_VM.dart';
// import 'package:graduation_project/repository/online_repo.dart';
// import 'package:graduation_project/utility/endpoints.dart';
// import 'package:graduation_project/utility/shared.dart';
// import 'package:provider/provider.dart';

// class ScheduleApp extends StatefulWidget {
//   @override
//   State<ScheduleApp> createState() => _ScheduleAppState();
// }

// class _ScheduleAppState extends State<ScheduleApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weekly Schedule',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WeeklySchedule(),
//     );
//   }
// }

// class WeeklySchedule extends StatefulWidget {
//   @override
//   _WeeklyScheduleState createState() => _WeeklyScheduleState();
// }

// class _WeeklyScheduleState extends State<WeeklySchedule> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<TeacherTableVM>(context, listen: false)
//         .getdata(OnlineRepo(), API_URL.TEACHER_TABLE, Shared.id!)
//         .then((value) {
//       daysOfWeek = value.keys.toList();
//     });
//   }

//   int _currentIndex = 0;
//   List<String> daysOfWeek = [
//     'الأحد',
//     'الاثنين',
//     'الثلاثاء',
//     'الأربعاء',
//     'خميس'
//   ];

//   // Map<String, List<List<String>>> scheduleData = {
//   //   'الأحد': [
//   //     ['8:00 AM', 'Class 1', 'حصة 1'],
//   //     ['9:00 AM', 'Class 2', 'حصة 2'],
//   //     ['10:00 AM', 'Class 3', 'حصة 3'],
//   //   ],
//   //   'الاثنين': [
//   //     ['8:00 AM', 'Class 1', 'حصة 1'],
//   //     ['9:00 AM', 'Class 2', 'حصة 2'],
//   //     ['10:00 AM', 'Class 3', 'حصة 3'],
//   //     ['11:00 AM', 'Class 4', 'حصة 4'],
//   //   ],
//   //   'الثلاثاء': [
//   //     ['8:00 AM', 'Class 1', 'حصة 1'],
//   //     ['9:00 AM', 'Class 2', 'حصة 2'],
//   //     ['10:00 AM', 'Class 3', 'حصة 3'],
//   //     ['11:00 AM', 'Class 4', 'حصة 4'],
//   //     ['12:00 PM', 'Class 5', 'حصة 5'],
//   //   ],
//   //   'الأربعاء': [
//   //     ['8:00 AM', 'Class 1', 'حصة 1'],
//   //     ['9:00 AM', 'Class 2', 'حصة 2'],
//   //     ['10:00 AM', 'Class 3', 'حصة 3'],
//   //     ['11:00 AM', 'Class 4', 'حصة 4'],
//   //     ['12:00 PM', 'Class 5', 'حصة 5'],
//   //     ['1:00 PM', 'Class 6', 'حصة 6'],
//   //   ],
//   //   'خميس': [
//   //     ['8:00 AM', 'Class 1', 'حصة 1'],
//   //     ['9:00 AM', 'Class 2', 'حصة 2'],
//   //     ['10:00 AM', 'Class 3', 'حصة 3'],
//   //     ['11:00 AM', 'Class 4', 'حصة 4'],
//   //     ['12:00 PM', 'Class 5', 'حصة 5'],
//   //     ['1:00 PM', 'Class 6', 'حصة 6'],
//   //     ['2:00 PM', 'Class 7', 'حصة 7'],
//   //   ],
//   // };

//   void _previousDay() {
//     setState(() {
//       _currentIndex = (_currentIndex - 1) % daysOfWeek.length;
//       if (_currentIndex < 0) _currentIndex = daysOfWeek.length - 1;
//     });
//   }

//   void _nextDay() {
//     setState(() {
//       _currentIndex = (_currentIndex + 1) % daysOfWeek.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TTVM = Provider.of<TeacherTableVM>(context);
//     return TTVM.temp.isEmpty
//         ? Center(
//             child: Text("no yet"),
//           )
//         : Directionality(
//             textDirection: TextDirection.rtl,
//             child: Scaffold(
//               appBar: CustomAppBar(
//                 title: 'جدول الأسبوع',
//               ),
//               body: Center(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: _previousDay,
//                           color: Colors.blueAccent, // لون الأيقونة
//                         ),
//                         Text(
//                           daysOfWeek[_currentIndex],
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_forward),
//                           onPressed: _nextDay,
//                           color: Colors.blueAccent, // لون الأيقونة
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: List.generate(
//                             TTVM.temp[daysOfWeek[_currentIndex]]!.length,
//                             (index) => Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 8.0, horizontal: 5),
//                               child: Card(
//                                 color: (index + 1) % 2 == 0
//                                     ? Colors.indigo
//                                     : Colors.lightBlue
//                                         .shade50, // تحديد لون الكارد بناءً على رقم الحصة
//                                 elevation: 5,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       _buildScheduleButton(
//                                           '${index + 1}'), // رقم الحصة
//                                       SizedBox(width: 10),
//                                       _buildScheduleButton(TTVM.temp[
//                                               daysOfWeek[_currentIndex]]![index]
//                                           [1]), // اسم الصف
//                                       SizedBox(width: 10),
//                                       _buildScheduleButton(TTVM.temp[
//                                               daysOfWeek[_currentIndex]]![index]
//                                           [0]), // الساعة
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }

//   Widget _buildScheduleButton(String text) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: EdgeInsets.all(8),
//       child: Text(
//         text,
//         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/data/modle/teacher_table.dart';
import 'package:graduation_project/data/view_modle/teacher_attendentVM.dart';
import 'package:graduation_project/data/view_modle/teacher_table_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/style/fontstyle.dart';
import 'package:graduation_project/style/list.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:provider/provider.dart';

class WeeklySchedule extends StatefulWidget {
  @override
  _ClassScheduleState createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<WeeklySchedule> {
  int _currentDayIndex = 0; // يمثل اليوم الأول (الأحد) كافتراضيًا

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feachDate();
  }

  feachDate() async {
    await Provider.of<TeacherTableVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.TEACHER_TABLE, Shared.id!);
  }

  @override
  Widget build(BuildContext context) {
    final TVM = Provider.of<TeacherTableVM>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "مدرستي",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade400,
                  Colors.blue.shade400,
                  Colors.indigo.shade800,
                ],
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_currentDayIndex > 0) {
                                _currentDayIndex--;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.blue.shade900,
                        ),
                        Text(
                          TVM.allTeacherTableList[_currentDayIndex].theDay!,
                          style: fontstyle.fontheading,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_currentDayIndex <
                                  TVM.allTeacherTableList.length - 1) {
                                _currentDayIndex++;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Colors.blue.shade900,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: TVM.allTeacherTableList[_currentDayIndex]
                          .periods!.length, // يحسب عدد الحصص
                      itemBuilder: (context, index) {
                        // final session = TVM.allTeacherTableList[_currentDayIndex].
                        //     .keys
                        //     .elementAt(index + 1);
                        final subject = TVM
                            .allTeacherTableList[_currentDayIndex]
                            .periods![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              subject,
                              style: fonttitlestyle.fonttitle,
                            ),
                            trailing: Text(
                              "الحصة ${index + 1}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade400),
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
        ),
      ),
    );
  }
}
