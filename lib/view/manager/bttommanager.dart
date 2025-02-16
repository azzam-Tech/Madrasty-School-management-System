import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/data/view_modle/eealuatio_VM.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/view/manager/attendmanager.dart';
import 'package:graduation_project/view/manager/evaluation.dart';
import 'package:graduation_project/view/manager/notivicatio.dart';
import 'package:graduation_project/view/manager/waners.dart';
import 'package:graduation_project/view/teacher/tabbar/profile/profile.dart';
class tabsmanager extends StatefulWidget {
  @override
  _tabsmanagerState createState() => _tabsmanagerState();
}

class _tabsmanagerState extends State<tabsmanager> {
  int _currentIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: [
              NotificationManagers(),
              Winer(),
              attendmanager(),
              EvaluationManager(),
              Profileteacher(),
            ],
          ),
          bottomNavigationBar: Container(
            height: displayWidth * .16,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade700,
                  Colors.blue.shade700,
                  Colors.blue.shade900
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                listOfIcons.length,
                (index) => GestureDetector(
                  onTap: () {
                    _onTabChange(index);
                    HapticFeedback.lightImpact();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        listOfIcons[index],
                        color: _currentIndex == index
                            ? Colors.black
                            : Colors.white,
                        size: 28,
                      ),
                      SizedBox(height: 5),
                      Text(
                        listOfStrings[index],
                        style: TextStyle(
                          color: _currentIndex == index
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.notifications,
    Icons.star,
    Icons.check_box,
    Icons.my_library_books,
    Icons.person,
  ];

  List<String> listOfStrings = [
    'الاشعارات',
    'الاوائل',
    'التحضير',
    'تقرير التقييم',
    'حسابي',
  ];
}
