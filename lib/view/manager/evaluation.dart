import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/searchbar.dart';

import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/evaluatio.dart';
import 'package:graduation_project/data/view_modle/eealuatio_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:provider/provider.dart'; // استيراد واجهة البحث

class EvaluationManager extends StatefulWidget {
  const EvaluationManager({Key? key}) : super(key: key);

  @override
  State<EvaluationManager> createState() => _EvaluationManagerState();
}

class _EvaluationManagerState extends State<EvaluationManager> {
  bool _showBestTeachers = true;
  bool _showWorstTeachers = false;
  String _selectedTerm = 'الاعلى';
  TextEditingController _searchController = TextEditingController();
  List<Evaluatio> teachers = [];
  //   {'name': 'أحمد', 'performanceRating': 40, 'styleRating': 30},
  //   {'name': 'عبير برك', 'performanceRating': 70, 'styleRating': 80},
  //   {'name': 'عبير عبدالله', 'performanceRating': 60, 'styleRating': 55},
  //   {'name': 'فاطمة', 'performanceRating': 80, 'styleRating': 70},
  //   {'name': 'بن عبير برك', 'performanceRating': 70, 'styleRating': 80},
  //   {'name': 'عبير عبدالله', 'performanceRating': 60, 'styleRating': 55},
  //   {'name': 'غلا', 'performanceRating': 100, 'styleRating': 70},
  //   {'name': 'عبير برك', 'performanceRating': 70, 'styleRating': 80},
  //   {'name': 'عبير عبدالله', 'performanceRating': 60, 'styleRating': 55},
  //   {'name': 'فاطمة', 'performanceRating': 80, 'styleRating': 70},
  //   {'name': 'عبير برك', 'performanceRating': 70, 'styleRating': 80},
  //   {'name': 'عبير عبدالله', 'performanceRating': 60, 'styleRating': 55},
  //   {'name': 'فاطمة', 'performanceRating': 80, 'styleRating': 70},
  //   {'name': 'علي', 'performanceRating': 20, 'styleRating': 40},
  // ];

  String _searchText = ''; // تعريف المتغير _searchText

  @override
  void initState() {
    super.initState();
    featdate();
    _selectedTerm = 'الاعلى';
  }

  featdate() async {
    teachers = await Provider.of<EvaluatioVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.TEACHER_EAVLUATION);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: "مدرستي"),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchBar(
                  controller: _searchController,
                  onChanged: _filterTeachers,
                  noResults:
                      _searchController.text.isNotEmpty && teachers.isEmpty,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showBestTeachers = true;
                          _showWorstTeachers = false;
                          _selectedTerm = 'الاعلى';
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _selectedTerm == 'الاعلى'
                                  ? Colors.blue.shade900
                                  : Colors.blue.shade200,
                              _selectedTerm == 'الاعلى'
                                  ? Colors.blue
                                  : Colors.grey,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text('الاعلى', style: fontwhite.fonttitle),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showWorstTeachers = true;
                          _showBestTeachers = false;
                          _selectedTerm = 'الاقل';
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _selectedTerm == 'الاقل'
                                  ? Colors.blue.shade900
                                  : Colors.blue.shade200,
                              _selectedTerm == 'الاقل'
                                  ? Colors.blue
                                  : Colors.grey,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text('الاقل', style: fontwhite.fonttitle),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade400,
                          Colors.blue.shade400,
                          Colors.indigo.shade800,
                        ],
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildTeacherList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _filterTeachers(String query) {
    setState(() {
      _searchText = query;
    });
  }

  Widget _buildTeacherList() {
    final TVM = Provider.of<EvaluatioVM>(context);
    List<Evaluatio> filteredTeachers = _showBestTeachers
        ? TVM.allEvaluatioList.where((teacher) {
            String name = teacher.userName!;
            return name.contains(_searchText);
          }).toList()
        : TVM.allEvaluatioList.reversed.where((teacher) {
            String name = teacher.userName!;
            return name.contains(_searchText);
          }).toList();

    if (filteredTeachers.isEmpty && _searchText.isNotEmpty) {
      return Center(
        child: Text(
          'لا توجد نتائج',
          style: fontstyle.fontheading,
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredTeachers.length,
      itemBuilder: (BuildContext context, int index) {
        List<String> namePart = filteredTeachers[index].userName!.split(" ");
        String teacherName = "${namePart.first} ${namePart.last}";
        double performanceFeedback =
            filteredTeachers[index].teacherEvaluationValueOne!;
        double styleFeedback =
            filteredTeachers[index].teacherEvaluationValueTow!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    teacherName,
                    style: fonttitlestyle.fonttitle,
                  ),
                  const SizedBox(height: 8),
                  Text('الأداء: $performanceFeedback'),
                  Text('الأسلوب: $styleFeedback'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
