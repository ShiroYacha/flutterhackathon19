import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SnackbarFactory {
  static const String initial = "initial";
  static const String flushbar = "flushbar";

  void show(String library, String title, String message, BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      {seconds = 3}) {
    switch (library) {
      case flushbar:
        showFlushbar(title, message, context, seconds);
        break;
      default:
        showFlutterSnackbar(title, message, scaffoldKey, seconds);
        break;
    }
  }

  void showFlutterSnackbar(String title, String message,
      GlobalKey<ScaffoldState> scaffoldKey, int seconds) {
    final snackbar = SnackBar(
      content: Container(
        height: 40,
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message)
          ],
        ),
      ),
      duration: Duration(seconds: seconds),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
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
