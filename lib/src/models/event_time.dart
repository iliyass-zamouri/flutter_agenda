

/// Base class for event time representation
abstract class EventTime {
  final int hour;
  final int minute;

  const EventTime({
    required this.hour,
    required this.minute,
  }) : assert(24 >= hour),
       assert(60 >= minute);

  /// Check if this time is after another time
  bool isAfter(EventTime other);
  
  /// Check if this time is before another time
  bool isBefore(EventTime other);
  
  /// Check if this time is equal to another time
  bool isEqual(EventTime other);
  
  /// Get the difference in minutes between this time and another
  int differenceInMinutes(EventTime other);
  
  /// Get the difference in hours between this time and another
  double differenceInHours(EventTime other);
  
  /// Convert to DateTime for calculations
  DateTime toDateTime();
  
  /// Get display text for the time
  String getDisplayText();
}

/// Legacy EventTime implementation for single-day events
class SingleDayEventTime extends EventTime {
  SingleDayEventTime({
    required int hour,
    required int minute,
  }) : super(hour: hour, minute: minute);

  @override
  bool isAfter(EventTime other) {
    if (other is SingleDayEventTime) {
      if (hour > other.hour) return true;
      if (hour == other.hour) return minute > other.minute;
      return false;
    }
    // For multi-day events, single-day times are considered "before"
    return false;
  }

  @override
  bool isBefore(EventTime other) {
    if (other is SingleDayEventTime) {
      if (hour < other.hour) return true;
      if (hour == other.hour) return minute < other.minute;
      return false;
    }
    // For multi-day events, single-day times are considered "before"
    return true;
  }

  @override
  bool isEqual(EventTime other) {
    if (other is SingleDayEventTime) {
      return hour == other.hour && minute == other.minute;
    }
    return false;
  }

  @override
  int differenceInMinutes(EventTime other) {
    if (other is SingleDayEventTime) {
      return (hour * 60 + minute) - (other.hour * 60 + other.minute);
    }
    // For multi-day events, calculate based on DateTime
    return toDateTime().difference(other.toDateTime()).inMinutes;
  }

  @override
  double differenceInHours(EventTime other) {
    if (other is SingleDayEventTime) {
      return (hour + minute / 60.0) - (other.hour + other.minute / 60.0);
    }
    // For multi-day events, calculate based on DateTime
    return toDateTime().difference(other.toDateTime()).inHours.toDouble();
  }

  @override
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  @override
  String getDisplayText() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  String toString() => 'SingleDayEventTime($hour:$minute)';
}

/// New EventTime implementation for multi-day events
class DateTimeEventTime extends EventTime {
  final DateTime dateTime;

  DateTimeEventTime({
    required int hour,
    required int minute,
    required DateTime dateTime,
  }) : dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, hour, minute),
       super(hour: hour, minute: minute);

  /// Create from a DateTime object
  factory DateTimeEventTime.fromDateTime(DateTime dateTime) {
    return DateTimeEventTime(
      hour: dateTime.hour,
      minute: dateTime.minute,
      dateTime: dateTime,
    );
  }

  /// Create from year, month, day, hour, minute
  factory DateTimeEventTime.fromComponents({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) {
    return DateTimeEventTime(
      hour: hour,
      minute: minute,
      dateTime: DateTime(year, month, day, hour, minute),
    );
  }

  @override
  bool isAfter(EventTime other) {
    if (other is DateTimeEventTime) {
      return dateTime.isAfter(other.dateTime);
    }
    // Single-day events are considered "before" multi-day events
    return true;
  }

  @override
  bool isBefore(EventTime other) {
    if (other is DateTimeEventTime) {
      return dateTime.isBefore(other.dateTime);
    }
    // Single-day events are considered "before" multi-day events
    return false;
  }

  @override
  bool isEqual(EventTime other) {
    if (other is DateTimeEventTime) {
      return dateTime.isAtSameMomentAs(other.dateTime);
    }
    return false;
  }

  @override
  int differenceInMinutes(EventTime other) {
    if (other is DateTimeEventTime) {
      return dateTime.difference(other.dateTime).inMinutes;
    }
    // For single-day events, calculate based on DateTime
    return dateTime.difference(other.toDateTime()).inMinutes;
  }

  @override
  double differenceInHours(EventTime other) {
    if (other is DateTimeEventTime) {
      return dateTime.difference(other.dateTime).inHours.toDouble();
    }
    // For single-day events, calculate based on DateTime
    return dateTime.difference(other.toDateTime()).inHours.toDouble();
  }

  @override
  DateTime toDateTime() => dateTime;

  @override
  String getDisplayText() {
    final dayName = _getDayName(dateTime.weekday);
    return '$dayName ${dateTime.day}/${dateTime.month} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  /// Get the day of the week
  int get dayOfWeek => dateTime.weekday;
  
  /// Get the day of the month
  int get day => dateTime.day;
  
  /// Get the month
  int get month => dateTime.month;
  
  /// Get the year
  int get year => dateTime.year;

  @override
  String toString() => 'DateTimeEventTime(${dateTime.toIso8601String()})';
}

/// Factory function to create EventTime instances
/// This maintains backward compatibility while allowing new multi-day functionality
EventTime createEventTime({
  int? hour,
  int? minute,
  DateTime? dateTime,
}) {
  if (dateTime != null) {
    return DateTimeEventTime.fromDateTime(dateTime);
  }
  return SingleDayEventTime(hour: hour ?? 0, minute: minute ?? 0);
}
