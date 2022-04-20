import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/header_logo.dart';
import 'package:flutter_agenda/src/models/time_slot.dart';

class AgendaStyle {
  /// Customize the agenda to match you own UI approach.
  /// by defaut the styles are great but you can change them.
  const AgendaStyle({
    this.startHour: 0,
    this.endHour: 24,
    this.direction: TextDirection.ltr,
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

  final TextDirection direction;

  ///Timeline start hour.
  ///
  /// it doesn't support period format.
  final int startHour;

  ///Timeline end hour.
  ///
  /// it doesn't support period format.
  final int endHour;

  /// pillar color.
  final Color pillarColor;

  /// the style of the header logo
  final HeaderLogo headerLogo;

  /// the top left corner color
  final Color cornerColor;

  /// the is corner bottom border is active
  final bool cornerBottom;

  /// the is corner right border is active
  final bool cornerRight;

  /// the time item [hour] text color
  final Color timeItemTextColor;

  /// the time line color
  final Color timelineColor;

  /// the time line item color
  final Color timelineItemColor;

  /// main body background color
  final Color mainBackgroundColor;

  /// event border Radius
  final double eventRadius;

  /// the time line border color
  final Color timelineBorderColor;

  /// head bottom border
  final bool headBottomBorder;

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

  /// the time item width
  final double timeItemWidth;

  /// decoration line height
  final double decorationLineHeight;

  /// decoration line dash width
  final double decorationLineDashWidth;

  /// event left border width
  final double eventBorderWidth;

  /// time item text style
  final TextStyle timeItemTextStyle;

  /// decoration line dash space width
  final double decorationLineDashSpaceWidth;

  /// visible time border
  final bool visibleTimeBorder;

  /// visible decoration border
  final bool visibleDecorationBorder;
}
