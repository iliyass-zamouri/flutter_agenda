import 'package:flutter/material.dart';

class PillarHead {
  final String name;

  final dynamic object;

  final VoidCallback? onTap;

  final double height;

  final double width;

  final Color backgroundColor;

  final TextStyle textStyle;

  final Color textColor;

  PillarHead({
    required this.name,
    this.object,
    this.onTap,
    this.height: 40,
    this.width: 200,
    this.backgroundColor: Colors.white,
    this.textColor: const Color(0xFF323D6C),
    this.textStyle:
        const TextStyle(color: Color(0xFF323D6C), fontWeight: FontWeight.bold),
  });
}
