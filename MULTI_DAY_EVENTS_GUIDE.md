# Multi-Day Events Guide for Flutter Agenda

## 🚀 Overview

Flutter Agenda now supports **multi-day events**, allowing you to create events that span across different days. This is perfect for:
- **24/7 queue systems**
- **Conference schedules**
- **Night shifts**
- **Long-running processes**
- **Cross-day appointments**

## ✨ Key Features

### 1. **Backward Compatibility**
- Existing single-day events continue to work unchanged
- No breaking changes to your current code
- Gradual migration path available

### 2. **Flexible Event Types**
- **SingleDayEventTime**: Traditional hour:minute events (existing functionality)
- **DateTimeEventTime**: Full date + time events with multi-day support
- **MultiDayAgendaEvent**: Extended agenda events with date ranges

### 3. **Smart Time Handling**
- Automatic day boundary detection
- Cross-day event duration calculations
- Proper time comparisons across days

## 📱 Basic Usage

### Creating Single-Day Events (Existing Way)

```dart
AgendaEvent(
  title: 'Meeting',
  subtitle: 'Team Sync',
  start: SingleDayEventTime(hour: 9, minute: 0),
  end: SingleDayEventTime(hour: 10, minute: 30),
  backgroundColor: Colors.blue,
)
```

### Creating Multi-Day Events

```dart
// Method 1: Using MultiDayAgendaEvent.spanningDays
MultiDayAgendaEvent.spanningDays(
  title: 'Night Shift',
  subtitle: '24/7 Support',
  startDate: DateTime(2024, 1, 15, 22, 0), // Jan 15, 10:00 PM
  endDate: DateTime(2024, 1, 16, 3, 0),   // Jan 16, 3:00 AM
  backgroundColor: Colors.purple,
  onTap: () => print('Night shift details'),
)

// Method 2: Using DateTimeEventTime directly
AgendaEvent(
  title: 'Conference',
  subtitle: 'Tech Summit',
  start: DateTimeEventTime.fromDateTime(
    DateTime(2024, 1, 20, 9, 0), // Jan 20, 9:00 AM
  ),
  end: DateTimeEventTime.fromDateTime(
    DateTime(2024, 1, 22, 17, 0), // Jan 22, 5:00 PM
  ),
  backgroundColor: Colors.orange,
)
```

### Enabling Multi-Day Support

```dart
AgendaStyle(
  // ... other properties
  enableMultiDayEvents: true,
  timelineStartDate: DateTime.now(),
  timelineEndDate: DateTime.now().add(Duration(days: 7)),
  daySeparatorHeight: 50.0,
  daySeparatorColor: Colors.grey[100],
  daySeparatorBorderColor: Colors.grey[400]!,
)
```

## 🔧 Advanced Features

### Event Duration Calculations

```dart
MultiDayAgendaEvent event = MultiDayAgendaEvent.spanningDays(
  title: 'Long Event',
  startDate: DateTime(2024, 1, 15, 10, 0),
  endDate: DateTime(2024, 1, 17, 16, 0),
);

print('Duration: ${event.durationInHours} hours'); // 54.0 hours
print('Days spanned: ${event.daySpan}'); // 3 days
print('Spans multiple days: ${event.spansMultipleDays}'); // true
```

### Date Range Queries

```dart
// Check if event occurs on a specific date
DateTime checkDate = DateTime(2024, 1, 16);
bool occursOnDate = event.occursOnDate(checkDate); // true

// Get all dates this event spans
List<DateTime> spannedDates = event.spannedDates;
// [2024-01-15, 2024-01-16, 2024-01-17]
```

### Factory Methods

```dart
// Create from existing AgendaEvent
AgendaEvent existingEvent = AgendaEvent(/* ... */);
MultiDayAgendaEvent multiDayEvent = MultiDayAgendaEvent.fromAgendaEvent(
  existingEvent,
  startDate: DateTime(2024, 1, 15, 9, 0),
  endDate: DateTime(2024, 1, 16, 17, 0),
);

// Create with components
DateTimeEventTime customTime = DateTimeEventTime.fromComponents(
  year: 2024,
  month: 1,
  day: 15,
  hour: 14,
  minute: 30,
);
```

## 🎨 Customization

### Day Separator Styling

```dart
AgendaStyle(
  // ... other properties
  daySeparatorHeight: 60.0,
  daySeparatorColor: Colors.blue[50],
  daySeparatorBorderColor: Colors.blue[300]!,
  daySeparatorTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blue[800],
  ),
  daySeparatorSubtextStyle: TextStyle(
    fontSize: 12,
    color: Colors.blue[600],
  ),
  daySeparatorIndicatorColor: Colors.blue,
)
```

