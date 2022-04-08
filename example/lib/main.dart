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

late List<Pillar> resources = <Pillar>[];

class _AgendaScreenState extends State<AgendaScreen> {
  @override
  void initState() {
    super.initState();
    resources = [
      Pillar(
        head:
            Header(title: 'Resource 1', subtitle: '3 Appointments', object: 1),
        events: [
          AgendaEvent(
            title: 'Meeting D',
            subtitle: 'MD',
            backgroundColor: Colors.red,
            start: EventTime(hour: 15, minute: 0),
            end: EventTime(hour: 16, minute: 30),
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
        head: Header(title: 'Resource 2', object: 2),
        events: [
          AgendaEvent(
            title: 'Meeting G',
            subtitle: 'MG',
            backgroundColor: Colors.yellowAccent,
            start: EventTime(hour: 9, minute: 10),
            end: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Pillar(
        head: Header(title: 'Resource 3', object: 3, color: Colors.yellow),
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
        body: FlutterAgenda(
          resources: resources,
          agendaStyle: AgendaStyle(
            startHour: 9,
            endHour: 20,
            headerLogo: HeaderLogo.bar,
            timeItemWidth: 45,
            timeSlot: TimeSlot.quarter,
          ),
          // the click else where (other than an event because it has it's own onTap parameter)
          // you get the object linked to the head object of the pillar which could be you project costume object
          // and the cliked time
          onTap: (clickedTime, object) {
            print("Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
            print("Head Object related to the resource: $object");
          },
        ),
      ),
    );
  }
}
