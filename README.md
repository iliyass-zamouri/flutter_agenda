# Flutter Agenda

![Pub Version](https://img.shields.io/pub/v/flutter_agenda?label=Flutter%20Agenda&logo=flutter)

Agenda Widget Package for Flutter. diagonal scrolling, beautiful UI, responsive to different screen viewports, OnPressed events, custom styling.

# Features

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.png" width="400" />
<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.gif" height="440" />  

# Usage

- Visualize resources and thier meetings.
- Visualize resources and thier todos.

Use you imagination 😅.

# Install

```
flutter_agenda: ^2.0.0
```


```
import 'package:flutter_agenda/flutter_agenda.dart';
```

## How to use it

```dart
AgendaView(
  agendaStyle: AgendaStyle(
    startHour: 9,
    endHour: 20,
    pillarSeperator: false,
    visibleTimeBorder: true,
    timeItemWidth: 40,
    /// put the cursor in [timeItemHeight] to understand how to utilize it.
    timeItemHeight: 160,
  ),
  pillarList: resources,
  onLongPress: (clickedTime, object) {
    /// put the cursor in the [onLongPress] to see docs.
    print("Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
    print("Head Object related to the resource: $object");
  },
)

```

# Contributing

Unfotuanatly you can't contribute to the develepment of this flutter plugin, 
due to it's being used in a production level project. but feel free to report an issue,
or request an update or a functionality.

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
