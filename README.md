# Flutter Agenda

![Pub Version](https://img.shields.io/pub/v/flutter_agenda?label=Flutter%20Agenda&logo=flutter)

Agenda Widget Package for Flutter. diagonal scrolling, beautiful UI, responsive to different screen viewports, OnPressed events, custom styling.

# Show case

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.png" />
<!-- <img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.gif" height="440" />   -->

# Install

```
flutter_agenda: ^3.1.0
```


```
import 'package:flutter_agenda/flutter_agenda.dart';
```

## How to use it

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
  ),
  onTap: (clickedTime, object) {
    print("Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
    // dont forget to cast the object back to it's original type
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
