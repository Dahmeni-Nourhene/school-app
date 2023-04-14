import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamSchedulePageFinal2S2 extends StatefulWidget {
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final String
      masterS2Id; // Ajouter un argument pour l'identifiant de la maîtrise

  ExamSchedulePageFinal2S2({Key? key, required this.masterS2Id})
      : super(key: key);
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  _ExamSchedulePageFinal2S2State createState() =>
      _ExamSchedulePageFinal2S2State();
}

class _ExamSchedulePageFinal2S2State extends State<ExamSchedulePageFinal2S2> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final List<String> _times = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM'
  ];
  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  final List<String> _groups = [
    'Group A',
    'Group B',
    'Group C',
    'Group D',
    'Group E',
    'Group F',
  ];

  String _selectedRoom = 'salle 1';
  String _groupsDropdownValue = 'Group A';

  TextEditingController _subjectController = TextEditingController();
  final Map<String, Map<String, String>> _examsS2 = {};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calendrier de examens'),
        backgroundColor: Colors.cyan[700],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(
              color: Colors.black, style: BorderStyle.solid, width: 0.5),
          columns: _buildTableColumns(),
          rows: _buildTableRows(),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      DataColumn(label: Text('Time')),
      ..._days.map((day) => DataColumn(label: Text(day))),
    ];
  }

////////////////////////////////////////////
  List<DataRow> _buildTableRows() {
    return _times.map((time) {
      final cells = [
        DataCell(Text(time)),
        ..._days.map((day) {
          final examS2 = _examsS2[time]?[day];
          return DataCell(
            examS2 == null
                ? InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.cyan[700],
                    ),
                    onTap: () => _addExam(time, day),
                  )
                : Row(
                    children: [
                      Expanded(child: Text(examS2)),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.cyan[700],
                        ),
                        onPressed: () => _editExam(time, day),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.cyan[700],
                        ),
                        onPressed: () => _deleteExam(time, day),
                      ),
                    ],
                  ),
          );
        }),
      ];
      return DataRow(cells: cells);
    }).toList();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> _addExam(String time, String day) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter examen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(hintText: 'Enter Subject'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _groupsDropdownValue,
                items: _groups
                    .map((group) =>
                        DropdownMenuItem(value: group, child: Text(group)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _groupsDropdownValue = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Group',
                ),
              ),

              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('rooms').get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Une erreur est survenue');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    /////////////////////////////
                    List<DropdownMenuItem<String>> rooms = [];
                    snapshot.data!.docs.forEach((doc) {
                      rooms.add(DropdownMenuItem<String>(
                        value: doc['name'],
                        child: Text(doc['name']),
                      ));
                    });
                    return DropdownButtonFormField<String>(
                      value: _selectedRoom,
                      items: rooms,
                      onChanged: (value) {
                        setState(() {
                          _selectedRoom = value!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Salle'),
                    );
                  }),
////////////////////////////////////////////////////////////////////////////////////////////////////////
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            /*
            ElevatedButton(
              onPressed: () {
                final subject = _subjectController.text;
                final group = _groupsDropdownValue;
                Navigator.of(context).pop({'subject': subject, 'group': group});
              },
              child: Text('Save'),
            ),*/
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                final subject = _subjectController.text;
                final group = _groupsDropdownValue;
                final room = _selectedRoom;
                final examS2 = '$subject\n$group\n$room';
                setState(() {
                  _examsS2[time] ??= {};
                  _examsS2[time]![day] = examS2;
                });
                _db
                  ..collection('mastersS2')
                      .doc(widget.masterS2Id)
                      .collection('examsS2')
                      .add({
                    'subject': subject,
                    'time': time,
                    'day': day,
                    'group': group,
                    'room': room,
                  });

                Navigator.of(context).pop({
                  'subject': subject,
                  'group': group,
                  'room': room,
                });
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      final subject = result['subject'];
      final group = result['group'];
      final room = result['room'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Examen ajouté: $subject - $group - $room',
          ),
          backgroundColor: Colors.cyan[500]));
    }
  }

