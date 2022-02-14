# Flutter Agenda View

Agenda Widget Package for Flutter

# Features

## Image

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.png" width="400" />

## Video Recording

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.gif" height="440" />  

# Install

https://pub.dev/packages/flutter_agenda/install

# Usage

You can use the pillars as an employees,
and events as meetings during the day.

## Basic

```dart
import 'package:flutter_agenda/flutter_agenda.dart';

class AgendaScreen extends StatefulWidget {
  AgendaScreen({Key? key}) : super(key: key);

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

late List<Pillar> resources = <Pillar>[];

class _AgendaScreenState extends State<AgendaScreen> {
  @override
  void initState() {
    super.initState();
    resources = [
      Pillar(
        head: PillarHead(name: 'Resource 1'.toUpperCase(), object: 1),
        events: [
          AgendaEvent(
            title: 'Meeting D',
            subtitle: 'MD',
            start: EventTime(hour: 8, minute: 0),
            end: EventTime(hour: 8, minute: 30),
          ),
          AgendaEvent(
            title: 'Meeting Z',
            subtitle: 'MZ',
            start: EventTime(hour: 12, minute: 0),
            end: EventTime(hour: 13, minute: 20),
          ),
        ],
      ),
      Pillar(
        head: PillarHead(name: 'Resource 2'.toUpperCase(), object: 2),
        events: [
          AgendaEvent(
            title: 'Meeting G',
            subtitle: 'MG',
            start: EventTime(hour: 9, minute: 10),
            end: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Pillar(
        head: PillarHead(
            name: 'Resource 3'.toUpperCase(), object: 3, textColor: Colors.red),
        events: [
          AgendaEvent(
            title: 'Meeting A',
            subtitle: 'MA',
            start: EventTime(hour: 10, minute: 10),
            end: EventTime(hour: 11, minute: 45),
            onTap: () {
              print("meeting A Details");
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AgendaView(
          // the default view is timeItemHeight = 80 the timeline will be shown in 30 min view
          // and if you  setState it 160 it will be the 15 min view
          // or you can set it 60 and show an hourly timeline
          agendaStyle: AgendaStyle(timeItemHeight: 80),
          pillarList: resources,
          // the click else where (other than an event because it has it's own onTap parameter)
          // you get the object linked to the pillar which could be you project costume object
          // and the cliked time
          onLongPress: (clickedTime, object) {
            print("Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
            print("Head Object related to the resource: $object");
          },
        ),
      ),
    );
  }
}
```

## Customized
Agenda Customizations
```
  int startHour;

  int endHour;

  Color pillarColor;

  Color cornerColor;

  Color timeItemTextColor;

  Color timelineColor;

  Color timelineItemColor;

  Color mainBackgroundColor;

  Color timelineBorderColor;

  Color decorationLineBorderColor;

  double pillarWidth;

  double pillarHeight;

  double timeItemHeight;

  double timeItemWidth;

  double decorationLineHeight;

  double decorationLineDashWidth;

  double eventBorderWidth;

  bool pillarSeparator;

  double decorationLineDashSpaceWidth;

  bool visibleTimeBorder;

  bool visibleDecorationBorder;
```

PillarHead Customizations
```
  String name;

  double height;

  double width;

  Color backgroundColor;

  TextStyle textStyle;

  Color textColor;
```

Event Customizations
```
  String title;

  String subtitle;

  EventTime start;

  EventTime end;

  EdgeInsets padding;

  EdgeInsets? margin;

  VoidCallback? onTap;

  BoxDecoration? decoration;

  Color backgroundColor;

  TextStyle textStyle;

  TextStyle subtitleStyle;
```

# Contributing

1. Fork it
2. Create your feature branch (git checkout -b new_feature_branch)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin new_feature_branch)
5. Create new Pull Request

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
