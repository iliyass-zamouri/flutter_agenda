import 'package:flutter/material.dart';

class Header {
  final String title;

  final String? subtitle;

  final dynamic object;

  final VoidCallback? onTap;

  final double height;

  final Color backgroundColor;

  final TextStyle textStyle;

  final TextStyle subtitleStyle;

  final Color color;

  Header({
    required this.title,
    this.subtitle,
    this.object,
    this.onTap,
    this.height: 40,
    this.backgroundColor: Colors.white,
    this.color: const Color(0xFF292B2F),
    this.textStyle: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
    this.subtitleStyle: const TextStyle(
        color: Color(0xFFA1A1A0), fontWeight: FontWeight.w300, fontSize: 10),
  });
}
