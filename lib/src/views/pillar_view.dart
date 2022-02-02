import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';
import 'package:flutter_agenda/src/styles/background_painter.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';
import 'package:flutter_agenda/src/views/event_view.dart';

class PillarView extends StatelessWidget {
  final List<AgendaEvent> events;
  final AgendaStyle agendaStyle;

  const PillarView({
    Key? key,
    required this.events,
    required this.agendaStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(),
      width: agendaStyle.pillarWidth,
      decoration: agendaStyle.pillarSeparator
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
    );
  }

  double height() {
    return (agendaStyle.endHour - agendaStyle.startHour) *
        agendaStyle.timeItemHeight;
  }
}
