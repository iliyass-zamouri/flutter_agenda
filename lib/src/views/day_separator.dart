import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';

/// Widget to display day separators in the multi-day timeline
class DaySeparator extends StatelessWidget {
  final DateTime date;
  final AgendaStyle agendaStyle;
  final bool isFirstDay;
  final bool isLastDay;

  const DaySeparator({
    Key? key,
    required this.date,
    required this.agendaStyle,
    this.isFirstDay = false,
    this.isLastDay = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: agendaStyle.daySeparatorHeight ?? 40.0,
      decoration: BoxDecoration(
        color: agendaStyle.daySeparatorColor ?? Colors.grey[200],
        border: Border(
          top: BorderSide(
            color: agendaStyle.daySeparatorBorderColor ?? Colors.grey[400]!,
            width: 2.0,
          ),
          bottom: BorderSide(
            color: agendaStyle.daySeparatorBorderColor ?? Colors.grey[400]!,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Day name and date
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getDayName(date.weekday),
                    style: agendaStyle.daySeparatorTextStyle ?? const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${date.day}/${date.month}/${date.year}',
                    style: agendaStyle.daySeparatorSubtextStyle ?? const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Day indicator
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              color: agendaStyle.daySeparatorIndicatorColor ?? Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }
}

/// Widget to display a compact day header for the timeline
class TimelineDayHeader extends StatelessWidget {
  final DateTime date;
  final AgendaStyle agendaStyle;

  const TimelineDayHeader({
    Key? key,
    required this.date,
    required this.agendaStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: agendaStyle.daySeparatorHeight ?? 40.0,
      decoration: BoxDecoration(
        color: agendaStyle.timelineColor,
        border: Border(
          right: BorderSide(
            color: agendaStyle.timelineBorderColor.withOpacity(0.5),
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getDayName(date.weekday),
              style: agendaStyle.daySeparatorTextStyle ?? const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              '${date.day}/${date.month}',
              style: agendaStyle.daySeparatorSubtextStyle ?? const TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
