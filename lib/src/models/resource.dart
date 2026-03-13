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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Resource &&
          runtimeType == other.runtimeType &&
          head == other.head &&
          _listEquals(events, other.events);

  @override
  int get hashCode => Object.hash(head, Object.hashAll(events));

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
