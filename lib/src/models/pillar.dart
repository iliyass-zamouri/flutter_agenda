import 'package:flutter_agenda/src/models/pillar_head.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';

class Pillar {
  final PillarHead head;

  final List<AgendaEvent> events;

  Pillar({
    required this.head,
    required this.events,
  });
}
