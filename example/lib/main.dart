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

  // Helper method to build legend items
  Widget _buildLegendItem(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaScreen extends StatefulWidget {
  AgendaScreen({Key? key}) : super(key: key);

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  late List<Resource> _resources;
  bool _isLoading = true;
  TimeSlot _selectedTimeSlot = TimeSlot.half;

  @override
  void initState() {
    super.initState();

    // Get current date for consistent examples
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    _resources = [
      Resource(
        head: Header(
            title: '24/7 Support Team',
            subtitle: 'Multi-day Operations',
            object: 1,
            color: Colors.blue),
        events: [
          // Single-day events (today)
          AgendaEvent(
            title: 'Morning Standup',
            subtitle: 'Daily Sync',
            backgroundColor: Colors.green,
            start: SingleDayEventTime(hour: 9, minute: 0),
            end: SingleDayEventTime(hour: 9, minute: 30),
            onTap: () => print("Morning Standup - Single day event"),
          ),
          AgendaEvent(
            title: 'Team Lunch',
            subtitle: '1h break',
            backgroundColor: Colors.amber,
            start: SingleDayEventTime(hour: 12, minute: 0),
            end: SingleDayEventTime(hour: 13, minute: 0),
            onTap: () => print("Team Lunch"),
          ),
          AgendaEvent(
            title: 'Incident Review',
            subtitle: 'Post-mortem',
            backgroundColor: Colors.deepOrange,
            start: SingleDayEventTime(hour: 16, minute: 0),
            end: SingleDayEventTime(hour: 17, minute: 30),
            onTap: () => print("Incident Review"),
          ),
          AgendaEvent(
            title: 'Handover Briefing',
            subtitle: 'Shift change',
            backgroundColor: Colors.cyan,
            start: SingleDayEventTime(hour: 20, minute: 0),
            end: SingleDayEventTime(hour: 20, minute: 45),
            onTap: () => print("Handover Briefing"),
          ),

          // Multi-day event: Night shift spanning midnight
          MultiDayAgendaEvent.spanningDays(
            title: 'Night Shift 1',
            subtitle: '22:00 → 06:00 (Cross-day)',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 22, minute: 0),
            endDate:
                today.add(const Duration(days: 2)).copyWith(hour: 6, minute: 0),
            backgroundColor: Colors.indigo,
            onTap: () =>
                print("Night Shift 1 - Multi-day event spanning midnight!"),
          ),

          // Day 2 events
          MultiDayAgendaEvent.spanningDays(
            title: 'Training Session',
            subtitle: 'New tools intro',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 10, minute: 0),
            endDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 12, minute: 0),
            backgroundColor: Colors.lightGreen,
            onTap: () => print("Training Session"),
          ),
          MultiDayAgendaEvent.spanningDays(
            title: 'Escalation Call',
            subtitle: 'Priority ticket',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 14, minute: 30),
            endDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 15, minute: 30),
            backgroundColor: Colors.red,
            onTap: () => print("Escalation Call"),
          ),

          // Multi-day event: Long conference
          MultiDayAgendaEvent.spanningDays(
            title: 'Tech Conference 2024',
            subtitle: '3-Day Event',
            startDate:
                today.add(const Duration(days: 3)).copyWith(hour: 9, minute: 0),
            endDate: today
                .add(const Duration(days: 5))
                .copyWith(hour: 18, minute: 0),
            backgroundColor: Colors.orange,
            onTap: () => print("Tech Conference - 3-day multi-day event!"),
          ),

          // Day 4 morning slot
          MultiDayAgendaEvent.spanningDays(
            title: 'Q&A Session',
            subtitle: 'Conference breakout',
            startDate: today
                .add(const Duration(days: 4))
                .copyWith(hour: 11, minute: 0),
            endDate: today
                .add(const Duration(days: 4))
                .copyWith(hour: 12, minute: 30),
            backgroundColor: Colors.blueGrey,
            onTap: () => print("Q&A Session"),
          ),
        ],
      ),
      Resource(
        head: Header(
            title: 'Maintenance Team',
            subtitle: 'System Operations',
            object: 2,
            color: Colors.red),
        events: [
          // Single-day events (today)
          AgendaEvent(
            title: 'Backup Check',
            subtitle: 'Daily verify',
            backgroundColor: Colors.teal,
            start: SingleDayEventTime(hour: 6, minute: 0),
            end: SingleDayEventTime(hour: 7, minute: 0),
            onTap: () => print("Backup Check"),
          ),
          AgendaEvent(
            title: 'Security Audit',
            subtitle: 'Monthly Review',
            backgroundColor: Colors.amber,
            start: SingleDayEventTime(hour: 14, minute: 0),
            end: SingleDayEventTime(hour: 16, minute: 0),
            onTap: () => print("Security Audit - Single day event"),
          ),
          AgendaEvent(
            title: 'Server Health',
            subtitle: 'Monitoring review',
            backgroundColor: Colors.lime,
            start: SingleDayEventTime(hour: 18, minute: 0),
            end: SingleDayEventTime(hour: 19, minute: 0),
            onTap: () => print("Server Health"),
          ),

          // Day 1
          MultiDayAgendaEvent.spanningDays(
            title: 'Patch Deployment',
            subtitle: 'Security updates',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 2, minute: 0),
            endDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 4, minute: 0),
            backgroundColor: Colors.brown,
            onTap: () => print("Patch Deployment"),
          ),
          MultiDayAgendaEvent.spanningDays(
            title: 'Capacity Planning',
            subtitle: 'Infrastructure review',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 9, minute: 30),
            endDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 11, minute: 0),
            backgroundColor: Colors.orange,
            onTap: () => print("Capacity Planning"),
          ),

          // Multi-day event: Maintenance window
          MultiDayAgendaEvent.spanningDays(
            title: 'System Maintenance',
            subtitle: 'Database Update',
            startDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 23, minute: 0),
            endDate:
                today.add(const Duration(days: 3)).copyWith(hour: 5, minute: 0),
            backgroundColor: Colors.red,
            onTap: () =>
                print("System Maintenance - Overnight multi-day event!"),
          ),

          // Day 2 morning
          MultiDayAgendaEvent.spanningDays(
            title: 'DR Test',
            subtitle: 'Disaster recovery',
            startDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 8, minute: 0),
            endDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 10, minute: 30),
            backgroundColor: Colors.deepPurple,
            onTap: () => print("DR Test"),
          ),

          // Day 5
          MultiDayAgendaEvent.spanningDays(
            title: 'Certificate Renewal',
            subtitle: 'SSL certs',
            startDate: today
                .add(const Duration(days: 5))
                .copyWith(hour: 10, minute: 0),
            endDate: today
                .add(const Duration(days: 5))
                .copyWith(hour: 12, minute: 0),
            backgroundColor: Colors.amber,
            onTap: () => print("Certificate Renewal"),
          ),
        ],
      ),
      Resource(
        head: Header(
            title: 'Development Team',
            subtitle: 'Project Work',
            object: 3,
            color: Colors.green),
        events: [
          // Single-day events (today)
          AgendaEvent(
            title: 'Daily Standup',
            subtitle: 'Scrum sync',
            backgroundColor: Colors.green,
            start: SingleDayEventTime(hour: 9, minute: 30),
            end: SingleDayEventTime(hour: 9, minute: 45),
            onTap: () => print("Daily Standup"),
          ),
          AgendaEvent(
            title: 'Code Review',
            subtitle: 'Daily PRs',
            backgroundColor: Colors.blue,
            start: SingleDayEventTime(hour: 15, minute: 0),
            end: SingleDayEventTime(hour: 16, minute: 0),
            onTap: () => print("Code Review - Single day event"),
          ),
          AgendaEvent(
            title: 'Pair Programming',
            subtitle: 'Feature X',
            backgroundColor: Colors.indigo,
            start: SingleDayEventTime(hour: 10, minute: 0),
            end: SingleDayEventTime(hour: 12, minute: 0),
            onTap: () => print("Pair Programming"),
          ),
          AgendaEvent(
            title: 'Architecture Review',
            subtitle: 'Design docs',
            backgroundColor: Colors.deepOrange,
            start: SingleDayEventTime(hour: 14, minute: 0),
            end: SingleDayEventTime(hour: 15, minute: 0),
            onTap: () => print("Architecture Review"),
          ),

          // Day 2
          MultiDayAgendaEvent.spanningDays(
            title: 'Retrospective',
            subtitle: 'Sprint 42',
            startDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 16, minute: 0),
            endDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 17, minute: 30),
            backgroundColor: Colors.pink,
            onTap: () => print("Retrospective"),
          ),
          MultiDayAgendaEvent.spanningDays(
            title: 'Tech Talk',
            subtitle: 'Microservices',
            startDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 11, minute: 0),
            endDate: today
                .add(const Duration(days: 2))
                .copyWith(hour: 12, minute: 0),
            backgroundColor: Colors.cyan,
            onTap: () => print("Tech Talk"),
          ),

          // Multi-day event: Sprint planning
          MultiDayAgendaEvent.spanningDays(
            title: 'Sprint Planning',
            subtitle: '2-Day Workshop',
            startDate: today
                .add(const Duration(days: 4))
                .copyWith(hour: 10, minute: 0),
            endDate: today
                .add(const Duration(days: 5))
                .copyWith(hour: 16, minute: 0),
            backgroundColor: Colors.teal,
            onTap: () => print("Sprint Planning - 2-day multi-day event!"),
          ),

          // Day 4
          MultiDayAgendaEvent.spanningDays(
            title: 'Demos',
            subtitle: 'Stakeholder demo',
            startDate: today
                .add(const Duration(days: 4))
                .copyWith(hour: 14, minute: 0),
            endDate: today
                .add(const Duration(days: 4))
                .copyWith(hour: 15, minute: 30),
            backgroundColor: Colors.lightGreen,
            onTap: () => print("Demos"),
          ),

          // Day 6
          MultiDayAgendaEvent.spanningDays(
            title: 'Release Prep',
            subtitle: 'Documentation',
            startDate: today
                .add(const Duration(days: 6))
                .copyWith(hour: 9, minute: 0),
            endDate: today
                .add(const Duration(days: 6))
                .copyWith(hour: 11, minute: 0),
            backgroundColor: Colors.amber,
            onTap: () => print("Release Prep"),
          ),

          // Multi-day event: Code freeze
          MultiDayAgendaEvent.spanningDays(
            title: 'Code Freeze',
            subtitle: 'Release Preparation',
            startDate: today
                .add(const Duration(days: 6))
                .copyWith(hour: 18, minute: 0),
            endDate: today
                .add(const Duration(days: 7))
                .copyWith(hour: 12, minute: 0),
            backgroundColor: Colors.purple,
            onTap: () =>
                print("Code Freeze - Release preparation multi-day event!"),
          ),
        ],
      ),
      Resource(
        head: Header(
            title: 'Customer Support',
            subtitle: '24/7 Coverage',
            object: 4,
            color: Colors.purple),
        events: [
          // Single-day events (today)
          AgendaEvent(
            title: 'Ticket Triage',
            subtitle: 'Priority queue',
            backgroundColor: Colors.purple,
            start: SingleDayEventTime(hour: 8, minute: 0),
            end: SingleDayEventTime(hour: 9, minute: 0),
            onTap: () => print("Ticket Triage"),
          ),
          AgendaEvent(
            title: 'Customer Call',
            subtitle: 'Enterprise client',
            backgroundColor: Colors.deepPurple,
            start: SingleDayEventTime(hour: 11, minute: 0),
            end: SingleDayEventTime(hour: 12, minute: 0),
            onTap: () => print("Customer Call"),
          ),
          AgendaEvent(
            title: 'Knowledge Base Update',
            subtitle: 'FAQ refresh',
            backgroundColor: Colors.indigo,
            start: SingleDayEventTime(hour: 13, minute: 30),
            end: SingleDayEventTime(hour: 15, minute: 0),
            onTap: () => print("Knowledge Base Update"),
          ),
          AgendaEvent(
            title: 'Escalation Meeting',
            subtitle: 'Critical issues',
            backgroundColor: Colors.red,
            start: SingleDayEventTime(hour: 16, minute: 30),
            end: SingleDayEventTime(hour: 17, minute: 30),
            onTap: () => print("Escalation Meeting"),
          ),

          // Day 1
          MultiDayAgendaEvent.spanningDays(
            title: 'Onboarding Training',
            subtitle: 'New agents',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 9, minute: 0),
            endDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 12, minute: 0),
            backgroundColor: Colors.blueGrey,
            onTap: () => print("Onboarding Training"),
          ),
          MultiDayAgendaEvent.spanningDays(
            title: 'Peak Hours Coverage',
            subtitle: 'Extra staff',
            startDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 18, minute: 0),
            endDate: today
                .add(const Duration(days: 1))
                .copyWith(hour: 22, minute: 0),
            backgroundColor: Colors.orange,
            onTap: () => print("Peak Hours Coverage"),
          ),

          // Day 3
          MultiDayAgendaEvent.spanningDays(
            title: 'SLA Review',
            subtitle: 'Response times',
            startDate: today
                .add(const Duration(days: 3))
                .copyWith(hour: 10, minute: 0),
            endDate: today
                .add(const Duration(days: 3))
                .copyWith(hour: 11, minute: 30),
            backgroundColor: Colors.teal,
            onTap: () => print("SLA Review"),
          ),

          // Multi-day event: Weekend coverage
          MultiDayAgendaEvent.spanningDays(
            title: 'Weekend Support',
            subtitle: '48-Hour Coverage',
            startDate:
                today.add(const Duration(days: 5)).copyWith(hour: 0, minute: 0),
            endDate:
                today.add(const Duration(days: 7)).copyWith(hour: 0, minute: 0),
            backgroundColor: Colors.deepPurple,
            onTap: () => print("Weekend Support - 48-hour multi-day event!"),
          ),

          // Day 5 morning (before weekend)
          MultiDayAgendaEvent.spanningDays(
            title: 'Handover Prep',
            subtitle: 'Weekend brief',
            startDate: today
                .add(const Duration(days: 5))
                .copyWith(hour: 8, minute: 0),
            endDate: today
                .add(const Duration(days: 5))
                .copyWith(hour: 9, minute: 0),
            backgroundColor: Colors.amber,
            onTap: () => print("Handover Prep"),
          ),

          // Multi-day event: Holiday coverage (visible in 7-day window if today+8)
          MultiDayAgendaEvent.spanningDays(
            title: 'Holiday Coverage',
            subtitle: 'Extended Hours',
            startDate:
                today.add(const Duration(days: 6)).copyWith(hour: 8, minute: 0),
            endDate: today
                .add(const Duration(days: 7))
                .copyWith(hour: 20, minute: 0),
            backgroundColor: Colors.deepOrange,
            onTap: () => print("Holiday Coverage - Extended multi-day event!"),
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
                        _isLoading = !_isLoading;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _resources = [
                          ..._resources,
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
                          ),
                        ];
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_resources.isNotEmpty) {
                          _resources = List.from(_resources)..removeAt(0);
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.event),
                    onPressed: () {
                      setState(() {
                        if (_resources.isNotEmpty) {
                          final resource = _resources.first;
                          _resources = [
                            Resource(
                              head: resource.head,
                              events: [
                                ...resource.events,
                                AgendaEvent(
                                  title: 'Meeting A',
                                  subtitle: 'MA',
                                  start: SingleDayEventTime(hour: 9, minute: 0),
                                  end: SingleDayEventTime(hour: 11, minute: 45),
                                  onTap: () {
                                    print("meeting A Details");
                                  },
                                ),
                              ],
                            ),
                            ..._resources.sublist(1),
                          ];
                        }
                      });
                    },
                  ),
                  TextButton(
                    child: Text("15",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _selectedTimeSlot = TimeSlot.quarter;
                      });
                    },
                  ),
                  TextButton(
                    child: Text("30",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _selectedTimeSlot = TimeSlot.half;
                      });
                    },
                  ),
                  TextButton(
                    child: Text("1h",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _selectedTimeSlot = TimeSlot.full;
                      });
                    },
                  ),
                  TextButton(
                    child: Text("Nav",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => SecondScreen());
                    },
                  ),
                  TextButton(
                    child: Text("Top",
                        style: TextStyle(color: Colors.black87, fontSize: 12)),
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
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    // Main agenda
                    Expanded(
                      child: FlutterAgenda(
                        resources: _resources,
                        agendaStyle: AgendaStyle(
                          direction: TextDirection.ltr,
                          startHour: 0, // Start from midnight for 24/7 support
                          endHour: 24, // End at midnight for full day coverage
                          headerLogo: HeaderLogo.bar,
                          fittedWidth: false,
                          timeItemWidth: 45,
                          timeSlot: _selectedTimeSlot,
                          headersPosition:
                              HeadersPosition.bottom, // Move headers to bottom
                          enableMultiDayEvents:
                              true, // Enable multi-day event support
                          timelineStartDate: DateTime.now(), // Start from today
                          timelineEndDate: DateTime.now()
                              .add(const Duration(days: 7)), // Show 7 days
                          daySeparatorHeight: 50.0, // Height of day separators
                          daySeparatorColor:
                              Colors.grey[100], // Light grey background
                          daySeparatorBorderColor:
                              Colors.grey[400]!, // Darker grey borders
                        ),
                        // the click else where (other than an event because it has it's own onTap parameter)
                        // you get the object linked to the head object of the pillar which could be you project costume object
                        // and the cliked time
                        onTap: (clickedTime, object) {
                          print(
                              "Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
                          print("Head Object related to the resource: $object");
                          final EventTime startTime;
                          final EventTime endTime;
                          if (clickedTime is DateTimeEventTime) {
                            startTime = clickedTime;
                            endTime = DateTimeEventTime.fromDateTime(
                                clickedTime.toDateTime()
                                    .add(const Duration(hours: 1)));
                          } else {
                            startTime = SingleDayEventTime(
                                hour: clickedTime.hour,
                                minute: clickedTime.minute);
                            endTime = SingleDayEventTime(
                                hour: clickedTime.hour + 1, minute: 0);
                          }
                          final idx = _resources
                              .indexWhere(
                                  (resource) => resource.head.object == object);
                          if (idx >= 0) {
                            final resource = _resources[idx];
                            _resources = [
                              ..._resources.sublist(0, idx),
                              Resource(
                                head: resource.head,
                                events: [
                                  ...resource.events,
                                  AgendaEvent(
                                    title: 'Meeting A',
                                    subtitle: 'MA',
                                    start: startTime,
                                    end: endTime,
                                    onTap: () {
                                      print("meeting A Details");
                                    },
                                  ),
                                ],
                              ),
                              ..._resources.sublist(idx + 1),
                            ];
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // Helper method to build legend items
  Widget _buildLegendItem(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
