import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Exam {
  final String id;
  final String date;
  final String startTime;
  final String endTime;
  final String room;
  final String group;
  final String matiere;

  Exam(this.id, this.date, this.startTime, this.endTime, this.room, this.group,
      this.matiere);

  Exam.fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> document)
      : id = document.id,
        date = document.data()['date'] as String? ?? '',
        startTime = document.data()['start_time'] as String? ?? '',
        endTime = document.data()['end_time'] as String? ?? '',
        room = document.data()['room'] as String? ?? '',
        group = document.data()['group'] as String? ?? '',
        matiere = document.data()['matiere'] as String? ?? '';

  String? get subject => null;
}

class AdminExamCalendarPage1 extends StatefulWidget {
  @override
  _AdminExamCalendarPage1State createState() => _AdminExamCalendarPage1State();
}

class _AdminExamCalendarPage1State extends State<AdminExamCalendarPage1> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  late String _selectedDate;
  late String _selectedStartTime;
  late String _selectedEndTime;
  late String _selectedRoom;
  late String _selectedGroup;
  late String _selectedMatiere;
  List<String> _rooms = ['Room 1', 'Room 2', 'Room 3', 'Room 4'];
  List<String> _groups = ['Group A', 'Group B', 'Group C', 'Group D'];
  List<String> _matieres = [
    'Maths',
    'Physique',
    'Chimie',
    'Histoire',
    'Géographie',
    'Anglais'
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateFormat('yyyy-MM-dd').format(now);
    _selectedStartTime = DateFormat('kk:mm').format(now);
    _selectedEndTime = DateFormat('kk:mm').format(now.add(Duration(hours: 2)));
    _selectedRoom = _rooms.first;
    _selectedGroup = _groups.first;
    _selectedMatiere = _matieres.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier des examens'),
        backgroundColor: Colors.cyan[700],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _db.collection('test').orderBy('date').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Exam> test = [];
          snapshot.data!.docs.forEach((doc) {
            test.add(Exam.fromDocument(doc));
          });
          return ListView.builder(
            itemCount: test.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  textColor: Colors.cyan[700],
                  title: Text(test[index].date),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(test[index].room),
                      Text(test[index].group),
                      Text(test[index].matiere),
                      Text('${test[index].startTime} - ${test[index].endTime}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.cyan[700],
                    ),
                    onPressed: () {
                      _db.collection('test').doc(test[index].id).delete();
                    },
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Modifier lexamen'),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Salle',
                                  ),
                                  value: test[index].room,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedRoom = newValue!;
                                    });
                                  },
                                  items: _rooms.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Groupe',
                                  ),
                                  value: test[index].group,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGroup = newValue!;
                                    });
                                  },
                                  items: _groups.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Matière',
                                  ),
                                  value: test[index].matiere,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedMatiere = newValue!;
                                    });
                                  },
                                  items:
                                      _matieres.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Date de l\'examen',
                                  ),
                                  initialValue: test[index].date,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedDate = newValue;
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Heure de début',
                                        ),
                                        initialValue: test[index].startTime,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedStartTime = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Heure de fin',
                                        ),
                                        initialValue: test[index].endTime,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedEndTime = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text('ANNULER'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: Text('ENREGISTRER'),
                              onPressed: () {
                                _db
                                    .collection('test')
                                    .doc(test[index].id)
                                    .update({
                                  'date': _selectedDate,
                                  'start_time': _selectedStartTime,
                                  'end_time': _selectedEndTime,
                                  'room': _selectedRoom,
                                  'group': _selectedGroup,
                                  'matiere': _selectedMatiere,
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ajouter un examen'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Salle',
                        ),
                        value: _selectedRoom,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedRoom = newValue!;
                          });
                        },
                        items: _rooms
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Groupe',
                        ),
                        value: _selectedGroup,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGroup = newValue!;
                          });
                        },
                        items: _groups
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Matière',
                        ),
                        value: _selectedMatiere,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMatiere = newValue!;
                          });
                        },
                        items: _matieres
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date de l\examen',
                        ),
                        initialValue: _selectedDate,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDate = newValue;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Heure de début',
                              ),
                              initialValue: _selectedStartTime,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedStartTime = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Heure de fin',
                              ),
                              initialValue: _selectedEndTime,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedEndTime = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _db.collection('test').add({
                          'date': _selectedDate,
                          'start_time': _selectedStartTime,
                          'end_time': _selectedEndTime,
                          'room': _selectedRoom,
                          'group': _selectedGroup,
                          'matiere': _selectedMatiere,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Ajouter'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan[700],
      ),
    );
  }
}
