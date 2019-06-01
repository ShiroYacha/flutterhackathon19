import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SnackbarFactory {
  static const String initial = "intial";
  static const String flushbar = "flushbar";

  void show(String library, String title, String message, BuildContext context,
      {seconds = 3}) {
    switch (library) {
      case flushbar:
        showFlushbar(title, message, context, seconds);
        break;
      default:
        showFlutterSnackbar(title, message, context, seconds);
        break;
    }
  }

  void showFlutterSnackbar(
      String title, String message, BuildContext context, int seconds) {
    final snackbar = SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),);
    Scaffold.of(context).showSnackBar(snackbar);
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
