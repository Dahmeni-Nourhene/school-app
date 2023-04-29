import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({
    required this.universityId,
    required this.specialtyId,
    required this.classId,
    required this.groupId,
    required this.semesterId,
    required this.weekId,
  });
  final String universityId;
  final String specialtyId;
  final String classId;
  final String groupId;
  final String semesterId;
  final String weekId;

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  String _day = 'Lundi';
  String _session = '1';
  String _teacher = 'anas';
  String _classroom = 'salle2';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  Future<void> _addSchedule() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('universities')
            .doc(widget.universityId)
            .collection('specialties')
            .doc(widget.specialtyId)
            .collection('classes')
            .doc(widget.classId)
            .collection('groups')
            .doc(widget.groupId)
            .collection('semesters')
            .doc(widget.semesterId)
            .collection('weeks')
            .doc(widget.weekId)
            .collection('schedule')
            .add({
          'day': _day,
          'session': _session,
          'teacher': _teacher,
          'classroom': _classroom,
          'startTime': Timestamp.fromDate(_startTime),
          'endTime': Timestamp.fromDate(_endTime),
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Le planning a été ajouté avec succès.')));
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un planning'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Jour'),
                  value: _day,
                  onChanged: (value) {
                    setState(() {
                      _day = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le jour est obligatoire.';
                    }
                    return null;
                  },
                  items: <String>[
                    'Lundi',
                    'Mardi',
                    'Mercredi',
                    'Jeudi',
                    'Vendredi',
                    'Samedi',
                    'Dimanche'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Session'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La session est obligatoire.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _session = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Professeur'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le nom du professeur est obligatoire.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _teacher = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salle de classe'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La salle de classe est obligatoire.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _classroom = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Heure de début:'),
                    ElevatedButton(
                      onPressed: () {
                        DatePicker.showTimePicker(
                          context,
                          showSecondsColumn: false,
                          onConfirm: (date) {
                            setState(() {
                              _startTime = date;
                            });
                          },
                        );
                      },
                      child: Text(
                          '${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Heure de fin:'),
                    ElevatedButton(
                      onPressed: () {
                        DatePicker.showTimePicker(
                          context,
                          showSecondsColumn: false,
                          onConfirm: (date) {
                            setState(() {
                              _endTime = date;
                            });
                          },
                        );
                      },
                      child: Text(
                          '${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addSchedule,
                  child: Text('Ajouter le planning'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
