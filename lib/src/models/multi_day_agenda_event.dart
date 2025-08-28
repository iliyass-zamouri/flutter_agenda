import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';
import 'package:flutter_agenda/src/models/event_time.dart';

/// Extended AgendaEvent that supports multi-day events
class MultiDayAgendaEvent extends AgendaEvent {
  final DateTime startDate;
  final DateTime endDate;
  final bool spansMultipleDays;

  MultiDayAgendaEvent({
    required String title,
    String subtitle = "",
    required this.startDate,
    required this.endDate,
    EdgeInsets padding = const EdgeInsets.all(10),
    EdgeInsets? margin,
    VoidCallback? onTap,
    BoxDecoration? decoration,
    Color backgroundColor = const Color(0xFF323D6C),
    TextStyle? textStyle,
    TextStyle? subtitleStyle,
  }) : spansMultipleDays = _calculateSpansMultipleDays(startDate, endDate),
       super(
         title: title,
         subtitle: subtitle,
         start: DateTimeEventTime.fromDateTime(startDate),
         end: DateTimeEventTime.fromDateTime(endDate),
         padding: padding,
         margin: margin,
         onTap: onTap,
         decoration: decoration,
         backgroundColor: backgroundColor,
         textStyle: textStyle ?? const TextStyle(
             color: Color(0xFF535353), fontSize: 11, fontWeight: FontWeight.w400),
         subtitleStyle: subtitleStyle ?? const TextStyle(
             fontWeight: FontWeight.w800, color: Color(0xFF363636)),
       );

  /// Create from existing AgendaEvent with date information
  factory MultiDayAgendaEvent.fromAgendaEvent(
    AgendaEvent event, {
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return MultiDayAgendaEvent(
      title: event.title,
      subtitle: event.subtitle,
      startDate: startDate,
      endDate: endDate,
      padding: event.padding,
      margin: event.margin,
      onTap: event.onTap,
      decoration: event.decoration,
      backgroundColor: event.backgroundColor,
      textStyle: event.textStyle,
      subtitleStyle: event.subtitleStyle,
    );
  }

  /// Create a multi-day event spanning from one day to another
  factory MultiDayAgendaEvent.spanningDays({
    required String title,
    String subtitle = "",
    required DateTime startDate,
    required DateTime endDate,
    EdgeInsets padding = const EdgeInsets.all(10),
    EdgeInsets? margin,
    VoidCallback? onTap,
    BoxDecoration? decoration,
    Color backgroundColor = const Color(0xFF323D6C),
    TextStyle? textStyle,
    TextStyle? subtitleStyle,
  }) {
    return MultiDayAgendaEvent(
      title: title,
      subtitle: subtitle,
      startDate: startDate,
      endDate: endDate,
      padding: padding,
      margin: margin,
      onTap: onTap,
      decoration: decoration,
      backgroundColor: backgroundColor,
      textStyle: textStyle ?? const TextStyle(
          color: Color(0xFF535353), fontSize: 11, fontWeight: FontWeight.w400),
      subtitleStyle: subtitleStyle ?? const TextStyle(
          fontWeight: FontWeight.w800, color: Color(0xFF363636)),
    );
  }

  /// Check if the event spans multiple days
  static bool _calculateSpansMultipleDays(DateTime start, DateTime end) {
    return start.day != end.day || 
           start.month != end.month || 
           start.year != end.year;
  }

  /// Get the number of days this event spans
  int get daySpan {
    return endDate.difference(startDate).inDays + 1;
  }

  /// Get the start day of the week
  int get startDayOfWeek => startDate.weekday;
  
  /// Get the end day of the week
  int get endDayOfWeek => endDate.weekday;

  /// Get a list of all dates this event spans
  List<DateTime> get spannedDates {
    final dates = <DateTime>[];
    var currentDate = DateTime(startDate.year, startDate.month, startDate.day);
    final endDay = DateTime(endDate.year, endDate.month, endDate.day);
    
    while (currentDate.isBefore(endDay) || currentDate.isAtSameMomentAs(endDay)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
    
    return dates;
  }

  /// Check if this event occurs on a specific date
  bool occursOnDate(DateTime date) {
    final checkDate = DateTime(date.year, date.month, date.day);
    final eventStart = DateTime(startDate.year, startDate.month, startDate.day);
    final eventEnd = DateTime(endDate.year, endDate.month, endDate.day);
    
    return (checkDate.isAfter(eventStart) || checkDate.isAtSameMomentAs(eventStart)) &&
           (checkDate.isBefore(eventEnd) || checkDate.isAtSameMomentAs(eventEnd));
  }

  /// Get the event duration in minutes
  int get durationInMinutes => endDate.difference(startDate).inMinutes;

  /// Get the event duration in hours
  double get durationInHours => endDate.difference(startDate).inHours.toDouble();

  @override
  String toString() {
    return 'MultiDayAgendaEvent($title: ${startDate.toIso8601String()} - ${endDate.toIso8601String()})';
  }
}
