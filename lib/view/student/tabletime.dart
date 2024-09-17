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

class ClassSchedule extends StatefulWidget {
  @override
  _ClassScheduleState createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  int _currentDayIndex = 0; // يمثل اليوم الأول (الأحد) كافتراضيًا

  // final List<Map<String, String>> schedule = [
  //   {
  //     "day": "الأحد",
  //     "الحصة الاولى": "عربي",
  //     "الحصة الثانية": "عربي",
  //     "الحصة الثالثة": "عربي"
  //   },
  //   {
  //     "day": "الاثنين",
  //     "الحصة الاولى": "عربي",
  //     "الحصة الثانية": "عربي",
  //     "الحصة الثالثة": "عربي"
  //   },
  //   {
  //     "day": "الثلاثا",
  //     "الحصة الاولى": "عربي",
  //     "الحصة الثانية": "عربي",
  //     "الحصة الثالثة": "عربي"
  //   },
  //   {"day": "الاربعاء", "الحصة الاولى": "ل"},
  //   {"day": "الخميس", "الحصة الاولى": "ب"},
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TeacherTableVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_TABLE, 1);
  }

  @override
  Widget build(BuildContext context) {
    final TVM = Provider.of<TeacherTableVM>(context);
    return TVM.allTeacherTableList.isEmpty
        ? Center(
            child: Text("لا توجد بياتات"),
          )
        : Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                title: "مدرستي",
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
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
                                TVM.allTeacherTableList[_currentDayIndex]
                                    .theDay!,
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
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
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
