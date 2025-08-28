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
<!-- <img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.gif" height="440" />   -->

# Install

```yaml
dependencies:
  flutter_agenda: ^5.0.0
```

```dart
import 'package:flutter_agenda/flutter_agenda.dart';
```

## How to use it

### 📅 Single-Day Agenda (Basic Usage)

```dart
FlutterAgenda(
  resources: resources,
  agendaStyle: AgendaStyle(
    startHour: 9,
    endHour: 20,
    direction: TextDirection.ltr,
    headerLogo: HeaderLogo.bar,
    timeItemWidth: 45,
    timeSlot: TimeSlot.quarter,
    headersPosition: HeadersPosition.top, // or HeadersPosition.bottom
  ),
  onTap: (clickedTime, object) {
    print("Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
    // don't forget to cast the object back to its original type
    print("Head Object related to the resource: $object");
  },
)
```

### 🌐 Multi-Day Timeline (24/7 Operations)

```dart
FlutterAgenda(
  resources: multiDayResources,
  agendaStyle: AgendaStyle(
    startHour: 0,
    endHour: 24,
    enableMultiDayEvents: true, // Enable multi-day support
    timelineStartDate: DateTime.now(),
    timelineEndDate: DateTime.now().add(Duration(days: 7)),
    direction: TextDirection.ltr,
    headerLogo: HeaderLogo.bar,
    timeItemWidth: 45,
    timeSlot: TimeSlot.quarter,
    // Day separator styling
    daySeparatorHeight: 40.0,
    daySeparatorColor: Colors.grey[200],
    daySeparatorBorderColor: Colors.grey[400],
  ),
  onTap: (clickedTime, object) {
    if (clickedTime is DateTimeEventTime) {
      print("Multi-day clicked: ${clickedTime.toDateTime()}");
    } else {
      print("Single-day clicked: ${clickedTime.hour}:${clickedTime.minute}");
    }
    print("Resource: $object");
  },
)
```

### 🎯 Creating Events

#### Single-Day Events
```dart
final singleDayEvent = AgendaEvent(
  title: "Team Meeting",
  subtitle: "Conference Room A",
  start: SingleDayEventTime(hour: 10, minute: 0),
  end: SingleDayEventTime(hour: 11, minute: 30),
  backgroundColor: Colors.blue,
);
```

#### Multi-Day Events
```dart
final multiDayEvent = MultiDayAgendaEvent.spanningDays(
  title: "Night Shift Operations",
  subtitle: "24/7 Support",
  startDate: DateTime(2024, 1, 15, 22, 0), // Monday 22:00
  endDate: DateTime(2024, 1, 16, 6, 0),   // Tuesday 06:00
  backgroundColor: Colors.purple,
);
```

### 🔧 Advanced Configuration

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

### 📋 Use Cases

- **🏥 Healthcare**: 24/7 shift scheduling, patient monitoring
- **🏭 Manufacturing**: Continuous operations, maintenance windows
- **🎯 Events**: Conferences, festivals spanning multiple days
- **🚨 Support**: Round-the-clock customer service scheduling
- **🔧 Maintenance**: System updates across time zones
- **📈 Business**: Global operations coordination

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
