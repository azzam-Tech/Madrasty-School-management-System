import 'package:flutter/material.dart';
import 'package:graduation_project/constant/appbarchild.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFledader extends StatelessWidget {
  const PDFledader({super.key, required this.pdfLink});
  final pdfLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarchild(
        title: "PDF Leader",
      ),
      body: SfPdfViewer.network(pdfLink),
    );
  }
}
