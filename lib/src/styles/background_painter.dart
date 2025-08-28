import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/time_slot.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';

class BackgroundPainter extends CustomPainter {
  final AgendaStyle agendaStyle;

  BackgroundPainter({
    required this.agendaStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = agendaStyle.mainBackgroundColor,
    );
    
    if (agendaStyle.visibleTimeBorder) {
      _paintTimeBorders(canvas, size);
    }

    if (agendaStyle.visibleDecorationBorder) {
      _paintDecorationLines(canvas, size);
    }
  }

  void _paintTimeBorders(Canvas canvas, Size size) {
    if (agendaStyle.enableMultiDayEvents == true) {
      _paintMultiDayTimeBorders(canvas, size);
    } else {
      _paintSingleDayTimeBorders(canvas, size);
    }
  }

  void _paintSingleDayTimeBorders(Canvas canvas, Size size) {
    // Original single-day logic
    for (int hour = 1; hour < 24; hour++) {
      double topOffset = calculateTopOffset(hour);
      canvas.drawLine(
        Offset(0, topOffset),
        Offset(size.width, topOffset),
        Paint()..color = agendaStyle.timelineBorderColor,
      );
    }
  }

  void _paintMultiDayTimeBorders(Canvas canvas, Size size) {
    final startDate = agendaStyle.timelineStartDate ?? DateTime.now();
    final endDate = agendaStyle.timelineEndDate ?? startDate.add(const Duration(days: 1));
    
    // Calculate total days
    final daysCount = endDate.difference(startDate).inDays + 1;
    
    // Calculate heights
    final dayHeight = (agendaStyle.endHour - agendaStyle.startHour) * agendaStyle.timeSlot.height;
    final daySeparatorHeight = agendaStyle.daySeparatorHeight ?? 40.0;
    
    double currentYOffset = 0.0;
    
    for (int dayIndex = 0; dayIndex < daysCount; dayIndex++) {
      // Define the strict boundaries of this day's area
      final dayStartY = currentYOffset;
      final dayEndY = currentYOffset + dayHeight;
      
      // Paint hour lines ONLY within this day's area (never in separator areas)
      for (int hour = agendaStyle.startHour + 1; hour < agendaStyle.endHour; hour++) {
        double hourOffsetInDay = (hour - agendaStyle.startHour) * agendaStyle.timeSlot.height;
        double totalOffset = dayStartY + hourOffsetInDay;
        
        // STRICT CHECK: Only paint if strictly within the day area and canvas bounds
        if (totalOffset >= dayStartY && 
            totalOffset < dayEndY && 
            totalOffset < size.height) {
          canvas.drawLine(
            Offset(0, totalOffset),
            Offset(size.width, totalOffset),
            Paint()..color = agendaStyle.timelineBorderColor,
          );
        }
      }
      
      // Move to next day position (add day height)
      currentYOffset += dayHeight;
      
      // Paint day separator area (except for last day)
      // This creates a clean white/colored area where day names appear
      if (dayIndex < daysCount - 1) {
        // Paint solid color area for the day separator space
        if (currentYOffset < size.height) {
          canvas.drawRect(
            Rect.fromLTWH(0, currentYOffset, size.width, daySeparatorHeight),
            Paint()..color = agendaStyle.daySeparatorColor ?? Colors.white,
          );
        }
        
        // Add day separator height for next iteration
        currentYOffset += daySeparatorHeight;
      }
    }
  }

  void _paintDecorationLines(Canvas canvas, Size size) {
    if (agendaStyle.enableMultiDayEvents == true) {
      _paintMultiDayDecorationLines(canvas, size);
    } else {
      _paintSingleDayDecorationLines(canvas, size);
    }
  }

  void _paintSingleDayDecorationLines(Canvas canvas, Size size) {
    // Original single-day decoration logic
    final drawLimit = size.height / agendaStyle.decorationLineHeight;
    for (double count = 0; count < drawLimit; count += 1) {
      double topOffset = calculateDecorationLineOffset(count);
      final paint = Paint()..color = agendaStyle.decorationLineBorderColor;
      final dashWidth = agendaStyle.decorationLineDashWidth;
      final dashSpace = agendaStyle.decorationLineDashSpaceWidth;
      var startX = 0.0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, topOffset),
          Offset(startX + agendaStyle.decorationLineDashWidth, topOffset),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  void _paintMultiDayDecorationLines(Canvas canvas, Size size) {
    final startDate = agendaStyle.timelineStartDate ?? DateTime.now();
    final endDate = agendaStyle.timelineEndDate ?? startDate.add(const Duration(days: 1));
    
    // Calculate total days
    final daysCount = endDate.difference(startDate).inDays + 1;
    
    // Calculate heights
    final dayHeight = (agendaStyle.endHour - agendaStyle.startHour) * agendaStyle.timeSlot.height;
    final daySeparatorHeight = agendaStyle.daySeparatorHeight ?? 40.0;
    
    double currentYOffset = 0.0;
    
    for (int dayIndex = 0; dayIndex < daysCount; dayIndex++) {
      // Define the strict boundaries of this day's area
      final dayStartY = currentYOffset;
      final dayEndY = currentYOffset + dayHeight;
      
      // Paint decoration lines ONLY within this day's area (never in separator areas)
      final dayDrawLimit = dayHeight / agendaStyle.decorationLineHeight;
      for (double count = 0; count < dayDrawLimit; count += 1) {
        double decorationOffsetInDay = count * agendaStyle.decorationLineHeight;
        double totalOffset = dayStartY + decorationOffsetInDay;
        
        // STRICT CHECK: Only paint if strictly within the day area and canvas bounds
        if (totalOffset >= dayStartY && 
            totalOffset < dayEndY && 
            totalOffset < size.height) {
          
          final paint = Paint()..color = agendaStyle.decorationLineBorderColor;
          final dashWidth = agendaStyle.decorationLineDashWidth;
          final dashSpace = agendaStyle.decorationLineDashSpaceWidth;
          var startX = 0.0;
          
          while (startX < size.width) {
            canvas.drawLine(
              Offset(startX, totalOffset),
              Offset(startX + agendaStyle.decorationLineDashWidth, totalOffset),
              paint,
            );
            startX += dashWidth + dashSpace;
          }
        }
      }
      
      // Move to next day position (add day height)
      currentYOffset += dayHeight;
      
      // Add day separator height (except for last day)
      // This creates the gap where day names appear - NO PAINTING HERE
      if (dayIndex < daysCount - 1) {
        currentYOffset += daySeparatorHeight;
      }
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDayViewBackgroundPainter) {
    return (agendaStyle.mainBackgroundColor !=
            oldDayViewBackgroundPainter.agendaStyle.mainBackgroundColor ||
        agendaStyle.timelineBorderColor !=
            oldDayViewBackgroundPainter.agendaStyle.timelineBorderColor);
  }

  double calculateTopOffset(int hour) => hour * agendaStyle.timeSlot.height;

  double calculateDecorationLineOffset(double count) =>
      count * agendaStyle.decorationLineHeight;
}
