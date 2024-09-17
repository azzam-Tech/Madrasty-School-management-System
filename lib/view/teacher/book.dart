import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/book.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/book_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:graduation_project/view/teacher/components/drawer/custom_drawer.dart';
import 'package:graduation_project/view/student/components/drawer/custom_drawer.dart'
    as student;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class book extends StatefulWidget {
  book({required this.instance});
  TeacherClass instance;
  @override
  _bookState createState() => _bookState();
}

class _bookState extends State<book> {
  String _searchText = '';
  int selectbook = 0;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    await Provider.of<BookVM>(context, listen: false).getdata(
        OnlineRepo(), "${API_URL.SUBJECTS}/${widget.instance.levelId}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final BVM = Provider.of<BookVM>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "كتبي",
        ),
        endDrawer: Shared.role == "teacher"
            ? CustomDrawer(
                instanc: widget.instance,
              )
            : student.CustomDrawer(
                subject: widget.instance,
              ),
        body: BVM.book == null
            ? Center(
                child: Text("لا توجد بيانات"),
              )
            : Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      BVM.book!.subjectName!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                            // elevation: 9,
                            child: BVM.book!.subjecBooks!.isEmpty
                                ? Center(
                                    child: Text(" لا توجد بينات"),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(
                                        // mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: List.generate(
                                            BVM.book!.subjecBooks!.length,
                                            (index) => ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    selectbook = index;
                                                    debugPrint(
                                                        BVM.book!.subjecBooks![
                                                            selectbook]);
                                                  });
                                                },
                                                child: Text(
                                                    "${index + 1} ${BVM.book!.subjectName!}")))),
                                  ))),
                    Expanded(
                        child: SfPdfViewer.network(
                            BVM.book!.subjecBooks![selectbook]))
                  ],
                ),
              ),
      ),
    );
  }
}
