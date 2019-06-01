import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SelectorRoute {
  String name;
  String displayName;
  String image;
  Function callback;
  SelectorRoute(this.name, this.displayName, this.image, this.callback);
}

class SelectorFactory {
  static const String initial = "initial";
  static const String carousel_slider = "carousel_slider";

  Widget createSelector(String library, List<SelectorRoute> routes) {
    switch (library) {
      case carousel_slider:
        return createCarouselSliderSelector(routes);
      default:
        return createGridSelector(routes);
    }
  }

  Widget _createCard(SelectorRoute r) {
    return InkWell(onTap: r.callback, child: Card(
        child: Stack(fit: StackFit.expand, children: [
      new ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: new FittedBox(
              fit: BoxFit.contain,
              child: Image.network(
                r.image,
              ))),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              r.displayName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w200),
            )),
      )
    ])),);
  }

  Widget createCarouselSliderSelector(List<SelectorRoute> routes) {
    return CarouselSlider(
        height: 500.0,
        items: routes.map((r) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: _createCard(r));
            },
          );
        }).toList());
  }

  Widget createGridSelector(List<SelectorRoute> routes) {
    return GridView.count(
      shrinkWrap: false,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.7,
      children: routes.map((r) => _createCard(r)).toList(),
    );
  }
}
