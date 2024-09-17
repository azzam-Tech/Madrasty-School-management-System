import 'package:flutter/material.dart';
import 'package:graduation_project/data/modle/book.dart';
import 'package:graduation_project/repository/app_repo.dart';

class BookVM with ChangeNotifier {
  Book? book;

  Future<Book?> getdata(ApplicationRepo repo, String source) async {
    try {
      Map<String, dynamic> response = await repo.getoneData(source: "$source");
      debugPrint("response ${response}");
      book = Book.fromJson(response["data"]);
      ChangeNotifier();
      print("allBookList $book");
    } catch (e) {
      debugPrint("errpe $e");
    }

    return book;
  }
}
