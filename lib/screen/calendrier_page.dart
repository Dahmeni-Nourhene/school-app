/*import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '/model/event.dart';

class CalendrierPage extends StatefulWidget {
  final List<Event> events;

  CalendrierPage({required this.events});

  @override
  _CalendrierPageState createState() => _CalendrierPageState();
}

class _CalendrierPageState extends State<CalendrierPage> {
  late CalendarController _calendarController;
 Map<DateTime, List<Event>> _events = {};

// Ajouter un événement à la liste des événements pour une date donnée
void _addEvent(DateTime date, Event event) {
  if (_events[date] != null) {
    _events[date]!.add(event);
  } else {
    _events[date] = [event];
  }
}

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = _groupEvents(widget.events);
  }

  Map<DateTime, List<Event>> _groupEvents(List<Event> events) {
    Map<DateTime, List<Event>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.date.year, event.date.month, event.date.day);
      if (data[date] == null) data[date] = [];
      data[date]!.add(event);
    });
    return data;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              calendarController: _calendarController,
              events: _events,
              onDaySelected: (day, events, holidays) {
                setState(() {});
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                holidayDecoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              availableCalendarFormats: {CalendarFormat.month: 'Mois'},
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                DateFormat('EEEE, d MMMM y').format(_calendarController.selectedDay),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            ..._getEventsForDay(_calendarController.selectedDay).map((event) => ListTile(
              title: Text(event.title),
              subtitle: Text(event.description),
              trailing: Text(event.time),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
*/