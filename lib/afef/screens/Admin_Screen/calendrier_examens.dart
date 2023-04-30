import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  late Map<String, Map<String, String>> _exams = {};

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async {
    final data = await FirebaseFirestore.instance
        .collection('exams')
        .doc('schedule')
        .get();
    setState(() {
      _exams = Map<String, Map<String, String>>.from(data['exams']);
    });
  }

  void _updateData() async {
    await FirebaseFirestore.instance
        .collection('exams')
        .doc('schedule')
        .update({
      'exams': _exams,
    });
  }

  void _addExam(String subject) {
    showDialog(
      context: context,
      builder: (context) {
        String day = 'Monday';
        String time = '9:00 - 11:00';
        String room = '';
        return AlertDialog(
          title: const Text('Add Exam Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: day,
                items: [
                  DropdownMenuItem(child: Text('Monday'), value: 'Monday'),
                  DropdownMenuItem(child: Text('Tuesday'), value: 'Tuesday'),
                  DropdownMenuItem(
                      child: Text('Wednesday'), value: 'Wednesday'),
                  DropdownMenuItem(child: Text('Thursday'), value: 'Thursday'),
                  DropdownMenuItem(child: Text('Friday'), value: 'Friday'),
                  DropdownMenuItem(child: Text('Saturday'), value: 'Saturday'),
                  DropdownMenuItem(child: Text('Sunday'), value: 'Sunday'),
                ],
                onChanged: (value) {
                  setState(() {
                    day = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: time,
                items: [
                  DropdownMenuItem(
                      child: Text('9:00 - 11:00'), value: '9:00 - 11:00'),
                  DropdownMenuItem(
                      child: Text('11:00 - 13:00'), value: '11:00 - 13:00'),
                  DropdownMenuItem(
                      child: Text('14:00 - 16:00'), value: '14:00 - 16:00'),
                  DropdownMenuItem(
                      child: Text('16:00 - 18:00'), value: '16:00 - 18:00'),
                ],
                onChanged: (value) {
                  setState(() {
                    time = value!;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Room'),
                onChanged: (value) {
                  setState(() {
                    room = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _exams[subject] = {
                    'day': day,
                    'time': time,
                    'room': room,
                  };
                });
                _updateData();
              },
            ),
          ],
        );
      },
    );
  }

  void _editExam(String subject) {
    showDialog(
      context: context,
      builder: (context) {
        String day = _exams[subject]!['day']!;
        String time = _exams[subject]!['time']!;
        String room = _exams[subject]!['room']!;
        return AlertDialog(
          title: Text('Edit Exam Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: day,
                items: [
                  DropdownMenuItem(child: Text('Monday'), value: 'Monday'),
                  DropdownMenuItem(child: Text('Tuesday'), value: 'Tuesday'),
                  DropdownMenuItem(
                      child: Text('Wednesday'), value: 'Wednesday'),
                  DropdownMenuItem(child: Text('Thursday'), value: 'Thursday'),
                  DropdownMenuItem(child: Text('Friday'), value: 'Friday'),
                  DropdownMenuItem(child: Text('Saturday'), value: 'Saturday'),
                  DropdownMenuItem(child: Text('Sunday'), value: 'Sunday'),
                ],
                onChanged: (value) {
                  setState(() {
                    day = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: time,
                items: [
                  DropdownMenuItem(
                      child: Text('9:00 - 11:00'), value: '9:00 - 11:00'),
                  DropdownMenuItem(
                      child: Text('11:00 - 13:00'), value: '11:00 - 13:00'),
                  DropdownMenuItem(
                      child: Text('14:00 - 16:00'), value: '14:00 - 16:00'),
                  DropdownMenuItem(
                      child: Text('16:00 - 18:00'), value: '16:00 - 18:00'),
                ],
                onChanged: (value) {
                  setState(() {
                    time = value!;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Room'),
                onChanged: (value) {
                  setState(() {
                    room = value;
                  });
                },
                controller: TextEditingController(text: room),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('SAVE'),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _exams[subject] = {
                    'day': day,
                    'time': time,
                    'room': room,
                  };
                });
                _updateData();
              },
            ),
            TextButton(
              child: Text('DELETE'),
              style: TextButton.styleFrom(
                primary: Colors.redAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _exams.remove(subject);
                });
                _updateData();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildExamList() {
    if (_exams.isEmpty) {
      return Center(
        child: Text('No exams'),
      );
    } else {
      return ListView.builder(
        itemCount: _exams.length,
        itemBuilder: (context, index) {
          String subject = _exams.keys.elementAt(index);
          String day = _exams[subject]!['day']!;
          String time = _exams[subject]!['time']!;
          String room = _exams[subject]!['room']!;
          return ListTile(
            title: Text(subject),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Day: $day'),
                Text('Time: $time'),
                Text('Room: $room'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editExam(subject),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: _buildExamList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addExam('Math'),
      ),
    );
  }
}
