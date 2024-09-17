import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbar.dart';

import 'package:graduation_project/constant/fontstyle.dart';
import 'package:graduation_project/data/view_modle/childernVM.dart';
import 'package:graduation_project/repository/online_repo.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:graduation_project/utility/endpoints.dart';
import 'package:graduation_project/utility/shared.dart';
import 'package:graduation_project/view/parent/detalischild.dart';
import 'package:provider/provider.dart';

import 'bottomnav.dart';
import 'drawer/custom_drawer.dart';

class children extends StatefulWidget {
  const children({Key? key}) : super(key: key);

  @override
  State<children> createState() => _childrenState();
}

class _childrenState extends State<children> {
  feachData() async {
    await Provider.of<Childernvm>(context, listen: false)
        .getdata(OnlineRepo(), API_URL.STUDENT_BY_PAERNT, Shared.id!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feachData();
  }

  @override
  Widget build(BuildContext context) {
    final CVM = Provider.of<Childernvm>(context);
    Size hight = MediaQuery.of(context).size;
    Size width = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(
            title: "أبنائي",
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.blue.shade900,
                              Colors.blue.shade700,
                              Colors.blue.shade700,
                              Colors.blue.shade900
                            ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: GridView.builder(
                          itemCount: CVM.allChildernList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15),
                          itemBuilder: (context, index) {
                            final childd = CVM.allChildernList[index];
                            // final pageName = nameToPage[childd.name];

                            return GestureDetector(
                                onTap: () {
                                  // if (pageName != null) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => getWidgetForPage(pageName),
                                  //     ),
                                  //   );
                                  // }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detalischild(
                                        child: childd,
                                      ),
                                    ),
                                  );
                                },
                                child: AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      duration: Duration(seconds: 3),
                                      curve: Curves.bounceInOut,
                                      child: FadeInAnimation(
                                        child: Card(
                                          elevation: 15,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topLeft,
                                                    colors: [
                                                      Colors.blue.shade900,
                                                      Colors.blue.shade700,
                                                      Colors.blue.shade700,
                                                      Colors.blue.shade900
                                                    ])),
                                            child: Center(
                                                child: Text(
                                              childd.studentName!,
                                              style: fontstyle.fontheading,
                                            )),
                                          ),
                                        ),
                                      ),
                                    )));
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
