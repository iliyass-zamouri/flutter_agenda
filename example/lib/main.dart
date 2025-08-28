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

late List<Resource> resources = <Resource>[];
bool _isloading = true;
TimeSlot _selectedTimeSlot = TimeSlot.half;

class _AgendaScreenState extends State<AgendaScreen> {
  @override
  void initState() {
    super.initState();
    
    // Get current date for consistent examples
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    resources = [
      Resource(
        head: Header(title: '24/7 Support Team', subtitle: 'Multi-day Operations', object: 1, color: Colors.blue),
        events: [
          // Single-day event (traditional way)
          AgendaEvent(
            title: 'Morning Standup',
            subtitle: 'Daily Sync',
            backgroundColor: Colors.green,
            start: SingleDayEventTime(hour: 9, minute: 0),
            end: SingleDayEventTime(hour: 9, minute: 30),
            onTap: () => print("Morning Standup - Single day event"),
          ),
          
          // Multi-day event: Night shift spanning midnight
          MultiDayAgendaEvent.spanningDays(
            title: 'Night Shift 1',
            subtitle: '22:00 → 06:00 (Cross-day)',
            startDate: today.add(const Duration(days: 1)).copyWith(hour: 22, minute: 0),
            endDate: today.add(const Duration(days: 2)).copyWith(hour: 6, minute: 0),
            backgroundColor: Colors.indigo,
            onTap: () => print("Night Shift 1 - Multi-day event spanning midnight!"),
          ),
          
          // Multi-day event: Long conference
          MultiDayAgendaEvent.spanningDays(
            title: 'Tech Conference 2024',
            subtitle: '3-Day Event',
            startDate: today.add(const Duration(days: 3)).copyWith(hour: 9, minute: 0),
            endDate: today.add(const Duration(days: 5)).copyWith(hour: 18, minute: 0),
            backgroundColor: Colors.orange,
            onTap: () => print("Tech Conference - 3-day multi-day event!"),
          ),
        ],
      ),
      
      Resource(
        head: Header(title: 'Maintenance Team', subtitle: 'System Operations', object: 2, color: Colors.red),
        events: [
          // Multi-day event: Maintenance window
          MultiDayAgendaEvent.spanningDays(
            title: 'System Maintenance',
            subtitle: 'Database Update',
            startDate: today.add(const Duration(days: 2)).copyWith(hour: 23, minute: 0),
            endDate: today.add(const Duration(days: 3)).copyWith(hour: 5, minute: 0),
            backgroundColor: Colors.red,
            onTap: () => print("System Maintenance - Overnight multi-day event!"),
          ),
          
          // Single-day event
          AgendaEvent(
            title: 'Security Audit',
            subtitle: 'Monthly Review',
            backgroundColor: Colors.amber,
            start: SingleDayEventTime(hour: 14, minute: 0),
            end: SingleDayEventTime(hour: 16, minute: 0),
            onTap: () => print("Security Audit - Single day event"),
          ),
        ],
      ),
      
      Resource(
        head: Header(title: 'Development Team', subtitle: 'Project Work', object: 3, color: Colors.green),
        events: [
          // Multi-day event: Sprint planning
          MultiDayAgendaEvent.spanningDays(
            title: 'Sprint Planning',
            subtitle: '2-Day Workshop',
            startDate: today.add(const Duration(days: 4)).copyWith(hour: 10, minute: 0),
            endDate: today.add(const Duration(days: 5)).copyWith(hour: 16, minute: 0),
            backgroundColor: Colors.teal,
            onTap: () => print("Sprint Planning - 2-day multi-day event!"),
          ),
          
          // Multi-day event: Code freeze
          MultiDayAgendaEvent.spanningDays(
            title: 'Code Freeze',
            subtitle: 'Release Preparation',
            startDate: today.add(const Duration(days: 6)).copyWith(hour: 18, minute: 0),
            endDate: today.add(const Duration(days: 7)).copyWith(hour: 12, minute: 0),
            backgroundColor: Colors.purple,
            onTap: () => print("Code Freeze - Release preparation multi-day event!"),
          ),
          
          // Single-day event
          AgendaEvent(
            title: 'Code Review',
            subtitle: 'Daily PRs',
            backgroundColor: Colors.blue,
            start: SingleDayEventTime(hour: 15, minute: 0),
            end: SingleDayEventTime(hour: 16, minute: 0),
            onTap: () => print("Code Review - Single day event"),
          ),
        ],
      ),
      
      Resource(
        head: Header(title: 'Customer Support', subtitle: '24/7 Coverage', object: 4, color: Colors.purple),
        events: [
          // Multi-day event: Weekend coverage
          MultiDayAgendaEvent.spanningDays(
            title: 'Weekend Support',
            subtitle: '48-Hour Coverage',
            startDate: today.add(const Duration(days: 5)).copyWith(hour: 0, minute: 0),
            endDate: today.add(const Duration(days: 7)).copyWith(hour: 0, minute: 0),
            backgroundColor: Colors.deepPurple,
            onTap: () => print("Weekend Support - 48-hour multi-day event!"),
          ),
          
          // Multi-day event: Holiday coverage
          MultiDayAgendaEvent.spanningDays(
            title: 'Holiday Coverage',
            subtitle: 'Extended Hours',
            startDate: today.add(const Duration(days: 8)).copyWith(hour: 8, minute: 0),
            endDate: today.add(const Duration(days: 10)).copyWith(hour: 20, minute: 0),
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
              : Column(
                  children: [
                    // Multi-day events showcase header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border(
                          bottom: BorderSide(color: Colors.blue[200]!, width: 1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.event, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Multi-Day Events Showcase',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This example demonstrates both single-day and multi-day events. '
                            'Notice how events can span across days, perfect for 24/7 operations!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildLegendItem('Single Day', Colors.green),
                              _buildLegendItem('Multi-Day', Colors.purple),
                              _buildLegendItem('Cross-Midnight', Colors.indigo),
                              _buildLegendItem('Long Duration', Colors.orange),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                                        // Main agenda
                    Expanded(
                      child: FlutterAgenda(
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
