import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:graduation_project/constant/drawer/show_snack_bar.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/modle/Solutions.dart';
import 'package:graduation_project/data/modle/student_qeustion.dart';
import 'package:graduation_project/data/modle/teacher_class.dart';
import 'package:graduation_project/data/view_modle/Solution_VM.dart';
import 'package:graduation_project/data/view_modle/student_qeustion.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/style/list.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  CommentPage({required this.subject});
  TeacherClass subject;
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<StudentQeustion> replies = [];

  Future<void> fetchNotifications() async {
    debugPrint(
        "${API_URL.STUDENT_QEUSTIONS_BY_CLASS}/${widget.subject.classId}");

    await Provider.of<StudentQeustionVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_QEUSTIONS_BY_CLASS,
            widget.subject.classId!)
        .then((value) {
      debugPrint("vlaue $value");
      replies = value;

      setState(() {});
    });
  }

  TextEditingController _replyController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  Future<void> _sendReply() async {
    String reply = _replyController.text;
    if (reply.isNotEmpty) {
      await Provider.of<StudentQeustionVM>(context, listen: false).sendDate2(
          OnlineRepo(),
          API_URL.STUDENT_QEUSTIONS,
          StudentQeustion(
              studentQeustionText: reply,
              studentQeustionDate: DateTime.now().toString().split(" ").first),
          widget.subject.subjectClassId);
      showSnackBar(context, "تم الارسال", true);
      _replyController.clear();
      fetchNotifications();
      // setState(() {
      //   replies.add(Comment(
      //     text: reply,
      //     userName: 'حلا بن بشر',
      //     avatarUrl: 'img/arabic.jpg',
      //     date: DateTime.now(),
      //   ));
      //   _replyController.clear();
      // });
    }
  }

  void _editReply(int index) {
    String editedReply = replies[index].studentQeustionText!;
    _replyController.text = editedReply;
    _replyController.selection =
        TextSelection.fromPosition(TextPosition(offset: editedReply.length));
    setState(() {
      replies.removeAt(index);
    });
  }

  void _deleteReply(int index) {
    setState(() {
      replies.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _replyController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(
          title: "اقتراحاتي",
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _replyController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'اكتب سؤالك هنا...',
                            border: UnderlineInputBorder(),
                          ),
                          textDirection: TextDirection.rtl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال سؤالك';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_replyController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('الرجاء إدخال سؤالك قبل الإرسال'),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  _sendReply();
                                }
                              },
                              child: Text('إرسال'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final comment = replies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: CommentWidget(
                        feachData: fetchNotifications,
                        comment: comment,
                        onEdit: () => _editReply(index),
                        onDelete: () => _deleteReply(index),
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

class CommentWidget extends StatelessWidget {
  final StudentQeustion comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback feachData;

  const CommentWidget({
    required this.feachData,
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                comment.studentName!,
                style: fonttitlestyle.fonttitle,
              ),
              subtitle: Text(
                comment.studentQeustionDate.toString(),
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              // leading: CircleAvatar(
              //   backgroundImage: AssetImage(comment.),
              //   radius: 20,
              // ),
              trailing: Shared.studentId == comment.studentId
                  ? PopupMenuButton(
                      itemBuilder: (context) => [
                        // PopupMenuItem(
                        //   child: ListTile(
                        //     title: Text(
                        //       'تعديل',
                        //       style: fonttitlestyle.fonttitle,
                        //     ),
                        //     onTap: () {
                        //       onEdit();
                        //       Navigator.pop(context);
                        //     },
                        //   ),
                        // ),
                        PopupMenuItem(
                          child: ListTile(
                            title: Text(
                              'حذف',
                              style: fonttitlestyle.fonttitle,
                            ),
                            onTap: () {
                              deletefun(context);
                              // onDelete();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
            SizedBox(height: 20),
            Text(
              comment.studentQeustionText!,
              style: fonttitlestyle.fonttitle,
            ),
            SizedBox(height: 10),
            if (comment.teacherAnswerText != null)
              Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade900,
              ),
              child: comment.teacherAnswerText != null
                  ? Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الجواب:',
                              style: fonttitlestyle.fonttitle,
                            ),
                            SizedBox(height: 10),
                            Text(
                              comment.teacherAnswerText!,
                              style: fonttitlestyle.fonttitle,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deletefun(BuildContext context) async {
    await deleteFun(OnlineRepo(),
        "${API_URL.STUDENT_DELETE}/${comment.studentQeustionId}", context);
    ;
    feachData();
  }
}
