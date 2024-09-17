// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/constant/drawer/show_snack_bar.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/home_work.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/view/teacher/tabbar/classtab/homeworknotification/viewhw.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/buttoncolor.dart';
// import 'package:graduation_project/constant/drawer/testsearch.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/constant/searchBar.dart';
import 'package:graduation_project/view/teacher/components/drawer/custom_drawer.dart';
import 'package:graduation_project/view/teacher/tabbar/test.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/data/modle/homework.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({required this.instanc});
  TeacherClass instanc;
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feachdate();
  }

  feachdate() async {
    debugPrint("${API_URL.HOMEWORK_BY_CLASS}/${widget.instanc.classId}");
    await HomeworkVM()
        .getdata(
            OnlineRepo(), API_URL.HOMEWORK_BY_CLASS, widget.instanc.classId!)
        .then((value) {
      debugPrint("vlaue $value");
      notifications = value;

      setState(() {
        _filteredNames = notifications
            .map((notification) => notification.homeWorkTitle as String)
            .toList();
      });
    });
  }

  List<HomeworkClass> notifications = [];
  // List<Map<String, dynamic>> notifications = [];
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredNames = [];
  bool _isBackPressed = false;

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = notifications
            .map((notification) => notification.homeWorkTitle as String)
            .toList();
      } else {
        _filteredNames = notifications
            .where(
                (notification) => notification.homeWorkTitle!.contains(query))
            .map((notification) => notification.homeWorkTitle as String)
            .toList();
      }
    });
  }

  Future<void> _addNotification(HomeworkClass notification) async {
    // setState(() {

    // HomeworkClass result =
    await Provider.of<HomeworkVM>(context, listen: false).sendDate(
        OnlineRepo(),
        API_URL.HOMEWORK_BY_CREATE,
        notification,
        widget.instanc.subjectClassId!);
    // await feachdate();
    notifications.add(notification);
    _filteredNames = notifications
        .map((notification) => notification.homeWorkTitle as String)
        .toList();
    setState(() {});
    // });
  }

  void _editNotification(int index, HomeworkClass newNotification) {
    setState(() {
      notifications[index] = newNotification;
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _showAddNotificationDialog({HomeworkClass? notification, int? index}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      builder: (BuildContext context) {
        return AddNotificationDialog(
          onSubmit: (notificationData) {
            if (index == null) {
              _addNotification(notificationData);
            } else {
              _editNotification(index, notificationData);
            }
          },
          notification: notification,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final HWVM = Provider.of<HomeworkVM>(context);
    bool isPressed;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(title: 'الواجبات'),
        resizeToAvoidBottomInset: false,
        endDrawer: CustomDrawer(
          instanc: widget.instanc,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                searchBar(
                  controller: _searchController,
                  onChanged: _filterNames,
                  noResults: _filteredNames.isEmpty &&
                      _searchController.text.isNotEmpty,
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _filteredNames.length,
              itemBuilder: (context, index) {
                _filteredNames = _filteredNames.reversed.toList();
                var notificationTitle = _filteredNames[index];
                var notification = notifications.firstWhere((notification) =>
                    notification.homeWorkTitle == notificationTitle);

                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4, // Remove card elevation
                        color: Colors.white, // Transparent card background
                        child: Column(
                          children: [
                            ListTile(
                              // trailing: CircleAvatar(
                              //   backgroundImage: AssetImage("img/quran.jpg"),
                              // ),
                              title: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  notification.homeWorkTitle!,
                                ),
                              ),
                              // subtitle: Align(
                              //   alignment: Alignment.topRight,
                              //   child: Text(
                              //     // '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                              //     "2/2/2020",
                              //   ),
                              // ),
                              leading: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    debugPrint(value);
                                    // _showAddNotificationDialog(
                                    //   notification: notification,
                                    //   index: index,
                                    // );
                                  } else if (value == 'delete') {
                                    // _deleteNotification(index);
                                    delete(value, notification, context);
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                              ), // Three dots on the left side

                              // Timestamp on the top left corner
                            ),
                            // Title on the top  corner
                            const SizedBox(
                              height: 10,
                            ),

                            Column(
                              children: [
                                // Center(
                                //   child: Text(
                                //     notification.homeWorkTitle!,
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       fontSize:
                                //           MediaQuery.of(context).size.width *
                                //               0.05, // Adjust font size
                                //     ),
                                //   ),
                                // ),
                                Divider(
                                  color: Colors.grey.shade700,
                                  height: 5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  notification.homeWorkdescription!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                image: NetworkImage(notification
                                                    .homeWorkImagePath!),
                                                //  AssetImage(
                                                //     "img/biology.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            notification.homeWorkImagePath!),
                                        // image: AssetImage("img/biology.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ': موعد التسليم ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                  notification
                                                      .homeWorkDeadline!),
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.calendar_today),
                                          ]),
                                      SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('HH:mm            ')
                                                  .format(notification
                                                      .homeWorkDeadline!),
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.lock_clock),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${notification.homeWorkDegree}              ",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.numbers),
                                          ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: CustomGradientButton(
                                buttonText: 'عرض الحلول',
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(milliseconds: 600),
                                    reverseDuration:
                                        Duration(microseconds: 600),
                                    child: ViewHomeworkTab(
                                      instanc: notification,
                                    ),
                                  ));
                                },
                                hasHomework: true,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddNotificationDialog(),
          tooltip: 'اضف اشعار ',
          child: Icon(Icons.add),
          backgroundColor: Colors.blue.shade900,
        ),
      ),
    );
  }

  Future<void> delete(
      String value, HomeworkClass notification, BuildContext context) async {
    debugPrint(value);
    await deleteFun(OnlineRepo(),
        "${API_URL.HOMEWORK_DELETE}/${notification.homeWorkId}", context);
    // setState(() {});
    feachdate();
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Grads()),
    );
    return false;
  }
}

