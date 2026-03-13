# Flutter Agenda

![Pub Version](https://img.shields.io/pub/v/flutter_agenda?label=Flutter%20Agenda&logo=flutter)

A powerful and flexible Agenda Widget Package for Flutter with **Multi-Day Timeline Support**! Perfect for 24/7 operations, shift scheduling, and extended event management.

## ✨ Features

- 🎯 **Multi-Day Timeline Support** - Events spanning across multiple days (e.g., Monday 22:00 → Tuesday 03:00)
- 📊 **Diagonal Scrolling** - Smooth and intuitive navigation
- 🎨 **Beautiful UI** - Modern and customizable design
- 📱 **Responsive Design** - Adapts to different screen sizes
- 👆 **Smart Touch Events** - OnTap events with scroll detection
- 🎨 **Custom Styling** - Fully customizable appearance
- ⚡ **High Performance** - Optimized state management prevents unnecessary rebuilds
- 🔄 **Flexible Headers** - Configurable position (top/bottom)
- 📐 **Precise Time Slots** - Quarter, half-hour, and hourly options
- 🌐 **RTL/LTR Support** - Multi-directional text support

# Show case

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.png" />

**iPad Simulator (Multi-Day View)**

![Flutter Agenda on iPad](Simulator%20Screenshot%20-%20iPad%20(A16).png)

<!-- If the image doesn't load on GitHub, ensure the file is committed to the repo root -->

# Install

```yaml
dependencies:
  flutter_agenda: ^6.0.0
```

```dart
import 'package:flutter_agenda/flutter_agenda.dart';
```

## How to use it

---

## 📅 Single-Day Calendar View

The **single-day view** displays a timeline for one day only. It’s ideal for daily scheduling: office hours, meetings, appointments, or any scenario where events occur within a single day.

### When to Use Single-Day View

- Daily appointment scheduling (e.g. 9 AM–5 PM)
- Meeting room or resource booking within one day
- Classroom timetables
- Personal daily planners

### Configuration

```dart
FlutterAgenda(
  resources: resources,
  agendaStyle: AgendaStyle(
    // Time range for the day (e.g. 9 AM to 8 PM)
    startHour: 9,
    endHour: 20,
    
    // Leave false or omit – single-day mode is the default
    enableMultiDayEvents: false,
    
    direction: TextDirection.ltr,
    headerLogo: HeaderLogo.bar,
    timeItemWidth: 45,
    timeSlot: TimeSlot.quarter,
    headersPosition: HeadersPosition.top, // or HeadersPosition.bottom
  ),
  onTap: (clickedTime, object) {
    // clickedTime is always SingleDayEventTime in single-day mode
    print("Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
    print("Resource object: $object");
  },
)
```

### Timeline Structure (Single-Day)

- One column of hours from `startHour` to `endHour`
- Each hour is split by `timeSlot` (15 min, 30 min, or 1 hour)
- Resources/columns are horizontal; time runs vertically

### Key Properties for Single-Day

| Property      | Description                                           | Example    |
|---------------|-------------------------------------------------------|------------|
| `startHour`   | First hour shown (0–24)                               | `9`        |
| `endHour`     | Last hour shown (0–24)                                | `20`       |
| `timeSlot`    | Granularity and row height: `TimeSlot.quarter` (15 min, 160px), `TimeSlot.half` (30 min, 80px), `TimeSlot.full` (1h, 60px) | `TimeSlot.half` |
| `timeItemWidth` | Width of the time column                             | `45`       |
| `enableMultiDayEvents` | Must be `false` (default) for single-day       | `false`    |

### Events in Single-Day View

Use `AgendaEvent` with `SingleDayEventTime`:

```dart
AgendaEvent(
  title: "Team Meeting",
  subtitle: "Conference Room A",
  start: SingleDayEventTime(hour: 10, minute: 0),
  end: SingleDayEventTime(hour: 11, minute: 30),
  backgroundColor: Colors.blue,
)
```

### Single-Day `onTap` Behavior

- `clickedTime` is always `SingleDayEventTime` (hour and minute only)
- `object` is the resource’s head object (e.g. employee ID, room ID)
- Use `clickedTime.hour` and `clickedTime.minute` to create events

---

## 🌐 Multi-Day Calendar View

The **multi-day view** shows a continuous timeline across several days. Events can span midnight or multiple days, suitable for 24/7 shifts, conferences, and maintenance windows.

### When to Use Multi-Day View

- Shift planning (e.g. night shifts across midnight)
- 24/7 operations (support, manufacturing)
- Multi-day conferences or workshops
- Maintenance windows (e.g. overnight deployments)
- Events spanning several days

### Configuration

```dart
FlutterAgenda(
  resources: multiDayResources,
  agendaStyle: AgendaStyle(
    // Full 24-hour day
    startHour: 0,
    endHour: 24,
    
    // Required for multi-day view
    enableMultiDayEvents: true,
    timelineStartDate: DateTime.now(),
    timelineEndDate: DateTime.now().add(Duration(days: 7)),
    
    direction: TextDirection.ltr,
    headerLogo: HeaderLogo.bar,
    timeItemWidth: 45,
    timeSlot: TimeSlot.half,
    
    // Day separator styling (visible between days)
    daySeparatorHeight: 50.0,
    daySeparatorColor: Colors.grey[100],
    daySeparatorBorderColor: Colors.grey[400]!,
  ),
  onTap: (clickedTime, object) {
    if (clickedTime is DateTimeEventTime) {
      print("Clicked: ${clickedTime.toDateTime()}");
    } else {
      print("Clicked: ${clickedTime.hour}:${clickedTime.minute}");
    }
    print("Resource: $object");
  },
)
```

### Timeline Structure (Multi-Day)

- Timeline repeats for each day from `timelineStartDate` to `timelineEndDate`
- Between days: **day separators** show date (e.g. "Tue. 14/03")
- Events are positioned by full `DateTime` (date + time)

### Key Properties for Multi-Day

| Property                 | Description                                      | Example              |
|--------------------------|--------------------------------------------------|----------------------|
| `enableMultiDayEvents`   | Must be `true` for multi-day                     | `true`               |
| `timelineStartDate`      | First day of the timeline                        | `DateTime.now()`     |
| `timelineEndDate`        | Last day (inclusive)                             | `DateTime.now().add(Duration(days: 7))` |
| `daySeparatorHeight`     | Height of the day separator row                  | `50.0`               |
| `daySeparatorColor`      | Background color of separators                   | `Colors.grey[100]`   |
| `daySeparatorBorderColor`| Border color between days                        | `Colors.grey[400]`   |
| `daySeparatorTextStyle`  | Text style for day name/number                   | `TextStyle(...)`     |
| `daySeparatorSubtextStyle` | Text style for secondary date text             | `TextStyle(...)`     |

### Events in Multi-Day View

Use `MultiDayAgendaEvent.spanningDays` for events crossing midnight or multiple days:

```dart
// Night shift (22:00 Monday → 06:00 Tuesday)
MultiDayAgendaEvent.spanningDays(
  title: "Night Shift",
  subtitle: "24/7 Support",
  startDate: DateTime(2024, 1, 15, 22, 0),
  endDate: DateTime(2024, 1, 16, 6, 0),
  backgroundColor: Colors.indigo,
)

// 3-day conference
MultiDayAgendaEvent.spanningDays(
  title: "Tech Conference 2024",
  subtitle: "Main Event",
  startDate: DateTime(2024, 1, 20, 9, 0),
  endDate: DateTime(2024, 1, 22, 17, 0),
  backgroundColor: Colors.orange,
)
```

Both `AgendaEvent` (with `SingleDayEventTime` or `DateTimeEventTime`) and `MultiDayAgendaEvent` are supported in the same resource list.

### Multi-Day `onTap` Behavior

- `clickedTime` can be:
  - `DateTimeEventTime` when tapping in multi-day mode (includes date)
  - `SingleDayEventTime` when tapping in single-day mode
- Check type before use: `if (clickedTime is DateTimeEventTime)`
- Use `clickedTime.toDateTime()` for full `DateTime` when adding events

### Day Separator Format

Separators show:

- Line 1: Day name (Mon., Tue., etc.)
- Line 2: Day/month (e.g. 14/03)

Customize via `daySeparatorTextStyle` and `daySeparatorSubtextStyle`.

---

## 📊 Comparison: Single-Day vs Multi-Day

| Aspect              | Single-Day                    | Multi-Day                          |
|---------------------|-------------------------------|------------------------------------|
| **Timeline scope**  | One day                       | Several days                       |
| **Configuration**   | `enableMultiDayEvents: false` (default) | `enableMultiDayEvents: true`       |
| **Date range**      | N/A (uses current day)        | `timelineStartDate` / `timelineEndDate` |
| **Event time type** | `SingleDayEventTime`          | `DateTimeEventTime` / `MultiDayAgendaEvent` |
| **Cross-midnight**  | Not supported                 | Supported                          |
| **Day separators**  | None                          | Between each day                   |
| **`onTap` time**    | Hour + minute only            | Full `DateTime`                    |
| **Typical use**     | Daily schedules, meetings     | Shifts, 24/7 ops, conferences      |

### Choosing the Right View

- **Single-day**: Events stay within one day, no overnight shifts, no multi-day conferences.
- **Multi-day**: Events cross midnight or span multiple days, or you need 24-hour coverage across a date range.

---

## 🎯 Creating Events

See the [Single-Day](#-single-day-calendar-view) and [Multi-Day](#-multi-day-calendar-view) sections above for full details. Quick reference:

#### Single-Day Events (use in single-day view)
```dart
final singleDayEvent = AgendaEvent(
  title: "Team Meeting",
  subtitle: "Conference Room A",
  start: SingleDayEventTime(hour: 10, minute: 0),
  end: SingleDayEventTime(hour: 11, minute: 30),
  backgroundColor: Colors.blue,
);
```

#### Multi-Day Events (use in multi-day view)
```dart
final multiDayEvent = MultiDayAgendaEvent.spanningDays(
  title: "Night Shift Operations",
  subtitle: "24/7 Support",
  startDate: DateTime(2024, 1, 15, 22, 0), // Monday 22:00
  endDate: DateTime(2024, 1, 16, 6, 0),   // Tuesday 06:00
  backgroundColor: Colors.purple,
);
```

> **Note:** In multi-day view, you can mix `AgendaEvent` (with `SingleDayEventTime`) and `MultiDayAgendaEvent` in the same resource. Single-day events are interpreted relative to the timeline's first day.

---

## 🔧 Advanced Configuration

#### Custom Styling
```dart
AgendaStyle(
  // Timeline configuration
  startHour: 0,
  endHour: 24,
  enableMultiDayEvents: true,
  
  // Visual appearance
  backgroundColor: Colors.white,
  timelineColor: Colors.grey[100]!,
  decorationLineDashWidth: 5,
  decorationLineDashSpaceWidth: 5,
  
  // Day separators
  daySeparatorHeight: 50.0,
  daySeparatorColor: Colors.blue[50],
  daySeparatorTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blue[800],
  ),
  
  // Headers
  headersPosition: HeadersPosition.bottom,
  headerLogo: HeaderLogo.circle,
)
```

#### Performance Optimization
```dart
// Use optimized state management for large datasets
ChangeNotifierProvider(
  create: (context) => AgendaStateController(),
  child: FlutterAgenda(
    // ... your configuration
  ),
)
```

---

## 📋 Use Cases by View Type

**Single-Day View:**
- **📅 Daily planners** – Personal schedules, to-do lists
- **🏢 Office scheduling** – Meeting rooms, desks (9 AM–6 PM)
- **📚 Class timetables** – School/university schedules
- **💼 Appointments** – Doctor, salon, service bookings

**Multi-Day View:**
- **🏥 Healthcare** – 24/7 shift scheduling, patient monitoring
- **🏭 Manufacturing** – Continuous operations, maintenance windows
- **🎯 Events** – Conferences, festivals spanning multiple days
- **🚨 Support** – Round-the-clock customer service scheduling
- **🔧 Maintenance** – System updates across time zones
- **📈 Business** – Global operations coordination

## 🔄 Migration from v4.x to v5.0

Version 5.0.0 introduces multi-day support with some breaking changes:

### ⚠️ Breaking Changes
- `EventTime` is now abstract - use `SingleDayEventTime` for single-day events
- New `DateTimeEventTime` class for multi-day events
- Enhanced `AgendaStyle` with new multi-day properties

### 🛠️ Migration Steps
```dart
// Before (v4.x)
EventTime(hour: 10, minute: 0)

// After (v5.0+)
SingleDayEventTime(hour: 10, minute: 0)  // Single-day events
DateTimeEventTime.fromDateTime(DateTime(2024, 1, 15, 10, 0))  // Multi-day events
```

### ✅ Backward Compatibility
All existing single-day functionality works exactly as before - just replace `EventTime` with `SingleDayEventTime`.

## 📚 Documentation

- [Multi-Day Events Guide](MULTI_DAY_EVENTS_GUIDE.md) - Complete guide for multi-day functionality
- [Implementation Status](MULTI_DAY_IMPLEMENTATION_STATUS.md) - Technical implementation details

# Contributing

While direct contributions to the codebase aren't currently accepted due to production usage, we welcome:

- 🐛 **Bug Reports** - Help us identify and fix issues
- 💡 **Feature Requests** - Suggest new functionality
- 📝 **Documentation** - Improvements to guides and examples
- 🤝 **Community Support** - Help other users in discussions

Please feel free to [open an issue](https://github.com/iliyass-zamouri/flutter_agenda/issues) for any feedback or suggestions!

# License

```
MIT License

Copyright (c) 2022 Iliyass ZAMOURI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
