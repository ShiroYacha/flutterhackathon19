import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'drawers.dart';
import 'snackbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterpen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  String drawerLib = DrawerFactory.flutter_inner_drawer;

  DrawerFactory _drawerFactory = DrawerFactory();
  SnackbarFactory _snackbarFactory = SnackbarFactory();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return _drawerFactory.createDrawerApp(drawerLib, [
      // return _drawerFactory.createDrawerApp("flutter_inner_drawer", [
      DrawerRoute(),
      DrawerRoute(),
      DrawerRoute(),
    ], () async {
      try {
        final encryptedBarcode = await BarcodeScanner.scan();
        setState((){
          drawerLib = encryptedBarcode;
        });
        _snackbarFactory.show("flushbar", "Library switch", "Switched drawer to $encryptedBarcode", context, seconds: 5);
      } catch (e) {
        print(e);
      }
    });
  }
}
