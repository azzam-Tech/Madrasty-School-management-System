// import 'package:collasable_drawer/class/tclass.dart';
// import 'package:collasable_drawer/screens/home/drawer.dart';
// import 'package:collasable_drawer/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/teacher_class_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:graduation_project/view/teacher/book.dart';
// import 'package:graduation_project/view/teacher/class/tclass.dart';
// import 'package:graduation_project/view/teacher/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'buttoncolor.dart';

class teacherclass extends StatefulWidget {
  @override
  State<teacherclass> createState() => _teacherclassState();
}

class _teacherclassState extends State<teacherclass> {
  @override
  void initState() {
    debugPrint("test");
    debugPrint("${API_URL.CLASSES}/${Shared.id}");
    Provider.of<TeacherClassVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.TEACHER_CLASSES, Shared.id!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TCVM = Provider.of<TeacherClassVM>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teacher Classes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ClassButtonGrid(TCVM.allTeacherClassList),
      ),
    );
  }
}

class ClassButtonGrid extends StatelessWidget {
  final List<TeacherClass> teacherClasses;

  ClassButtonGrid(this.teacherClasses);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3, // Adjust this value to control button height
      ),
      itemCount: teacherClasses.length,
      itemBuilder: (context, index) {
        final teacherClass = teacherClasses[index];
        return Padding(
          padding: const EdgeInsets.all(10.0), // Added horizontal padding

          child: CustomGradientButton(
            buttonText: teacherClass.subjectClassName!,
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                type: PageTransitionType.leftToRight,
                childCurrent: this,
                duration: Duration(milliseconds: 600),
                reverseDuration: Duration(microseconds: 600),
                child: book(instance: teacherClass,),
              ));
            },
          ),
        );
      },
    );
  }
}
