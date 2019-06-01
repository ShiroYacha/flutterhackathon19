import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DrawerRoute {}

class DrawerFactory {
  static const String initial = "initial";
  static const String hidden_drawer_menu = "hidden_drawer_menu";
  static const String flutter_inner_drawer = "flutter_inner_drawer";

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  Widget createDrawerApp(String library, List<DrawerRoute> routes, BuildContext context, Function qrCallback) {
    switch (library) {
      case "initial":
        return createFlutterDrawerMenuApp(routes, context, qrCallback);
      case "hidden_drawer_menu":
        return createHiddenDrawerMenuApp(routes, context, qrCallback);
      case "flutter_inner_drawer":
        return createInnerDrawerMenuApp(routes, context, qrCallback);
      default:
    }
    return Container();
  }

  Widget createQrScanActionButton(Function callback) {
    return InkWell(
      onTap: callback,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(
        MaterialCommunityIcons.getIconData("qrcode-scan"),
        size: 25,
        color: Colors.white,
      ),),
    );
  }

  Widget createFlutterDrawerMenuApp(List<DrawerRoute> routes,  BuildContext context,  Function qrCallback) {
    return Scaffold(
      appBar: AppBar(title: Text("title"), actions: <Widget>[
        createQrScanActionButton(qrCallback)
      ],),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createInnerDrawerMenuApp(List<DrawerRoute> routes,  BuildContext context, Function qrCallback) {
    return InnerDrawer(
        key: _innerDrawerKey,
        position: InnerDrawerPosition.start, // required
        onTapClose: true, // default false
        swipe: true, // default true
        offset: 0.6, // default 0.4
        colorTransition: Colors.blue, // default Color.black54
        animationType: InnerDrawerAnimation.linear, // default static
        innerDrawerCallback: (a) => print(a), // return bool
        child: Material(child: Container(color: Colors.blue, child: ListView(children: <Widget>[

        ],))),
        //  A Scaffold is generally used but you are free to use other widgets
        // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
        scaffold: Scaffold(
            appBar: AppBar(
          title: Text("title"),
          leading: InkWell(onTap: (){
            _innerDrawerKey.currentState.open();
          },child: Icon(Icons.menu),),
          automaticallyImplyLeading: true,
          actions: <Widget>[createQrScanActionButton(qrCallback)],
        )));
  }

  Widget createHiddenDrawerMenuApp(List<DrawerRoute> routes,  BuildContext context,  Function qrCallback) {
    var itens = List<ScreenHiddenDrawer>();
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "title",
          colorLineSelected: Colors.teal,
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25.0),
          selectedStyle: TextStyle(color: Colors.teal),
        ),
        Container(
          color: Colors.teal,
          child: Center(
            child: Text("title",
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          ),
        )));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Screen 2",
          colorLineSelected: Colors.orange,
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25.0),
          selectedStyle: TextStyle(color: Colors.orange),
        ),
        Container(
          color: Colors.orange,
          child: Center(
            child: Text(
              "Screen 2",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
        )));
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: itens,
      backgroundColorMenu: Colors.cyan,
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
