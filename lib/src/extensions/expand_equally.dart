import 'package:flutter/material.dart';

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() =>
      map((widget) => Expanded(flex: 1, child: widget));
}
