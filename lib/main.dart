import 'package:graduation_project/data/view_modle/Laibry_book_vm.dart';
import 'package:graduation_project/data/view_modle/ReinforcementLessoVM.dart';
import 'package:graduation_project/data/view_modle/Solution_VM.dart';
import 'package:graduation_project/data/view_modle/book_VM.dart';
import 'package:graduation_project/data/view_modle/childernVM.dart';
import 'package:graduation_project/data/view_modle/class_VM.dart';
import 'package:graduation_project/data/view_modle/eealuatio_VM.dart';
import 'package:graduation_project/data/view_modle/grad_vm.dart';
import 'package:graduation_project/data/view_modle/home_work.dart';
import 'package:graduation_project/data/view_modle/report_VM.dart';
import 'package:graduation_project/data/view_modle/section_vm.dart';
import 'package:graduation_project/data/view_modle/student_attendentVM.dart';
import 'package:graduation_project/data/view_modle/student_qeustion.dart';
import 'package:graduation_project/data/view_modle/suggestionVM.dart';
import 'package:graduation_project/data/view_modle/teacher_attendent.dart';
import 'package:graduation_project/data/view_modle/teacher_attendentVM.dart';
import 'package:graduation_project/data/view_modle/teacher_class_VM.dart';
import 'package:graduation_project/data/view_modle/teacher_table_VM.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/parent/bottomnav.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:graduation_project/view/manager/bttommanager.dart';
import 'package:graduation_project/view/student/bottomnav.dart';
import 'package:graduation_project/view/teacher/tabbar/tabsbar.dart';
import 'package:provider/provider.dart';
import 'data/viewmdles.dart';
import 'login.dart';
import 'utility/shared.dart';
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  await Shared.retrieveinfo();
//  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Shared()),
          ChangeNotifierProvider(create: (ctx) => Gradvm()),
          ChangeNotifierProvider(create: (ctx) => TeacherClassVM()),
          ChangeNotifierProvider(create: (ctx) => ReportVM()),
          ChangeNotifierProvider(create: (ctx) => BookVM()),
          ChangeNotifierProvider(create: (ctx) => SectionVm()),
          ChangeNotifierProvider(create: (ctx) => LibaryBookVN()),
          ChangeNotifierProvider(create: (ctx) => Childernvm()),
          ChangeNotifierProvider(create: (ctx) => GradVM()),
          ChangeNotifierProvider(create: (ctx) => classVM()),
          ChangeNotifierProvider(create: (ctx) => EvaluatioVM()),
          ChangeNotifierProvider(create: (ctx) => HomeworkVM()),
          ChangeNotifierProvider(create: (ctx) => StudentQeustionVM()),
          ChangeNotifierProvider(create: (ctx) => TeacherAttendetVN()),
          ChangeNotifierProvider(create: (ctx) => TeacherAttendentVM()),
          ChangeNotifierProvider(create: (ctx) => StudentAttendentVM()),
          ChangeNotifierProvider(create: (ctx) => SuggestionVN()),
          ChangeNotifierProvider(create: (ctx) => SolutionVm()),
          ChangeNotifierProvider(create: (ctx) => TeacherTableVM()),
          ChangeNotifierProvider(create: (ctx) => ReinforcementLessoVM()),
          ChangeNotifierProvider(create: (ctx) => Lessonvm()),
          ChangeNotifierProvider(create: (ctx) => Notificationmanagervm()),
          ChangeNotifierProvider(create: (ctx) => Daryvm()),
          ChangeNotifierProvider(create: (ctx) => Assigmentvm()),
          ChangeNotifierProvider(create: (ctx) => Termstvm())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home:tabsbutton(),
          home: ChechAuth(),
        ));
  }
  Widget ChechAuth() {
    Shared.retrieveinfo();
    debugPrint(Shared.role);
    debugPrint("${Shared.role}");
    if (Shared.role == "manager") {
      return tabsmanager();
    } else if (Shared.role == "student") {
      return TabStudent();
    } else if (Shared.role == "teacher") {
      return tabsbutton();
    } else if (Shared.role == "parent") {
      return tabsparent();
    }
    // else if (Shared.role == "manager") {
    //   return tabsmanager();
    // }
    return MyTabLogin();
  }
}
