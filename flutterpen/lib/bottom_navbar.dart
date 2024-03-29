import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomNavbarFactory {
  static const String initial = "initial";
  static const String bottom_navy_bar = "bottom_navy_bar";

  Widget createBottomNavbar(
    String library,
  ) {
    switch (library) {
      case initial:
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text("test")),
            BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text("test")),
            BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text("test")),
          ],
        );
        break;
    }
  }
}
