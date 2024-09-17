import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/drawer/show_snack_bar.dart';

import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/evaluatio.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/eealuatio_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/view/student/components/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class RatingScreen extends StatefulWidget {
  TeacherClass subject;
  RatingScreen({required this.subject});
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  String teacherName = 'الأستاذ فلان'; // اسم الاستاذ
  String? performanceRating; // تقييم الأداء
  String? styleRating;
  int? performanceRatingValue;
  int? styleRatingValue;
  List<String> ratingOptions = ['ممتاز', 'جيد', 'متوسط', 'ضعيف'];

  void saveRating() {
    if (performanceRatingValue != null && styleRatingValue != null) {
      Evaluatio evaluatio = Evaluatio(
          teacherEvaluationValueOne: 100 - (performanceRatingValue! * 25),
          teacherEvaluationValueTow: 100 - (styleRatingValue! * 25));
      Provider.of<EvaluatioVM>(context, listen: false).sendDate(
          OnlineRepo(),
          "${API_URL.TEACHER_EAVLUATION_BY_STUDENT}/${widget.subject.subjectTeacher}",
          evaluatio);
      showSnackBar(context, "تم التقيم", true);
      // تحويل التقييمات النصية إلى قيم رقمية
      int performanceValue = ratingOptions.indexOf(performanceRating!);
      int styleValue = ratingOptions.indexOf(styleRating!);

      // حساب المتوسط
      double averageRating = (performanceValue + styleValue) / 2;

      // تحويل الناتج إلى نسبة مئوية
      double finalRating = averageRating *
          100 /
          (ratingOptions.length - 1); // -1 لاحتساب عدد الخيارات بشكل صحيح

      // حفظ التقييم
      print('تم حفظ التقييم: $finalRating%');
      // يمكنك هنا استخدام قيمة finalRating لحفظ التقييم بالنسبة المئوية
    } else {
      print('الرجاء اختيار التقييم');
    }
  }

  void clearRating() {
    setState(() {
      performanceRating = null;
      styleRating = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "التقييم"),
        drawer: CustomDrawer(
          subject: widget.subject,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .20,
              ), // الارتفاع لتقليل مساحة الكارد العلوية
              Container(
                // height: MediaQuery.of(context).size.height * .35,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade400,
                        Colors.blue.shade400,
                        Colors.indigo.shade800,
                      ],
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                          child: Text(
                        "أ.محمد كعدان",
                        style: fontwhite.fonttitle,
                      )),
                    ),
                    Column(
                      children: [
                        // تقييم الأداء
                        Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('تقييم الأداء',
                                    style: fonttitlestyle.fonttitle),
                                SizedBox(width: 20),
                                DropdownButton<int>(
                                    hint: Text(
                                      'اختر التقييم',
                                    ),
                                    value: performanceRatingValue,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        performanceRatingValue = newValue;
                                      });
                                    },
                                    items: List.generate(
                                        ratingOptions.length,
                                        (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(ratingOptions[index],
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ))),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('تقييم الأسلوب',
                                    style: fonttitlestyle.fonttitle),
                                SizedBox(width: 20),
                                DropdownButton<int>(
                                    hint: Text(
                                      'اختر التقييم',
                                    ),
                                    value: styleRatingValue,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        styleRatingValue = newValue;
                                      });
                                    },
                                    items: List.generate(
                                        ratingOptions.length,
                                        (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(ratingOptions[index],
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ))),
                              ],
                            ),
                          ),
                        ),

                        // Card(
                        //   elevation: 4,
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: 30, vertical: 10),
                        //   child: Padding(
                        //     padding: EdgeInsets.all(10),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text('تقييم الأسلوب',
                        //             style: fonttitlestyle.fonttitle),
                        //         SizedBox(width: 20),
                        //         DropdownButton<String>(
                        //           hint: Text(
                        //             'اختر التقييم',
                        //           ),
                        //           value: styleRating,
                        //           onChanged: (String? newValue) {
                        //             setState(() {
                        //               styleRating = newValue;
                        //             });
                        //           },
                        //           items: ratingOptions
                        //               .map<DropdownMenuItem<String>>(
                        //                   (String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(value,
                        //                   style:
                        //                       TextStyle(color: Colors.black)),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  // primary: Colors.white,
                                ),
                                onPressed: saveRating,
                                child: Text('حفظ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ),
                              // زر الغاء التقييم
                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.white,

                              //     // primary: Colors.white,
                              //   ),
                              //   onPressed: clearRating,
                              //   child: Text('الغاء',
                              //       style: TextStyle(
                              //           fontSize: 20, color: Colors.black)),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
