import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/screen/read_examen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import '../Model/calendriers_model.dart';
import '../controller/calendriers_controller.dart';
import '../essais/essai_finaaaal.dart';
import 'awelpageBleshAdd.dart';

class LoadDataFromFireBase extends StatelessWidget {
  final Calendriers calendarId;

  LoadDataFromFireBase({required this.calendarId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireBase',
      home: LoadDataFromFireStore(calendarId: calendarId),
    );
  }
}

class LoadDataFromFireStore extends StatefulWidget {
  final Calendriers calendarId;

  LoadDataFromFireStore({required this.calendarId});

  @override
  LoadDataFromFireStoreState createState() => LoadDataFromFireStoreState();
}

class LoadDataFromFireStoreState extends State<LoadDataFromFireStore> {
  List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  CalendriersController calendriesController = CalendriersController();
  // final List<String> options = <String>['Add', 'Delete', 'Update'];
  final databaseReference = FirebaseFirestore.instance;
  bool isLoaded = true;
  @override
  void initState() {
    _initializeEventColor();

    super.initState();
    String test = widget.calendarId.id;
    getDataFromFireStore("$test").then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
  }

  Future<void> getDataFromFireStore(String id) async {
    var snapShotsValue = await databaseReference
        .collection("exam_schedule")
        .where('group', isEqualTo: id.trim().toString())
        // .doc(widget.calendarId)
        //.collection("events")
        .get();

    final Random random = new Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['subject'],
            from:
                DateFormat('yyyy/MM/dd HH:mm:ss').parse(e.data()['startTime']),
            to: DateFormat('yyyy/MM/dd HH:mm:ss').parse(e.data()['endTime']),
            background: _colorCollection[random.nextInt(9)],
            isAllDay: false))
        .toList();

    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CalendPage()),
              );
            },
          ),
          title: Text(widget.calendarId.nom),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ReadExamen(idGroup: widget.calendarId,)),
                );
              },
            ),
          ],
        ),
        body: SfCalendar(
          view: CalendarView.week,
          firstDayOfWeek: 1,
          dataSource: events,
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 7,
            endHour: 18,
            nonWorkingDays: <int>[DateTime.sunday],
            timeIntervalHeight: 50,
            timeFormat: 'HH:mm',
            dateFormat: 'd',
            dayFormat: 'EEE',
          ),
        ));
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;

  Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay});
}
