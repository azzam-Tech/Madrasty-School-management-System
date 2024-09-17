import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/custom_tab.dart';
import 'package:graduation_project/data/modle/childern.dart';
import 'package:graduation_project/view/parent/attendparent.dart';
import 'package:graduation_project/view/parent/drawer/custom_drawer.dart';
import 'package:graduation_project/view/parent/grads.dart';

class detalischild extends StatefulWidget {
  Childern child ;

  detalischild({Key? key,required this.child}) : super(key: key);

  @override
  State<detalischild> createState() => _detalischildState();
}

class _detalischildState extends State<detalischild> {
  int _selectedTag = 0;

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: "مدرستي",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Column(
              children: [
                Container(
                  child: CustomTabView(
                      activeText: Colors.white,
                      changeTab: changeTab,
                      index: _selectedTag,
                      tags: ["تحضير", "درجات"]),
                ),
                _selectedTag == 0
                    ? Expanded(child: attendparent(child: widget.child,))
                    : Expanded(child: Gradparent(child: widget.child,))
              ],
            ),
          ),
          // drawer: Drawerparent(),
        ),
      ),
    );
  }
}
