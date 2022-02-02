# Flutter Agenda View

Agenda Widget Package for Flutter

# Features

## Image

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/flutter_agenda.png" width="200" />

## Video Recording

<img src="https://github.com/iliyass-zamouri/flutter_agenda/blob/main/images/flutter_agenda.gif" height="440" />  

# Install

https://pub.dev/packages/flutter_agenda#-installing-tab-

# Usage

## Basic

```
import 'package:flutter_agenda/flutter_agenda.dart';

class AgendaScreen extends StatefulWidget {
  AgendaScreen({Key? key}) : super(key: key);

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

late List<Pillar> pillars = <Pillar>[];

class _AgendaScreenState extends State<AgendaScreen> {
  @override
  void initState() {
    super.initState();
    pillars = [
      Pillar(
        head: PillarHead(name: 'Pillar 1'.toUpperCase()),
        events: [
          AgendaEvent(
            title: 'Event D',
            subtitle: 'CC',
            start: EventTime(hour: 8, minute: 0),
            end: EventTime(hour: 10, minute: 0),
          ),
          AgendaEvent(
            title: 'Event Z',
            subtitle: 'SV',
            start: EventTime(hour: 12, minute: 0),
            end: EventTime(hour: 13, minute: 20),
          ),
        ],
      ),
      Pillar(
        head: PillarHead(name: 'Pillar 2'.toUpperCase()),
        events: [
          AgendaEvent(
            title: 'Event G',
            subtitle: 'FE',
            start: EventTime(hour: 9, minute: 10),
            end: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Pillar(
        head: PillarHead(name: 'Pillar 3'.toUpperCase(), textColor: Colors.red),
        events: [
          AgendaEvent(
            title: 'Event A',
            subtitle: 'DE',
            start: EventTime(hour: 10, minute: 10),
            end: EventTime(hour: 11, minute: 45),
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
          pillarList: pillars,
        ),
      ),
    );
  }
}
```

## Customized

```
todo
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
