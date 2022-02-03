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

  final Color timelineBorderColor;

  final Color decorationLineBorderColor;

  final double pillarWidth;

  final double pillarHeight;

  final double timeItemHeight;

  final double timeItemWidth;

  final double decorationLineHeight;

  final double decorationLineDashWidth;

  final double eventBorderWidth;

  final bool pillarSeparator;

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
    this.decorationLineBorderColor: const Color(0x1A000000),
    this.timelineBorderColor: const Color(0xFFCECECE),
    this.timeItemTextColor: const Color(0xFF7B7B7B),
    this.pillarWidth: 200,
    this.pillarHeight: 40,
    this.timeItemHeight: 80,
    this.timeItemWidth: 70,
    this.decorationLineHeight: 20,
    this.decorationLineDashWidth: 9,
    this.decorationLineDashSpaceWidth: 4,
    this.eventBorderWidth: 8,
    this.visibleTimeBorder: true,
    this.pillarSeparator: true,
    this.visibleDecorationBorder: true,
  });
}
