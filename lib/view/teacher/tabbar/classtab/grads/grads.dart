// import 'package:collasable_drawer/wedgits/appbar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/grad_vm.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/buttoncolor.dart';
import 'package:graduation_project/view/teacher/components/drawer/custom_drawer.dart';
import 'package:graduation_project/data/modle/grad.dart';
import 'package:provider/provider.dart';

class StudentMarksPage extends StatefulWidget {
  StudentMarksPage({required this.instanc});
  TeacherClass instanc;
  @override
  _StudentMarksPageState createState() => _StudentMarksPageState();
}

class _StudentMarksPageState extends State<StudentMarksPage> {
  late Future<List<Grad>> futureStudents;
  TextEditingController searchController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  late List<Grad> originalStudents;
  List<Grad> filteredStudents = [];
  bool showNoResults = false;
  int _selectedOption = 0;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  Future<List<Grad>> fetchStudents() async {
    debugPrint(
        "${API_URL.STUDENT_DEGREES}/${widget.instanc.subjectClassId}/${_selectedOption + 1}");
    originalStudents = await Provider.of<GradVM>(context, listen: false).getdata(
        OnlineRepo(),
        "${API_URL.STUDENT_DEGREES}/${widget.instanc.subjectClassId}/${_selectedOption + 1}",
        widget.instanc.classId!);
    debugPrint("originalStudents : $originalStudents");
    filteredStudents = originalStudents;

    //     .then((value) {

    //   filteredStudents = value;

    //   setState(() {});
    // });
    return filteredStudents;
    // final response = await http.get(
    //     Uri.parse('https://my.api.mockaroo.com/students_marks?key=7bf0ba50'));

    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = json.decode(response.body);
    //   List<Grad> students =
    //       jsonData.map((e) => Student.fromJson(e)).toList();
    //   setState(() {
    //     originalStudents = students;
    //     filteredStudents = List.from(originalStudents);
    //   });
    //   return students;
    // } else {
    //   throw Exception('Failed to load students');
    // }
  }

  List<String> options = [
    'االشهر الاول',
    'الشهر الثاني',
    ' الفصل الاول',
    'الشهر الثالث',
    'الشهر الرابع',
    'النهائي',
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          // Hide keyboard when tapping anywhere on the screen
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appbarchild(
            title: 'درجات الطلاب',
          ),
          drawer: CustomDrawer(instanc: widget.instanc),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .60,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton(
                              isExpanded: true, // لجعل القائمة تمتد عبر العرض
                              value: _selectedOption,
                              onChanged: (newValue) {
                                setState(() {
                                  futureStudents = fetchStudents();
                                  _selectedOption = newValue as int;
                                });
                              },
                              items: options.map((option) {
                                return DropdownMenuItem(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        option,
                                        // style: fonttitlestyle.fonttitle,
                                      ),
                                    ],
                                  ),
                                  value: options.indexOf(option),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showNoResults)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('لاتوجد نتائج'),
                ),
              Expanded(
                child: FutureBuilder<List<Grad>>(
                  future: futureStudents,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = filteredStudents[index];

                            return Card(
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Displaying the student's name on the right
                                  Expanded(
                                    child: Text(
                                      '${student.studentName}:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // TextField for entering the student's mark on the left
                                  Expanded(
                                    child: TextField(
                                      // controller: degreeController
                                      //   ..text =
                                      //       "${student.studentDegreeValue}",
                                      onChanged: (value) {
                                        originalStudents[index]
                                                .studentDegreeValue =
                                            double.parse(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            "${student.studentDegreeValue}",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text('لاتوجد بيانات'),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: CustomGradientButton(
                  buttonText: 'حفظ',
                  onPressed: () async {
                    originalStudents =
                        await Provider.of<GradVM>(context, listen: false)
                            .sendDate(OnlineRepo(),
                                API_URL.STUDENT_DEGREES_EIDT, originalStudents);
                    filteredStudents = originalStudents;
                    setState(() {});
                    // originalStudents.forEach((value) {
                    //   debugPrint("degree :${value.studentDegreeValue} ");
                    // });
                    //   Navigator.of(context).push(PageTransition(
                    //     type: PageTransitionType.leftToRight,
                    //     duration: Duration(milliseconds: 600),
                    //     reverseDuration:
                    //         Duration(microseconds: 600),
                    //     child: ViewHomeworkTabtest(),
                    //   ));
                  },
                  hasHomework: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Student {
//   late int id;
//   late String firstName;
//   late String lastName;
//   late double month1;
//   late double month2;
//   late double finalExam;

//   Student({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.month1,
//     required this.month2,
//     required this.finalExam,
//   });

//   factory Student.fromJson(Map<String, dynamic> json) {
//     return Student(
//       id: json['id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       month1: json['month1'],
//       month2: json['month2'],
//       finalExam: json['final'],
//     );
//   }
// }
