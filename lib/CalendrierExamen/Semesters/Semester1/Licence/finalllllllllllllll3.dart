import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class licenceIdExamSchedulePageFinal3 extends StatefulWidget {
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final String
      licenceId; // Ajouter un argument pour l'identifiant de la maîtrise

  licenceIdExamSchedulePageFinal3({Key? key, required this.licenceId})
      : super(key: key);
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  _licenceIdExamSchedulePageFinal3State createState() =>
      _licenceIdExamSchedulePageFinal3State();
}

class _licenceIdExamSchedulePageFinal3State
    extends State<licenceIdExamSchedulePageFinal3> {
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
  final Map<String, Map<String, String>> _exams = {};
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  List<DataRow> _buildTableRows() {
    return _times.map((time) {
      final cells = [
        DataCell(Text(time)),
        ..._days.map((day) {
          final exam = _exams[time]?[day];
          return DataCell(
            exam == null
                ? InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.cyan[700],
                    ),
                    onTap: () => _addExam(time, day),
                  )
                : Row(
                    children: [
                      Expanded(child: Text(exam)),
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
                final exam = '$subject\n$group\n$room';
                setState(() {
                  _exams[time] ??= {};
                  _exams[time]![day] = exam;
                });
                _db
                    .collection('licences')
                    .doc(widget.licenceId)
                    .collection('exams')
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

////////////////////////changement////////////////////////////////////////////////////////////
  void _editExam(String time, String day) async {
    final exam = _exams[time]?[day];
    if (exam != null) {
      final result = await showDialog<Map<String, String>>(
        context: context,
        builder: (BuildContext context) {
          _subjectController.text = exam;
          return AlertDialog(
            title: Text('Modifier examen'),
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
                    future:
                        FirebaseFirestore.instance.collection('rooms').get(),
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final subject = _subjectController.text;
                  setState(() {
                    _exams[time]![day] =
                        '$subject\n$_groupsDropdownValue\n$_selectedRoom';
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteExam(String time, String day) {
    setState(() {
      _exams[time]?.remove(day);
    });
  }

//////////////////////////////////////////////////
/*  void _editExam(String time, String day) async {
    final exam = _exams[time]?[day];
    if (exam == null) return;

    final parts = exam.split('\n');
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
                final newExam = '$newSubject\n$group\n$room';
                setState(() {
                  _exams[time]![day] = newExam;
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
                _db
                    .collection('licences')
                    .doc(widget.licenceId)
                    .collection('exams')
                    .where('subject', isEqualTo: subject)
                    .where('time', isEqualTo: time)
                    .where('day', isEqualTo: day)
                    .where('group', isEqualTo: group)
                    .where('room', isEqualTo: room)
                    .get()
                    .then((querySnapshot) {
                  final docId = querySnapshot.docs.first.id;
                  _db
                      .collection('licences')
                      .doc(widget.licenceId)
                      .collection('exams')
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

  void _deleteExam(String time, String day) async {
    final exam = _exams[time]?[day];
    if (exam == null) return;

    final parts = exam.split('\n');
    final subject = parts[0];
    final group = parts[1];
    final room = parts[2];

    try {
      final examSnapshot = await FirebaseFirestore.instance
          .collection('licences')
          .doc(widget.licenceId)
          .collection('exams')
          .where('subject', isEqualTo: subject)
          .where('time', isEqualTo: time)
          .where('day', isEqualTo: day)
          .where('group', isEqualTo: group)
          .where('room', isEqualTo: room)
          .get();

      final docId = examSnapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection('licences')
          .doc(widget.licenceId)
          .collection('exams')
          .doc(docId)
          .delete();

      setState(() {
        _exams[time]!.remove(day);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Examen supprimé'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.cyan[500],
        ),
      );
    } catch (e) {
      print('Erreur lors de la suppression de l\'examen: $e');
    }
  }*/

/////////////////////////changement////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    //_db.collection('exams').get().then((snapshot) {
    _db
        .collection('licences')
        .doc(widget.licenceId)
        .collection('exams')
        .get()
        .then((snapshot) {
      for (final doc in snapshot.docs) {
        final subject = doc['subject'];
        final time = doc['time'];
        final day = doc['day'];
        final group = doc['group'];
        final room = doc['room'];
        final exam = ' $subject\n$group\n$room';
        setState(() {
          _exams[time] ??= {};
          _exams[time]![day] = exam;
        });
      }
    });
  }
}
