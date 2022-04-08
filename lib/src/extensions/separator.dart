import 'package:flutter/material.dart';

extension Seperator on Iterable<Widget> {
  Iterable<Widget> seperate(Color color) {
    var widgets = <Widget>[];
    forEach((element) {
      widgets.add(element);
      widgets.add(Divider(
        thickness: 1,
        height: 1,
        color: color.withOpacity(0.25),
      ));
    });
    widgets.removeLast();
    return widgets;
  }
}