class AddNotificationDialog extends StatefulWidget {
  final Function(HomeworkClass) onSubmit;
  final HomeworkClass? notification;

  AddNotificationDialog({required this.onSubmit, this.notification});

  @override
  _AddNotificationDialogState createState() => _AddNotificationDialogState();
}

class _AddNotificationDialogState extends State<AddNotificationDialog> {
  final _titleController = TextEditingController();
  final _degreeController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime _deadline = DateTime.now();
  String? _attachedFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.notification != null) {
      _titleController.text = widget.notification!.homeWorkTitle!;
      _contentController.text = widget.notification!.homeWorkText!;
      _deadline = widget.notification!.homeWorkDeadline!;
      _attachedFile = widget.notification!.homeWorkImagePath!;
    }
  }

  void _submit() {
    // final notificationData = {
    //   'title': _titleController.text,
    //   'content': _contentController.text,
    //   'deadline': _deadline,
    //   'timestamp': DateTime.now(),
    //   'file': _attachedFile,
    // };
    final notificationData = HomeworkClass()
      ..homeWorkTitle = _titleController.text
      ..homeWorkdescription = _contentController.text
      ..homeWorkDeadline = _deadline
      ..homeWorkDate = DateTime.now()
      ..homeWorkImagePath = _attachedFile
      ..homeWorkDegree = double.parse(_degreeController.text);

    widget.onSubmit(notificationData);
    Navigator.of(context).pop();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _attachedFile = result.files.single.path;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline),
    );
    if (picked != null) {
      setState(() {
        _deadline = DateTime(
          _deadline.year,
          _deadline.month,
          _deadline.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                  widget.notification == null ? 'اضافة سؤال' : 'تعديل السوال',
                  textAlign: TextAlign.center,
                  style: fontstyle.fontheading),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Divider(
                        thickness: 1.2,
                        color: Colors.grey.shade200,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child:
                            const Text("العنوان", style: fontstyle.fontheading),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _titleController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintText: "العنوان",
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null; // Input is valid
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("السوال", style: fontstyle.fontheading),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: _contentController,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              alignLabelWithHint: true,
                              hintText: "السوال",
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter content';
                              }
                              return null; // Input is valid
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("الدرجة", style: fontstyle.fontheading),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _degreeController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^-?\d+(\.\d+)?$'))
                          ],
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintText: "الدرجة",
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            // else if (==RegExp())
                            return null; // Input is valid
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                            'Deadline: ${DateFormat('dd/MM/yyyy').format(_deadline)}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: _selectDate,
                      ),
                      ListTile(
                        title: Text(
                            'Time: ${DateFormat('HH:mm').format(_deadline)}'),
                        trailing: Icon(Icons.access_time),
                        onTap: _selectTime,
                      ),
                      ListTile(
                        title: Text(_attachedFile != null
                            ? 'File attached'
                            : 'Attach file'),
                        trailing: Icon(Icons.attach_file),
                        onTap: _pickFile,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomGradientButton(
                            buttonText: 'الغاء',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            // hasHomework:
                            //     false, // Set hasHomework to false for the Cancel button
                          ),
                          CustomGradientButton(
                            buttonText: widget.notification != null
                                ? 'تعدديل'
                                : 'ارسال',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submit();
                              }
                            },
                            hasHomework:
                                true, // Assuming the Edit/Submit button has homework
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