### Timeline Configuration

```dart
AgendaStyle(
  // ... other properties
  startHour: 0,        // Start from midnight
  endHour: 24,         // End at midnight
  timeSlot: TimeSlot.half, // 30-minute intervals
)
```

## 📊 Real-World Examples

### 1. **24/7 Queue System**

```dart
List<AgendaEvent> queueEvents = [
  // Monday night shift
  MultiDayAgendaEvent.spanningDays(
    title: 'Night Shift 1',
    subtitle: 'Queue Processing',
    startDate: DateTime(2024, 1, 15, 22, 0), // Monday 10 PM
    endDate: DateTime(2024, 1, 16, 6, 0),   // Tuesday 6 AM
    backgroundColor: Colors.indigo,
  ),
  
  // Tuesday day shift
  MultiDayAgendaEvent.spanningDays(
    title: 'Day Shift 1',
    subtitle: 'Queue Processing',
    startDate: DateTime(2024, 1, 16, 6, 0),  // Tuesday 6 AM
    endDate: DateTime(2024, 1, 16, 22, 0),  // Tuesday 10 PM
    backgroundColor: Colors.green,
  ),
];
```

### 2. **Conference Schedule**

```dart
List<AgendaEvent> conferenceEvents = [
  MultiDayAgendaEvent.spanningDays(
    title: 'Tech Conference 2024',
    subtitle: 'Main Event',
    startDate: DateTime(2024, 1, 20, 9, 0),  // Monday 9 AM
    endDate: DateTime(2024, 1, 22, 17, 0),  // Wednesday 5 PM
    backgroundColor: Colors.orange,
  ),
  
  MultiDayAgendaEvent.spanningDays(
    title: 'Workshop Day',
    subtitle: 'Hands-on Sessions',
    startDate: DateTime(2024, 1, 23, 10, 0), // Thursday 10 AM
    endDate: DateTime(2024, 1, 23, 18, 0),  // Thursday 6 PM
    backgroundColor: Colors.teal,
  ),
];
```

### 3. **Maintenance Windows**

```dart
List<AgendaEvent> maintenanceEvents = [
  MultiDayAgendaEvent.spanningDays(
    title: 'System Maintenance',
    subtitle: 'Database Update',
    startDate: DateTime(2024, 1, 15, 23, 0), // Monday 11 PM
    endDate: DateTime(2024, 1, 16, 5, 0),   // Tuesday 5 AM
    backgroundColor: Colors.red,
  ),
];
```

## 🔄 Migration Guide

### From Single-Day to Multi-Day

**Before (Single-Day):**
```dart
AgendaEvent(
  title: 'Meeting',
  start: EventTime(hour: 9, minute: 0),  // ❌ This won't work anymore
  end: EventTime(hour: 10, minute: 0),   // ❌ This won't work anymore
)
```

**After (Single-Day):**
```dart
AgendaEvent(
  title: 'Meeting',
  start: SingleDayEventTime(hour: 9, minute: 0),  // ✅ Use SingleDayEventTime
  end: SingleDayEventTime(hour: 10, minute: 0),   // ✅ Use SingleDayEventTime
)
```

**After (Multi-Day):**
```dart
MultiDayAgendaEvent.spanningDays(
  title: 'Meeting',
  startDate: DateTime(2024, 1, 15, 9, 0),
  endDate: DateTime(2024, 1, 15, 10, 0),
)
```

## 🚨 Important Notes

1. **EventTime is now abstract**: Use `SingleDayEventTime` or `DateTimeEventTime`
2. **Multi-day events require date information**: Cannot create cross-day events with just hours
3. **Timeline rendering**: Multi-day events are properly positioned across day boundaries
4. **Performance**: Events are efficiently rendered with minimal rebuilds

## 🎯 Best Practices

1. **Use SingleDayEventTime** for events within the same day
2. **Use MultiDayAgendaEvent.spanningDays** for cross-day events
3. **Set appropriate timeline ranges** to avoid unnecessary rendering
4. **Customize day separators** for better visual clarity
5. **Handle time zones** appropriately in your date calculations

## 🔗 Related Files

- `lib/src/models/event_time.dart` - Base EventTime classes
- `lib/src/models/multi_day_agenda_event.dart` - Multi-day event model
- `lib/src/views/day_separator.dart` - Day separator widgets
- `lib/src/styles/agenda_style.dart` - Multi-day styling options

---

**🎉 Congratulations!** You now have a powerful, flexible agenda system that can handle both simple appointments and complex multi-day schedules. Perfect for 24/7 operations, conferences, and any scenario where events span across days.
