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
      for (int hour = 1; hour < 24; hour++) {
        double topOffset = calculateTopOffset(hour);
        canvas.drawLine(
          Offset(0, topOffset),
          Offset(size.width, topOffset),
          Paint()..color = agendaStyle.timelineBorderColor,
        );
      }
    }

    if (agendaStyle.visibleDecorationBorder) {
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
