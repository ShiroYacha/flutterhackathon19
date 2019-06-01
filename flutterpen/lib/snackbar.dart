import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';

class SnackbarFactory {
  static const String flushbar = "flushbar";

  void show(String library, String title, String message, BuildContext context,
      {seconds = 3}) {
    switch (library) {
      case flushbar:
        showFlushbar(title, message, context, seconds);
        break;
      default:
    }
  }

  void showFlushbar(
      String title, String message, BuildContext context, int seconds) {
    Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: seconds),
    )..show(context);
  }
}
