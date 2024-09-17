// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:graduation_project/constant/appbarchild.dart';
// import 'package:graduation_project/constant/fontstyle.dart';

// import 'drawer/custom_drawer.dart';

// class Gradparent extends StatefulWidget {
//   @override
//   _GradparentState createState() => _GradparentState();
// }

// class _GradparentState extends State<Gradparent> {
//   int _selectedOption = 0; // الخيار المحدد الافتراضي

//   List<String> options = [
//     'االشهر الاول',
//     'الشهر الثاني',
//     ' النهائي الاول',
//     'الشهر الاول',
//     'الشهر الثتاني',
//     'النهائي الثاني',
//   ];

//   // قائمة المواد والدرجات
//   List<Map<String, dynamic>> subjectsAndGrades = [
//     {"subject": "Math", "grade": 90},
//     {"subject": "Science", "grade": 85},
//     {"subject": "History", "grade": 78},
//     {"subject": "English", "grade": 92},
//     {"subject": "Art", "grade": 88},
//     {"subject": "Geography", "grade": 75},
//     {"subject": "Physics", "grade": 80},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         // appBar: appbarchild(title: "مدرسي",),
//         drawer: Drawerparent(),
//         body: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * .60,
//                 child: Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: DropdownButton(
//                     isExpanded: true, // لجعل القائمة تمتد عبر العرض
//                     value: _selectedOption,
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedOption = newValue as int;
//                       });
//                     },
//                     items: options.map((option) {
//                       return DropdownMenuItem(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               option,
//                               style: fonttitlestyle.fonttitle,
//                             ),
//                           ],
//                         ),
//                         value: options.indexOf(option),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: subjectsAndGrades.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         elevation: 4,
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         child: ListTile(
//                           title: Text(
//                             subjectsAndGrades[index]['subject'],
//                             style: fonttitlestyle.fonttitle,
//                           ),
//                           trailing: Text(
//                             '${subjectsAndGrades[index]['grade']}',
//                             style: fonttitlestyle.fonttitle,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/childern.dart';
import 'package:graduation_project/data/modle/grad.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/grad_vm.dart';
import 'package:graduation_project/data/viewmdles.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  final Function(String) onChanged;
  final bool noResults;

  SearchBar({
    required this.controller,
    required this.onChanged,
    this.noResults = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 10,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.black),
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: 'ابحث...',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onChanged(controller.text);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          if (noResults)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('لا توجد نتائج', style: fontstyle.fontheading),
              ),
            ),
        ],
      ),
    );
  }
}

class Gradparent extends StatefulWidget {
  Gradparent({required this.child});
  late Childern child;
  @override
  _StudentMarks_SVState createState() => _StudentMarks_SVState();
}

class _StudentMarks_SVState extends State<Gradparent> {
  String _searchText = '';
  List<Grad> grads = [];
  List<Grad> gradsTemp = [];
  TextEditingController _searchController = TextEditingController();
  int _selectedOption = 0;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    featchData();
  }

  featchData() async {
    String suorce = Shared.role == "teacher"
        ? API_URL.STUDENT_DEGREES_BY_SUPER
        : API_URL.STUDENT_DEGREES_BY_STUDENT;
    grads = await Provider.of<GradVM>(context, listen: false).getdata2(
        OnlineRepo(),
        suorce,
        Shared.role == "teacher"
            ? widget.child.studentId!
            : widget.child.studentId!);
    filteredSubjectsAndGrades2(1);
    setState(() {});
  }

  List<String> options = [
    'االشهر الاول',
    'الشهر الثاني',
    ' الفصل الاول',
    'الشهر الاول',
    'الشهر الثتاني',
    'النهائي',
  ];

  List<Grad> get filteredSubjectsAndGrades {
    if (_searchText.isEmpty) {
      return Provider.of<GradVM>(context, listen: false).allGradList2;
    } else {
      return Provider.of<GradVM>(context, listen: false)
          .allGradList
          .where((student) => student.studentName!
              .toLowerCase()
              .contains(_searchText.toLowerCase()))
          .toList();
    }
  }

  List<Grad> filteredSubjectsAndGrades2(int type) {
    gradsTemp =
        grads.where((element) => element.degreeTypeId == (type + 1)).toList();
    setState(() {});
    return gradsTemp;
    // if (_searchText.isEmpty) {
    //   return Provider.of<GradVM>(context, listen: false).allGradList2;
    // } else {
    //   return Provider.of<GradVM>(context, listen: false)
    //       .allGradList
    //       .where((student) => student.studentName!
    //           .toLowerCase()
    //           .contains(_searchText.toLowerCase()))
    //       .toList();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final GVM = Provider.of<GradVM>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: appbarchild(
        //   title: "مدرسي",
        // ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .60,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selectedOption,
                    onChanged: (newValue) {
                      setState(() {
                        filteredSubjectsAndGrades2(newValue!);

                        _selectedOption = newValue as int;
                      });
                    },
                    items: options.map((option) {
                      return DropdownMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: fonttitlestyle.fonttitle,
                            ),
                          ],
                        ),
                        value: options.indexOf(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // SearchBar(
              //   controller: _searchController,
              //   onChanged: (text) {
              //     setState(() {
              //       _searchText = text;
              //     });
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الاسم',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'الدرجات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: gradsTemp.length,
                  itemBuilder: (BuildContext context, int index) {
                    final student = gradsTemp[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Shared.role == "teacher"
                                    ? student.studentName!
                                    : student.subjectName!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${student.studentDegreeValue}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
