import 'package:flutter/material.dart';
import 'package:graduation_project/repository/online_repo.dart';

showSnackBar(BuildContext context, String message, bool state) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        backgroundColor: state ? Colors.blue.shade900 : Colors.red,
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
}

deleteFun(OnlineRepo repo, String souce, BuildContext context) async {
  debugPrint(souce);
  bool result = await repo.deletesoucw(source: souce);
  result
      ? showSnackBar(context, "تم الحذف ", result)
      : showSnackBar(context, "لم يتم الحذف", result);
}
