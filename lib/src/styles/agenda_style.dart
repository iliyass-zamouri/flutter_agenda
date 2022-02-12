import 'package:flutter/material.dart';

class AgendaStyle {
  final int startHour;

  final int endHour;

  final Color pillarColor;

  final Color cornerColor;

  final Color timeItemTextColor;

  final Color timelineColor;

  final Color timelineItemColor;

  final Color mainBackgroundColor;

  final double eventRadius;

  final Color timelineBorderColor;

  final bool headBottomBorder;

  // final Color eventBackgroundColor;

  final Color decorationLineBorderColor;

  final double pillarHeadWidth;

  final double pillarHeadHeight;

  final double timeItemHeight;

  final double timeItemWidth;

  final double decorationLineHeight;

  final double decorationLineDashWidth;

  final double eventBorderWidth;

  final bool pillarSeparator;

  final TextStyle timeItemTextStyle;

  final double decorationLineDashSpaceWidth;

  final bool visibleTimeBorder;

  final bool visibleDecorationBorder;

  const AgendaStyle({
    this.startHour: 0,
    this.endHour: 24,
    this.pillarColor: Colors.white,
    this.cornerColor: Colors.white,
    this.timelineColor: Colors.white,
    this.timelineItemColor: Colors.white,
    this.mainBackgroundColor: Colors.white,
    this.decorationLineBorderColor: const Color(0xFFCECECE),
    // this.eventBackgroundColor: Colors.white,
    this.headBottomBorder = true,
    this.timelineBorderColor: const Color(0xFFE6E6E6),
    this.timeItemTextColor: const Color(0xFF7B7B7B),
    this.eventRadius: 5,
    this.timeItemTextStyle: const TextStyle(
        color: Color(0xFFF999999), fontSize: 11, fontWeight: FontWeight.w300),
    this.pillarHeadWidth: 160,
    this.pillarHeadHeight: 50,
    this.timeItemHeight: 80,
    this.timeItemWidth: 70,
    this.decorationLineHeight: 20,
    this.decorationLineDashWidth: 4,
    this.decorationLineDashSpaceWidth: 4,
    this.eventBorderWidth: 4,
    this.visibleTimeBorder: true,
    this.pillarSeparator: true,
    this.visibleDecorationBorder: true,
  });
}
