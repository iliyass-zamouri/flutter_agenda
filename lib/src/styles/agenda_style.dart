import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/header_logo.dart';
import 'package:flutter_agenda/src/models/time_slot.dart';

class AgendaStyle {
  /// Customizing the agenda view to match you own UI approach.
  const AgendaStyle({
    this.startHour: 0,
    this.endHour: 24,
    this.cornerBottom: true,
    this.cornerRight: true,
    this.pillarColor: Colors.white,
    this.cornerColor: Colors.white,
    this.timelineColor: Colors.white,
    this.timelineItemColor: Colors.white,
    this.headSeperator: false,
    this.pillarSeperator: false,
    this.mainBackgroundColor: Colors.white,
    this.decorationLineBorderColor: const Color(0xFFCECECE),
    // this.eventBackgroundColor: Colors.white,
    this.headBottomBorder = true,
    this.fittedWidth = true,
    this.timelineBorderColor: const Color(0xFF7F7F7F),
    this.timeItemTextColor: const Color(0xFF7B7B7B),
    this.eventRadius: 5,
    this.timeItemTextStyle: const TextStyle(
        color: Color(0xFFF999999), fontSize: 11, fontWeight: FontWeight.w300),
    this.pillarWidth: 200,
    this.headerHeight: 50,
    this.timeSlot: TimeSlot.half,
    this.headerLogo = HeaderLogo.circle,
    this.timeItemWidth: 70,
    this.decorationLineHeight: 20,
    this.decorationLineDashWidth: 4,
    this.decorationLineDashSpaceWidth: 4,
    this.eventBorderWidth: 4,
    this.visibleTimeBorder: true,
    this.visibleDecorationBorder: true,
  });

  ///Timeline start hour.
  ///
  /// it doesn't support period format.
  final int startHour;

  ///Timeline end hour.
  ///
  /// it doesn't support period format.
  final int endHour;

  final Color pillarColor;

  final HeaderLogo headerLogo;

  final Color cornerColor;

  final bool cornerBottom;

  final bool cornerRight;

  final Color timeItemTextColor;

  final Color timelineColor;

  final Color timelineItemColor;

  final Color mainBackgroundColor;

  final double eventRadius;

  final Color timelineBorderColor;

  final bool headBottomBorder;

  // final Color eventBackgroundColor;

  final Color decorationLineBorderColor;

  // pillar width
  final double pillarWidth;

  final bool fittedWidth;

  final bool headSeperator;

  final bool pillarSeperator;

  final double headerHeight;

  /// this timeSlot is so important.
  ///
  /// - TimeSlot.full: 15min timeline view.
  ///
  /// you get a 160 height time slot
  ///
  /// - TimeSlot.half: 30min timeline view
  ///
  /// you get a 80 height time slot
  ///
  /// - TimeSlot.quarter: 1h timeline view
  ///
  /// you get a 60 height time slot
  final TimeSlot timeSlot;

  final double timeItemWidth;

  final double decorationLineHeight;

  final double decorationLineDashWidth;

  final double eventBorderWidth;

  final TextStyle timeItemTextStyle;

  final double decorationLineDashSpaceWidth;

  final bool visibleTimeBorder;

  final bool visibleDecorationBorder;
}
