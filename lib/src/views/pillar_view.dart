import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';
import 'package:flutter_agenda/src/styles/background_painter.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';
import 'package:flutter_agenda/src/views/event_view.dart';

class PillarView extends StatelessWidget {
  final dynamic headObject;
  final List<AgendaEvent> events;
  final AgendaStyle agendaStyle;
  final Function(EventTime, dynamic)? callBack;

  PillarView({
    Key? key,
    required this.headObject,
    required this.events,
    required this.agendaStyle,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressEnd: (tapdetails) => callBack!(
          tappedHour(tapdetails.localPosition.dy, agendaStyle.timeItemHeight,
              agendaStyle.startHour),
          headObject),
      child: Container(
        height: height(),
        width: agendaStyle.pillarHeadWidth,
        decoration: agendaStyle.headSeperator
            ? BoxDecoration(
                border: Border(left: BorderSide(color: Color(0xFFCECECE))))
            : BoxDecoration(),
        child: Stack(
          children: [
            ...[
              Positioned.fill(
                child: CustomPaint(
                  painter: BackgroundPainter(
                    agendaStyle: agendaStyle,
                  ),
                ),
              )
            ],
            ...events.map((event) {
              return EventView(
                event: event,
                agendaStyle: agendaStyle,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  EventTime tappedHour(double tapPosition, double itemHeight, int startHour) {
    double hourCount = (tapPosition / itemHeight);
    int hour = (startHour + hourCount.floor());
    int minute = hourCount - hourCount.floor() >= 0.5 ? 30 : 0;
    return EventTime(hour: hour, minute: minute);
  }

  double height() {
    return (agendaStyle.endHour - agendaStyle.startHour) *
        agendaStyle.timeItemHeight;
  }
}
