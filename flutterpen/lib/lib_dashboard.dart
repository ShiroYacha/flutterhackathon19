import 'package:flutter/material.dart';
import 'selector.dart';

class LibraryDashboard extends StatelessWidget {
  
SelectorFactory _selectorFactory = SelectorFactory();
  List<SelectorRoute> routes;
  Map<String, String> configs;

  LibraryDashboard(this.routes, this.configs);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: _selectorFactory.createSelector(configs["selector"], routes),
    );
  }
}