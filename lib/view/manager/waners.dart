import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';
import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/constant/searchBar.dart';
import 'package:graduation_project/data/modle/ckass.dart';
import 'package:graduation_project/data/view_modle/class_VM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:graduation_project/style/list.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/view/manager/students.dart';
import 'package:provider/provider.dart';

class Winer extends StatefulWidget {
  @override
  State<Winer> createState() => _WinerState();
}

class _WinerState extends State<Winer> {
  final TextEditingController _searchController = TextEditingController();
  List<ClassM> searchResults = [];
  bool _noResults = false;
  late List<ClassM> _futureSearchResults;
  classVM CVM = classVM();

  @override
  void initState() {
    super.initState();
    // classVM().getData(repo, source)
    fetchClases(); // استدعاء الدالة للحصول على البيانات
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchBar(
                controller: _searchController,
                onChanged: _filterNames,
                noResults: _noResults,
              ),
              Expanded(
                child:
                    //  FutureBuilder<List<ClassM>>(
                    // future: fetchClases(),
                    // builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return Center(child: CircularProgressIndicator());
                    // } else if (snapshot.hasError) {
                    //   return Center(
                    //       child: Text("حدث خطأ أثناء تحميل البيانات"));
                    // }
                    // else if (snapshot.hasData) {
                    // تحديث searchResults بالبيانات المستقبلة
                    // searchResults = snapshot.data!;
                    Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _noResults ? 0 : searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentResultsPage(
                                      className:
                                          searchResults[index].className!)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blue.shade900,
                                Colors.blue.shade700,
                                Colors.blue.shade700,
                                Colors.blue.shade900
                              ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Center(
                              child: Text(
                                searchResults[index].className!,
                                style: fontwhite.fonttitle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // );
                  // } else {
                  //   return Center(child: Text("لا توجد نتائج"));
                  // }
                  //   },
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _filterNames(String query) {
    setState(() {
      _noResults = false;
    });

    if (query.isEmpty) {
      setState(() {
        searchResults = Provider.of<classVM>(context, listen: false).allClass;
      });
    } else {
      setState(() {
        searchResults = Provider.of<classVM>(context, listen: false)
            .allClass
            .where((clase) => clase.className!.contains(query))
            .toList();
        _noResults = searchResults.isEmpty;
      });
    }
  }

  Future<List<ClassM>> fetchClases() async {
    // يمكنك هنا استبدال البيانات المستقبلية ببيانات حقيقية من السحابة أو أي مصدر آخر
    _futureSearchResults = await Provider.of<classVM>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.CLASSES);
    searchResults = _futureSearchResults;
    return _futureSearchResults;
    // return Future.delayed(Duration(seconds: 2), () => clas);
  }
}
