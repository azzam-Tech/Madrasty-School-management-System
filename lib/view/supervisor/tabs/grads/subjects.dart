// // import 'package:collasable_drawer/components/drawer/custom_drawer.dart';
// // import 'package:collasable_drawer/tabbar/classtab/grads/grads.dart';
// // import 'package:collasable_drawer/tabbar/classtab/homeworknotification/Homework_tab.dart';
// // import 'package:collasable_drawer/wedgits/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/constant/appbar.dart';
// import 'package:graduation_project/constant/appbarchild.dart';

// import 'package:graduation_project/view/supervisor/component/drawer/custom_drawer.dart';
// import 'package:graduation_project/view/supervisor/tabs/grads/students_marks_sv.dart';
// import 'package:page_transition/page_transition.dart';

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(textDirection: TextDirection.rtl,
//       child: MaterialApp(
//         home: Scaffold(
//           appBar: appbarchild(title: "درجات الطلاب",),
//         drawer:  CustomDrawer(),
//           body: GridView.count(
//             crossAxisCount: 2, // Display two items in each row
//             mainAxisSpacing: 20.0, // Vertical spacing between rows
//             crossAxisSpacing: 20.0, // Horizontal spacing between items
//             padding: EdgeInsets.all(10.0),
//             children: [
//               SubjectContainer(
//                 subjectName: 'chemistry',
//                 imagePath: 'img/science.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'Math',
//                 imagePath: 'img/math.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'phisics',
//                 imagePath: 'img/phisics.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'biology',
//                 imagePath: 'img/biology.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'Arabic',
//                 imagePath: 'img/arabic.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'English',
//                 imagePath: 'img/english.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'Qura\'an',
//                 imagePath: 'img/quran.jpg',
//               ),
//               SubjectContainer(
//                 subjectName: 'Eslamic',
//                 imagePath: 'img/eslamic.jpg',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SubjectContainer extends StatelessWidget {
//   final String subjectName;
//   final String imagePath;

//   const SubjectContainer({
//     required this.subjectName,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Handle the tap event here
//         Navigator.of(context).push(PageTransition(
//           type: PageTransitionType.leftToRight,
//           childCurrent: this,
//           duration: Duration(milliseconds: 600),
//           reverseDuration: Duration(microseconds: 600),
//           child: StudentMarks_SV(),
//         ));
//       },
//       child: Container(
//         width: 200, // Set the width
//         height: 200, // Set the height
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.indigo.shade900.withOpacity(0.3),
//               spreadRadius: 3,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color:
//                     Colors.black.withOpacity(0.5), // Black overlay with opacity
//               ),
//             ),
//             Positioned(
//               bottom: 20,
//               left: 10,
//               right: 10,
//               child: Text(
//                 subjectName,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20, // Increase the font size
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:collasable_drawer/class/tclass.dart';
// import 'package:collasable_drawer/screens/home/drawer.dart';
// import 'package:collasable_drawer/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constant/buttoncolor.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/teacher_class_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:graduation_project/view/supervisor/tabs/grads/students_marks_sv.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _teacherclassState();
}

class _teacherclassState extends State<Dashboard> {
  @override
  void initState() {
    feachdate();
    // TODO: implement initState
    super.initState();
  }

  feachdate() async {
    debugPrint("test");
    String suorce = API_URL.SUBJECTS_BY_LIVLEID;
    debugPrint("$suorce/${Shared.classId}");
    await Provider.of<TeacherClassVM>(context, listen: false)
        .getdata2(OnlineRepo(), suorce, Shared.classId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TCVM = Provider.of<TeacherClassVM>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teacher Classes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ClassButtonGrid(TCVM.allTeacherClassList2),
      ),
    );
  }
}

class ClassButtonGrid extends StatelessWidget {
  final List<TeacherClass> teacherClasses;

  ClassButtonGrid(this.teacherClasses);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3, // Adjust this value to control button height
      ),
      itemCount: teacherClasses.length,
      itemBuilder: (context, index) {
        final teacherClass = teacherClasses[index];
        return Padding(
          padding: const EdgeInsets.all(10.0), // Added horizontal padding

          child: CustomGradientButton(
            buttonText: teacherClass.subjectClassName!,
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                type: PageTransitionType.leftToRight,
                childCurrent: this,
                duration: Duration(milliseconds: 600),
                reverseDuration: Duration(microseconds: 600),
                child: StudentMarks_SV(
                  inctance: teacherClass,
                ),
              ));
            },
          ),
        );
      },
    );
  }
}