//////////////////////////////////////////////////
  void _editExam(String time, String day) async {
    final examS2 = _examsS2[time]?[day];
    if (examS2 == null) return;

    final parts = examS2.split('\n');
    final subject = parts[0];
    var group = parts[1];
    var room = parts[2];

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        _subjectController.text = subject;

        return AlertDialog(
          title: Text('Edit Exam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(hintText: 'Enter Subject'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: group,
                items: _groups
                    .map((group) =>
                        DropdownMenuItem(value: group, child: Text(group)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    group = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Group',
                ),
              ),

              ///////////////////////////////
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('rooms').get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Une erreur est survenue');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    /////////////////////////////
                    List<DropdownMenuItem<String>> rooms = [];
                    snapshot.data!.docs.forEach((doc) {
                      rooms.add(DropdownMenuItem<String>(
                        value: doc['name'],
                        child: Text(doc['name']),
                      ));
                    });
                    return DropdownButtonFormField<String>(
                      value: _selectedRoom,
                      items: rooms,
                      onChanged: (value) {
                        setState(() {
                          _selectedRoom = value!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Salle'),
                    );
                  }),
              ///////////////////////////////////////
              /* DropdownButtonFormField<String>(
                value: room,
                items: _rooms
                    .map((room) =>
                        DropdownMenuItem(value: room, child: Text(room)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    room = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Room',
                ),
              ),*/
              ////////////////////////////////////////////////////////////
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                final newSubject = _subjectController.text;
                final newExamS2 = '$newSubject\n$group\n$room';
                setState(() {
                  _examsS2[time]![day] = newExamS2;
                });
                Navigator.of(context).pop();
                ////// Add SnackBar to show message when exam is edited
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Examen modifié: $subject - $group - $room',
                    ),
                    duration: Duration(seconds: 5),
                    backgroundColor: Colors.cyan[500]));

                ///////////////
                _db.collection('mastersS2').doc(widget.masterS2Id)
                  ..collection('examsS2')
                      .where('subject', isEqualTo: subject)
                      .where('time', isEqualTo: time)
                      .where('day', isEqualTo: day)
                      .where('group', isEqualTo: group)
                      .where('room', isEqualTo: room)
                      .get()
                      .then((querySnapshot) {
                    final docId = querySnapshot.docs.first.id;
                    _db
                      ..collection('mastersS2')
                          .doc(widget.masterS2Id)
                          .collection('examsS2')
                          .doc(docId)
                          .update({
                        'subject': newSubject,
                      });
                  });
              },
            ),
          ],
        );
      },
    );
//////////

    ////////////////
  }

  void _deleteExam(String time, String day) {
    final examS2 = _examsS2[time]?[day];
    if (examS2 == null) return;

    final parts = examS2.split('\n');
    final subject = parts[0];
    final group = parts[1];
    final room = parts[2];

    setState(() {
      _examsS2[time]!.remove(day);
    });
    ////////////////////
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Examen supprimé',
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.cyan[500]));
    ////////////////////////
    _db
        .collection('mastersS2')
        .doc(widget.masterS2Id)
        .collection('examsS2')
        .where('subject', isEqualTo: subject)
        .where('time', isEqualTo: time)
        .where('day', isEqualTo: day)
        .where('group', isEqualTo: group)
        .where('room', isEqualTo: room)
        .get()
        .then((querySnapshot) {
      final docId = querySnapshot.docs.first.id;
      _db
          .collection('mastersS2')
          .doc(widget.masterS2Id)
          .collection('examsS2')
          .doc(docId)
          .delete();
    });
  }

/////////////////////////changement////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    //_db.collection('exams').get().then((snapshot) {
    _db
        .collection('mastersS2')
        .doc(widget.masterS2Id)
        .collection('examsS2')
        .get()
        .then((snapshot) {
      for (final doc in snapshot.docs) {
        final subject = doc['subject'];
        final time = doc['time'];
        final day = doc['day'];
        final group = doc['group'];
        final room = doc['room'];
        final examS2 = ' $subject\n$group\n$room';
        setState(() {
          _examsS2[time] ??= {};
          _examsS2[time]![day] = examS2;
        });
      }
    });
  }
}
