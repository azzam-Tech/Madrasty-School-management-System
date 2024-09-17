import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/view/student/components/drawer/custom_drawer.dart';

class bookpdf extends StatelessWidget {
  late TeacherClass subject;
  bookpdf({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(
          title: "الكتاب",
        ),
        drawer: CustomDrawer(
          subject: subject,
        ),
      ),
    );
  }
}
