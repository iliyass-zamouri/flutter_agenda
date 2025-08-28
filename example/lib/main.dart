import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda_demo/navto.dart';

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

late List<Resource> resources = <Resource>[];
bool _isloading = true;
TimeSlot _selectedTimeSlot = TimeSlot.half;

class _AgendaScreenState extends State<AgendaScreen> {
  @override
  void initState() {
    super.initState();
    resources = [
      Resource(
        head: Header(title: 'Resource 1', subtitle: '3 Appointments', object: 1),
        events: [
          AgendaEvent(
            title: 'Meeting D',
            subtitle: 'B',
            backgroundColor: Colors.red,
            start: SingleDayEventTime(hour: 15, minute: 0),
            end: SingleDayEventTime(hour: 16, minute: 30),
          ),
          AgendaEvent(
            title: 'Meeting Z',
            subtitle: 'MZ',
            start: SingleDayEventTime(hour: 12, minute: 0),
            end: SingleDayEventTime(hour: 13, minute: 20),
          ),
        ],
      ),
      Resource(
        head: Header(title: 'Resource 2', object: 2),
        events: [
          AgendaEvent(
            title: 'Meeting G',
            subtitle: 'MG',
            backgroundColor: Colors.yellowAccent,
            start: SingleDayEventTime(hour: 9, minute: 10),
            end: SingleDayEventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Resource(
        head: Header(title: 'Resource 3', object: 3, color: Colors.yellow),
        events: [
          AgendaEvent(
            title: 'Meeting A',
            subtitle: 'MA',
            start: SingleDayEventTime(hour: 10, minute: 10),
            end: SingleDayEventTime(hour: 11, minute: 45),
            onTap: () {
              print("meeting A Details");
            },
          ),
          // Multi-day event example: Monday 22:00 to Tuesday 03:00
          MultiDayAgendaEvent.spanningDays(
            title: 'Night Shift',
            subtitle: '24/7 Support',
            startDate: DateTime.now().add(const Duration(days: 1)).copyWith(
              hour: 22,
              minute: 0,
            ),
            endDate: DateTime.now().add(const Duration(days: 2)).copyWith(
              hour: 3,
              minute: 0,
            ),
            backgroundColor: Colors.purple,
            onTap: () {
              print("Night Shift Details - Multi-day event!");
            },
          ),
          // Another multi-day event: Wednesday 18:00 to Friday 12:00
          MultiDayAgendaEvent.spanningDays(
            title: 'Conference',
            subtitle: 'Tech Summit',
            startDate: DateTime.now().add(const Duration(days: 3)).copyWith(
              hour: 18,
              minute: 0,
            ),
            endDate: DateTime.now().add(const Duration(days: 5)).copyWith(
              hour: 12,
              minute: 0,
            ),
            backgroundColor: Colors.orange,
            onTap: () {
              print("Conference Details - Multi-day event!");
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
                    persistentFooterButtons: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        _isloading = !_isloading;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        resources.addAll([
                          Resource(
                            head: Header(title: 'Resource 4', object: 4),
                            events: [
                              AgendaEvent(
                                title: 'Meeting A',
                                subtitle: 'MA',
                                start: SingleDayEventTime(hour: 10, minute: 10),
                                end: SingleDayEventTime(hour: 11, minute: 45),
                                onTap: () {
                                  print("meeting A Details");
                                },
                              ),
                            ],
                          ),
                          Resource(
                            head: Header(title: 'Resource 4', object: 4),
                            events: [
                              AgendaEvent(
                                title: 'Meeting A',
                                subtitle: 'MA',
                                start: SingleDayEventTime(hour: 10, minute: 10),
                                end: SingleDayEventTime(hour: 11, minute: 45),
                                onTap: () {
                                  print("meeting A Details");
                                },
                              ),
                            ],
                          )
                        ]);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        resources.removeAt(0);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.event),
                    onPressed: () {
                      setState(() {
                        resources.first.events.add(AgendaEvent(
                          title: 'Meeting A',
                          subtitle: 'MA',
                          start: SingleDayEventTime(hour: 9, minute: 0),
                          end: SingleDayEventTime(hour: 11, minute: 45),
                          onTap: () {
                            print("meeting A Details");
                          },
                        ));
                      });
                    },
                  ),
                  TextButton(
                    child: Text("15", style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _selectedTimeSlot = TimeSlot.quarter;
                      });
                    },
                  ),
                  TextButton(
                    child: Text("30", style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _selectedTimeSlot = TimeSlot.half;
                      });
                    },
                  ),
                  TextButton(
                    child: Text("1h", style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _selectedTimeSlot = TimeSlot.full;
                      });
                    },
                  ),
                  TextButton(
                    child: Text("Nav", style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context, builder: (context) => SecondScreen());
                    },
                  ),
                  TextButton(
                    child: Text("Top", style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        // This would toggle between top and bottom headers
                        // For demo purposes, we'll just show the current setting
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
          body: _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FlutterAgenda(
                  resources: resources,
                  agendaStyle: AgendaStyle(
                    direction: TextDirection.ltr,
                    startHour: 0, // Start from midnight for 24/7 support
                    endHour: 24, // End at midnight for full day coverage
                    headerLogo: HeaderLogo.bar,
                    fittedWidth: false,
                    timeItemWidth: 45,
                    timeSlot: _selectedTimeSlot,
                    headersPosition: HeadersPosition.bottom, // Move headers to bottom
                    enableMultiDayEvents: true, // Enable multi-day event support
                    timelineStartDate: DateTime.now(), // Start from today
                    timelineEndDate: DateTime.now().add(const Duration(days: 7)), // Show 7 days
                    daySeparatorHeight: 50.0, // Height of day separators
                    daySeparatorColor: Colors.grey[100], // Light grey background
                    daySeparatorBorderColor: Colors.grey[400]!, // Darker grey borders
                  ),
                  // the click else where (other than an event because it has it's own onTap parameter)
                  // you get the object linked to the head object of the pillar which could be you project costume object
                  // and the cliked time
                  onTap: (clickedTime, object) {
                    print(
                        "Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
                    print("Head Object related to the resource: $object");
                    resources
                        .where((resource) => resource.head.object == object)
                        .first
                        .events
                        .add(AgendaEvent(
                          title: 'Meeting A',
                          subtitle: 'MA',
                          start: clickedTime,
                          end: SingleDayEventTime(
                              hour: clickedTime.hour + 1,
                              minute: clickedTime.minute),
                          onTap: () {
                            print("meeting A Details");
                          },
                        ));

                    setState(() {});
                  },
                ),
        ),
      ),
    );
  }
}
