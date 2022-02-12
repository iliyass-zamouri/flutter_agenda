import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/event_time.dart';

class AgendaEvent {
  final String title;

  final String subtitle;

  final EventTime start;

  final EventTime end;

  final EdgeInsets padding;

  final EdgeInsets? margin;

  final VoidCallback? onTap;

  final BoxDecoration? decoration;

  final Color backgroundColor;

  final TextStyle textStyle;

  final TextStyle subtitleStyle;

  AgendaEvent({
    required this.title,
    this.subtitle: "",
    required this.start,
    required this.end,
    this.padding: const EdgeInsets.all(10),
    this.margin,
    this.onTap,
    this.decoration,
    this.backgroundColor: const Color(0xFF323D6C),
    this.textStyle: const TextStyle(
        color: Color(0xFF535353), fontSize: 11, fontWeight: FontWeight.w400),
    this.subtitleStyle:
        const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF363636)),
  }) : assert(end.isAfter(start));
}
