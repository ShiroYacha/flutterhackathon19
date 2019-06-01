import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutterpen/selector.dart';
import 'drawers.dart';
import 'snackbar.dart';
import 'bottom_navbar.dart';
import 'lib_dashboard.dart';
import 'selector.dart';
import 'config.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DrawerFactory _drawerFactory = DrawerFactory();
  SnackbarFactory _snackbarFactory = SnackbarFactory();

  Map<String, String> _configs = {
    "drawer": DrawerFactory.initial,
    "snackbar": SnackbarFactory.initial,
    "bottom_navbar": BottomNavbarFactory.initial,
    "selector": SelectorFactory.initial
  };

  List<DrawerRoute> _routes;
  int refresh = 0;

  @override
  void initState() {
    super.initState();
    _routes = getRoutes();
    _configs = {
      "drawer": DrawerFactory.initial,
      "snackbar": SnackbarFactory.initial,
      "bottom_navbar": BottomNavbarFactory.initial,
      "selector": SelectorFactory.initial
    };
  }

  List<DrawerRoute> getRoutes() {
    return [
      DrawerRoute(
          "Drawers",
          LibraryDashboard([
            SelectorRoute(DrawerFactory.initial, "Flutter drawer",
                "https://cdn-images-1.medium.com/max/1200/1*EsZiL8weIycbTDMo2m49MA.png",
                () {
              setState(() {
                _configs["drawer"] = DrawerFactory.initial;
              });
            }),
            SelectorRoute(
                DrawerFactory.hidden_drawer_menu,
                "Hidden drawer menu",
                "https://github.com/RafaelBarbosatec/hidden_drawer_menu/blob/master/imgs/notice_expanded.png?raw=true",
                () {
              setState(() {
                _configs["drawer"] = DrawerFactory.hidden_drawer_menu;
              });
            }),
            SelectorRoute(
                DrawerFactory.flutter_inner_drawer,
                "Flutter Inner drawer",
                "https://github.com/Dn-a/flutter_inner_drawer/raw/master/example/pic.png?raw=true",
                () {
              setState(() {
                _configs["drawer"] = DrawerFactory.flutter_inner_drawer;
              });
            }),
          ], _configs)),
      DrawerRoute(
          "Selectors",
          LibraryDashboard([
            SelectorRoute(SelectorFactory.initial, "Flutter grid view",
                "https://i.stack.imgur.com/5eaSYm.png", () {
              setState(() {
                _configs["selector"] = SelectorFactory.initial;
              });
            }),
            SelectorRoute(SelectorFactory.carousel_slider, "Carousel slider",
                "https://flutterawesome.com/content/images/2018/09/flutter_carousel_slider.jpg",
                () {
              setState(() {
                _configs["selector"] = SelectorFactory.carousel_slider;
              });
            }),
          ], _configs)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        key: _scaffoldKey,
        body: _drawerFactory.createDrawerApp(
            _configs["drawer"], _routes, context, _configs, () async {
          try {
            final encryptedBarcode = await BarcodeScanner.scan();
            final parts = encryptedBarcode.split(";");
            setState(() {
              _configs[parts[0]] = parts[1];
              _routes = getRoutes();
            });
            _snackbarFactory.show(
                _configs["snackbar"],
                "Library switch on ${parts[0]}",
                "Switched to ${parts[1]}",
                context,
                _scaffoldKey,
                seconds: 5);
          } catch (e) {
            print(e);
          }
        }));
  }
}
