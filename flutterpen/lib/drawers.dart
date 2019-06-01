import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'bottom_navbar.dart';
import 'config.dart';

class DrawerRoute {
  String name;
  Widget body;
  DrawerRoute(this.name, this.body);
}

class DrawerFactory {
  static const String initial = "initial";
  static const String hidden_drawer_menu = "hidden_drawer_menu";
  static const String flutter_inner_drawer = "flutter_inner_drawer";
  BottomNavbarFactory _bottomNavbarFactory = BottomNavbarFactory();

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  Widget createDrawerApp(String library, List<DrawerRoute> routes,
      BuildContext context, Map<String, String> _configs, Function qrCallback) {
    switch (library) {
      case "hidden_drawer_menu":
        return createHiddenDrawerMenuApp(routes, context, _configs, qrCallback);
      case "flutter_inner_drawer":
        return MaterialApp(
            initialRoute: "${routes[0].name}",
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                  builder: (context) => createInnerDrawerMenuApp(
                      settings.name, routes, context, _configs, qrCallback));
            },
            home: createInnerDrawerMenuApp(
                routes[0].name, routes, context, _configs, qrCallback));
      case "initial":
      default:
        return MaterialApp(
            initialRoute: "${routes[0].name}",
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                  builder: (context) => createFlutterDrawerMenuApp(
                      settings.name, routes, context, _configs, qrCallback));
            },
            home: createFlutterDrawerMenuApp(
                routes[0].name, routes, context, _configs, qrCallback));
    }
  }

  Widget createQrScanActionButton(Function callback) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          MaterialCommunityIcons.getIconData("qrcode-scan"),
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget createDrawerHeader() => DrawerHeader(
        padding: EdgeInsets.only(top: 60, left: 20),
        child: Text(
          'FlutterPen',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w200, fontSize: 30),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      );

  Widget createFlutterDrawerMenuApp(String name, List<DrawerRoute> routes,
      BuildContext context, Map<String, String> _configs, Function qrCallback) {
    final body = routes.singleWhere((r) => r.name == name).body;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: <Widget>[createQrScanActionButton(qrCallback)],
      ),
      body: body,
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [createDrawerHeader()]..addAll(
                routes
                    .map(
                      (r) => ListTile(
                            title: Text(r.name),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, r.name);
                              Config.currentRoute = r.name;
                            },
                          ),
                    )
                    .toList(),
              )),
      ),
    );
  }

  Widget createInnerDrawerMenuApp(String name, List<DrawerRoute> routes,
      BuildContext context, Map<String, String> _configs, Function qrCallback) {
    final body = routes.singleWhere((r) => r.name == name).body;
    return InnerDrawer(
        key: _innerDrawerKey,
        position: InnerDrawerPosition.start, // required
        onTapClose: true, // default false
        swipe: true, // default true
        offset: 0.6, // default 0.4
        colorTransition: Colors.blue, // default Color.black54
        animationType: InnerDrawerAnimation.linear, // default static
        innerDrawerCallback: (a) => print(a), // return bool
        child: Material(
            child: Container(
                color: Colors.white24,
                child: ListView(
                    children: [createDrawerHeader()]..addAll(
                        routes
                            .map(
                              (r) => ListTile(
                                    title: Text(r.name),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, r.name);
                                      Config.currentRoute = r.name;
                                    },
                                  ),
                            )
                            .toList(),
                      )))),
        scaffold: Scaffold(
            appBar: AppBar(
          title: Text(name),
          leading: InkWell(
            onTap: () {
              _innerDrawerKey.currentState.open();
            },
            child: Icon(Icons.menu),
          ),
          automaticallyImplyLeading: true,
          actions: <Widget>[createQrScanActionButton(qrCallback)],
        ), body: body));
  }

  Widget createHiddenDrawerMenuApp(List<DrawerRoute> routes,
      BuildContext context, Map<String, String> _configs, Function qrCallback) {
    var items = routes.map((r) => ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: r.name,
          colorLineSelected: Colors.black,
          baseStyle:
              TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 25.0),
          selectedStyle: TextStyle(color: Colors.black),
        ),
        Scaffold(
          body: r.body,
        ))).toList();
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: items,
      backgroundColorMenu: Colors.white,
      actionsAppBar: <Widget>[createQrScanActionButton(qrCallback)],
      //    slidePercent: 80.0,
      //    verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    backgroundColorAppBar: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItensMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
