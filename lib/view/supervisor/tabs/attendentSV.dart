// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/drawer/show_snack_bar.dart';
import 'package:graduation_project/constant/searchBar.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/student_attendent.dart';
import 'package:graduation_project/data/view_modle/student_attendentVM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:graduation_project/view/supervisor/component/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class attendentSV extends StatefulWidget {
  @override
  _attendentSVState createState() => _attendentSVState();
}

class _attendentSVState extends State<attendentSV> {
  final TextEditingController _searchController = TextEditingController();
  bool _isBackPressed = false;
  List<String> names = ['أحمد', 'فاطمة', 'يوسف'];
  Map<String, bool> checkbox1Status = {};
  Map<String, bool> checkbox2Status = {};
  List<StudentAttendent> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkbox states
    for (String name in names) {
      checkbox1Status[name] = false;
      checkbox2Status[name] = false;
    }
    // _filteredNames = names; // Start with all names displayed
    feacthData();
  }

  Future<void> feacthData() async {
    await Provider.of<StudentAttendentVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_ATTENDENT, Shared.classId!);
    _filteredNames = Provider.of<StudentAttendentVM>(context, listen: false)
        .allStudentAttendnetList;
    setState(() {});
  }

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = Provider.of<StudentAttendentVM>(context, listen: false)
            .allStudentAttendnetList; // Show all names if query is empty
      } else {
        _filteredNames = Provider.of<StudentAttendentVM>(context, listen: false)
            .allStudentAttendnetList
            .where((name) => name.studentName!.contains(query))
            .toList();
      }
    });
  }

  Future<void> _saveAttendance(BuildContext content) async {
    final vvv = Provider.of<StudentAttendentVM>(context, listen: false);
    await vvv.sendDate(OnlineRepo(), API_URL.STUDENT_ATTENDENT_CREATE,
        vvv.allStudentAttendnetList);
    showSnackBar(context, "تم التحضير", true);
  }

  @override
  _cancelAttendance() {
    setState(() {
      for (String name in names) {
        checkbox1Status[name] = false;
        checkbox2Status[name] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final STVM = Provider.of<StudentAttendentVM>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: appbarchild(
            title: "تحضير االطلاب",
          ),
          drawer: CustomDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  searchBar(
                    controller: _searchController,
                    onChanged: _filterNames,
                    // noResults: _filteredNames.isEmpty &&
                    //     _searchController.text.isNotEmpty,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredNames.length,
                  itemBuilder: (context, index) {
                    StudentAttendent student =
                        STVM.allStudentAttendnetList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  student.studentName!,
                                  textAlign: TextAlign.right,
                                  style: fonttitlestyle.fonttitle,
                                ),
                              ),
                              Checkbox(
                                value: student.studentAttendanceValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    // checkbox1Status[student.studentName!] =
                                    //     value ?? false;
                                    STVM.triger(index);
                                  });
                                },
                                activeColor: Colors.green[700],
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                              ),
                              Text(
                                student.studentAttendanceValue!
                                    ? 'حاضر'
                                    : "غائب",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: student.studentAttendanceValue!
                                      ? Colors.green[500]
                                      : Colors.red[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Checkbox(
                              //   value: checkbox2Status[name] ?? false,
                              //   onChanged: (bool? value) {
                              //     setState(() {
                              //       checkbox2Status[name] = value ?? false;
                              //     });
                              //   },
                              //   activeColor: Colors.red[900],
                              //   shape: const RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.only(
                              //       topLeft: Radius.circular(5),
                              //       bottomRight: Radius.circular(5),
                              //     ),
                              //   ),
                              // ),
                              // Text(
                              //   'غائب',
                              //   style: TextStyle(
                              //     fontSize: 16.0,
                              //     color: Colors.red[500],
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
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
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _saveAttendance(context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade900, Colors.blue],
                      ),
                    ),
                    child: Center(
                      child: Text(' حفظ', style: fontwhite.fonttitle),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _cancelAttendance();
                //     });
                //   },
                //   child: Container(
                //     width: MediaQuery.of(context).size.width / 4,
                //     height: MediaQuery.of(context).size.height / 20,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       gradient: LinearGradient(
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //         colors: [Colors.blue.shade900, Colors.blue],
                //       ),
                //     ),
                //     child: Center(
                //       child: Text('الغاء', style: fontwhite.fonttitle),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// apppbar|||||||||||||||||||||||||||||||||||||||||||||||||||||


