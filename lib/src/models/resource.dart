import 'package:flutter_agenda/src/models/header.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';

class Resource {
  /// Pillar object helps link the resource with his appointments.

  /// [head] employee/resource.
  final Header head;

  /// [events] (appointments/Todos) linked to the head.
  final List<AgendaEvent> events;

  Resource({
    required this.head,
    required this.events,
  });
}
