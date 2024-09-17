import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/report.dart';
import 'package:graduation_project/data/view_modle/report_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/style/list.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<DateTime> weekDays;
  List<Report> allRepot = [];
  late int currentIndex;
  DateTime crurrentDate = DateTime.now();
  List<Map<String, String>> filteredSubjects = [];
  @override
  void initState() {
    super.initState();
    feachData();
    weekDays = generateWeekDays();
    currentIndex = DateTime.now().weekday - 1;
  }

  feachData() async {
    allRepot = await Provider.of<ReportVM>(context, listen: false).getdata2(
        OnlineRepo(),
        API_URL.STUDENT_FOLLOW_UP,
        Shared.studentClassId!,
        "${crurrentDate}".split(" ").first);
  }

  List<DateTime> generateWeekDays() {
    DateTime now = DateTime.now();
    int todayIndex = now.weekday;
    List<DateTime> days = [];

    for (int i = 1; i <= 7; i++) {
      days.add(now.subtract(Duration(days: todayIndex - i)));
    }
    debugPrint("$days");
    return days;
  }

  Future<void> moveToNextDay() async {
    // if (currentIndex < 6) {
    // setState(() async {
    // currentIndex++;
    crurrentDate = crurrentDate.add(Duration(days: 1));
    await feachData();
    setState(() {});
    // });
    // }
  }

  Future<void> moveToPreviousDay() async {
    // if (currentIndex > 0) {
    // setState(()  {
    // currentIndex--;
    crurrentDate = crurrentDate.add(Duration(days: -1));
    await feachData();
    setState(() {});
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "مدرستي",
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .74,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade700,
                  Colors.blue.shade700,
                  Colors.blue.shade900
                ],
              ),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: moveToNextDay,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                        DateFormat('EEEE, d MMMM yyyy', 'ar')
                            // .format(weekDays[currentIndex]),
                            .format(crurrentDate),
                        style: fontwhite.fonttitle),
                    IconButton(
                      onPressed: moveToPreviousDay,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: allRepot.length,
                    itemBuilder: (context, index) {
                      final subject = allRepot[index];
                      final subjectName = subject.subjectName!;
                      final lessonName = subject.followUpNoteBookText!;
                      return allRepot.isEmpty
                          ? Center(
                              child: Text("لا توجد ملاحظات"),
                            )
                          : SubjectListItem(
                              subjectName: subjectName,
                              lessonName: lessonName,
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectListItem extends StatefulWidget {
  final String subjectName;
  final String lessonName;

  SubjectListItem({
    required this.subjectName,
    required this.lessonName,
  });

  @override
  _SubjectListItemState createState() => _SubjectListItemState();
}

class _SubjectListItemState extends State<SubjectListItem> {
  bool isCardHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCardHighlighted = !isCardHighlighted;
          });
        },
        child: Card(
          elevation: 5,
          // color: Colors.indigo[500],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),

          child: ExpansionTile(
            title: Center(
              child: Text(widget.subjectName, style: fontstyle.fontheading),
            ),
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text(widget.lessonName, style: fonttitlestyle.fonttitle),
                ),
              ),
            ],
            tilePadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            collapsedTextColor: Colors.black,
            collapsedIconColor: Colors.red[900],
            textColor: Colors.indigo[900],
            iconColor: Colors.indigo[900],
          ),
        ),
      ),
    );
  }
}
