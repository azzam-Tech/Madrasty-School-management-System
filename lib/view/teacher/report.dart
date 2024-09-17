import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/report.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/report_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/view/teacher/components/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  ReportPage({required this.instanc});
  TeacherClass instanc;
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> reports = [];
  DateTime? _selectedDate;
  List<Report> _filteredReports = [];

  void _addReport(String reportText) {
    setState(() {
      // reports.add(Report(reportText, DateTime.now()));
      Provider.of<ReportVM>(context, listen: false)
          .sendDate(
              OnlineRepo(),
              API_URL.REPORT_BY_TEACHER_CREATE,
              Report(
                  subjectClassId: widget.instanc.subjectClassId,
                  classId: widget.instanc.classId!,
                  termId: 1,
                  followUpNoteBookText: reportText,
                  followUpNoteBookDate: DateTime.now()))
          .then(
        (value) {
          reports.add(value);
        },
      );
      _filterReports();
    });
  }

  void _showAddReportDialog() {
    String newReportText = '';
    bool isButtonEnabled = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('اضف تقرير يومي'),
              content: TextField(
                onChanged: (text) {
                  setState(() {
                    newReportText = text;
                    isButtonEnabled = newReportText.isNotEmpty;
                  });
                },
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'اكتب تقريرك هنا',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('الغاء'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ارسال'),
                  onPressed: isButtonEnabled
                      ? () {
                          if (newReportText.isNotEmpty) {
                            _addReport(newReportText);
                          }
                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _filterReports();
      });
    }
  }

  void _filterReports() {
    if (_selectedDate == null) {
      _filteredReports = reports;
    } else {
      _filteredReports = reports
          .where((report) =>
              report.followUpNoteBookDate!.year == _selectedDate!.year &&
              report.followUpNoteBookDate!.month == _selectedDate!.month &&
              report.followUpNoteBookDate!.day == _selectedDate!.day)
          .toList();
    }
  }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   _filteredReports = reports;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReportVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.REPORT_BY_TEACHER_GET,
            widget.instanc.subjectClassId!)
        .then((valu) {
      debugPrint("$valu");

      setState(() {
        reports = valu;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _filterReports();

    return Scaffold(
      appBar: CustomAppBar(title: "تقرير اليومي"),
      endDrawer: CustomDrawer(
        instanc: widget.instanc,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _pickDate,
                ),
                Text(
                  _selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                      : 'لم يتم تحديد التاريخ',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredReports.isEmpty
                ? Center(child: Text('لا توجد تقارير'))
                : ListView.builder(
                    itemCount: _filteredReports.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            _filteredReports[index].followUpNoteBookText!,
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            DateFormat('yyyy-MM-dd – kk:mm').format(
                                _filteredReports[index].followUpNoteBookDate!),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReportDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.shade900,
      ),
    );
  }
}

// class Report {
//   String text;
//   DateTime date;

//   Report(this.text, this.date);
// }
