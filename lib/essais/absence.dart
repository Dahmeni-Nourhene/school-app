
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AttendancePage extends StatefulWidget {
  final String studentId;
  AttendancePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late DatabaseReference _attendanceRef;
  late List<Map<String, dynamic>> _sessions;

  @override
  void initState() {
    super.initState();
    _attendanceRef = FirebaseDatabase.instance.reference().child('students_attendance').child(widget.studentId);
    _sessions = List.generate(10, (index) {
      int sessionNumber = index + 1;
      DateTime sessionDate = DateTime.now().add(Duration(days: index));
      String formattedDate = "${sessionDate.day}/${sessionDate.month}/${sessionDate.year}";
      return {
        'name': 'Séance $sessionNumber',
        'date': formattedDate,
        'present': false,
      };
    });
    _attendanceRef.onValue.listen((event) {
      Map<dynamic, dynamic>? attendance = event.snapshot.value as Map?;
      if (attendance != null) {
        attendance.forEach((key, value) {
          int dateIndex = int.parse(key.split('_')[1]) - 1;
          Map<dynamic, dynamic> session = value;
          _sessions[dateIndex]['present'] = session['present'];
        });
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Absence'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[300],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _sessions[index]['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _sessions[index]['date'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _attendanceRef.child('date_${index + 1}').set({'present': true});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: _sessions[index]['present'] ? Colors.green[400] : Colors.grey[400],
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Présent',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                                                onPressed: () {
                                _attendanceRef.child('date_${index + 1}').set({'present': false});
                              },
                              style: ElevatedButton.styleFrom(
                                primary: _sessions[index]['present'] == false ? Colors.red[400] : Colors.grey[400],
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Absent',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
);
}
}


