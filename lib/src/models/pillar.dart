import 'package:flutter_agenda/src/models/pillar_head.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';

class Pillar {
  /// Pillar object helps link the resource with his appointments.

  /// [head] employee/resource.
  final PillarHead head;

  /// [events] (appointments/Todos) linked to the head.
  final List<AgendaEvent> events;

  Pillar({
    required this.head,
    required this.events,
  });
}
