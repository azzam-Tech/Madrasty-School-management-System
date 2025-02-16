

import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/view/teacher/components/drawer/custom_drawer.dart';
import 'package:graduation_project/view/teacher/tabbar/test.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  bool _isCollapsed = false;
  int _currentTabIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   iconTheme: const IconThemeData(color: Colors.black),
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        // ),
        drawer:  CustomDrawer(instanc:  TeacherClass()),
        body: tabcontent(_currentTabIndex),
      ),
    );
  }
}

class tabcontent extends StatelessWidget {
  final int currentTabIndex;

  tabcontent(this.currentTabIndex);

  @override
  Widget build(BuildContext context) {
    if (currentTabIndex == 0) {
      return tabcontent(this.currentTabIndex);
    } 
    else {
      // Add more conditions for additional tabs
      return Placeholder(); // Placeholder content
    }
  }
}
