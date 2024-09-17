import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/Solutions.dart';
import 'package:graduation_project/data/modle/homework.dart';
import 'package:graduation_project/data/view_modle/Solution_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/view/pdf_leader.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/constant/appbarchild.dart';
import 'dart:convert';

import 'package:graduation_project/constant/buttoncolor.dart';
import 'package:graduation_project/constant/searchBar.dart';
import 'package:provider/provider.dart'; // Import the searchBar class

// class Homework {
//   final String studentName;
//   final String studentAvatarUrl;
//   final String date;

//   Homework({
//     required this.studentName,
//     required this.studentAvatarUrl,
//     required this.date,
//   });
// }

class ViewHomeworkTab extends StatefulWidget {
  ViewHomeworkTab({required this.instanc});
  HomeworkClass instanc;
  @override
  _ViewHomeworkTabState createState() => _ViewHomeworkTabState();
}

class _ViewHomeworkTabState extends State<ViewHomeworkTab> {
  late List<Solutions> originalHomeworks;
  List<Solutions> filteredHomeworks = [];
  late TextEditingController searchController;
  late TextEditingController _degreeController = TextEditingController();
  bool showNoResults = false;

  Future<List<Solutions>> fetchHomeworks() async {
    Provider.of<SolutionVm>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_SOLUTION_GET,
            widget.instanc.homeWorkId!)
        .then((vlau) {
      originalHomeworks = vlau;
      filteredHomeworks = List.from(originalHomeworks);
    });
    filteredHomeworks = List.from(originalHomeworks);
    // setState(() {});
    return originalHomeworks;
    // final response = await http.get(Uri.parse('https://my.api.mockaroo.com/stident_hw?key=7bf0ba50'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = json.decode(response.body);
    //   setState(() {
    //     originalHomeworks = jsonData.map((item) {
    //       return Homework(
    //         studentName: item['name'],
    //         studentAvatarUrl: item['profile_picture'],
    //         date: item['date'],
    //       );
    //     }).toList();
    //     filteredHomeworks = List.from(originalHomeworks);
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    // fetchHomeworks();
    searchController = TextEditingController();
  }

  void _searchHomeworks(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredHomeworks = List.from(originalHomeworks);
        showNoResults = false;
      } else {
        filteredHomeworks = originalHomeworks
            // .where((homework) => true)
            .where((homework) => homework.studentName!.contains(value))
            .toList();
        showNoResults = filteredHomeworks.isEmpty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: 'الواجبات المرسله'),
        body: SafeArea(
          child: Column(
            children: [
              searchBar(
                controller: searchController,
                onChanged: _searchHomeworks,
                noResults: showNoResults,
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<void>(
                  future: Provider.of<SolutionVm>(context, listen: false)
                      .getdata(OnlineRepo(), API_URL.STUDENT_SOLUTION_GET,
                          widget.instanc.homeWorkId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      filteredHomeworks =
                          Provider.of<SolutionVm>(context, listen: false)
                              .allSolutionsList;
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              showNoResults
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'لا توجد نتائج',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          (snapshot.data as List<Solutions>)
                                              .length,
                                      itemBuilder: (context, index) {
                                        debugPrint(
                                            "length ${filteredHomeworks.length}");
                                        filteredHomeworks = originalHomeworks =
                                            (snapshot.data as List<Solutions>);
                                        var homework = filteredHomeworks[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  // Material(
                                                  //   elevation: 5,
                                                  //   shape: CircleBorder(),
                                                  //   child: CircleAvatar(
                                                  //     backgroundImage:
                                                  //         NetworkImage(
                                                  //       homework.solutionFile!,
                                                  //     ),
                                                  //     radius: 30,
                                                  //     backgroundColor:
                                                  //         Colors.white,
                                                  //   ),
                                                  // ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      homework.studentName!,
                                                    ),
                                                  ),
                                                  Text(homework.solutionDate!),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Card(
                                                elevation: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      // Button to display student's homework
                                                      CustomGradientButton(
                                                        buttonText: "عرض الحل",
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      PDFledader(
                                                                          pdfLink:
                                                                              homework.solutionFile)));
                                                        },
                                                      ),
                                                      SizedBox(height: 10),
                                                      TextButton(
                                                          onPressed: () {
                                                            _degreeController
                                                                    .text =
                                                                "${homework.solutionDegree}";
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    content:
                                                                        TextFormField(
                                                                      controller:
                                                                          _degreeController,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        suffix:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            print("test ou");
                                                                            if (_degreeController.text !=
                                                                                ' ') {
                                                                              print("test in");

                                                                              homework = filteredHomeworks[index]..solutionDegree;
                                                                              homework.solutionDegree = double.parse(_degreeController.text.trim());
                                                                              await Provider.of<SolutionVm>(context, listen: false).editDate(OnlineRepo(), API_URL.SOLUTION_DEGREE, homework);
                                                                              _degreeController.clear();
                                                                              Navigator.pop(context);
                                                                              setState(() {});
                                                                            }
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.send_rounded,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        labelText:
                                                                            "اضف درجة",
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                      ),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty ||
                                                                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                                                          return 'ادخل رقم فقط';
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: Text(
                                                              "اضافة درجة : ${homework.solutionDegree}")),
                                                      // Text field for teacher to add homework mark
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      );
                    }
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

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ViewHomeworkTab(),
//   ));
// }
