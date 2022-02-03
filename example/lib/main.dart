import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AgendaScreen(),
    );
  }
}

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
            end: EventTime(hour: 8, minute: 30),
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
          agendaStyle: AgendaStyle(timeItemHeight: 80),
          pillarList: pillars,
        ),
      ),
    );
  }
}
