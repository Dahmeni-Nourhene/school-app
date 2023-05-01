import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/screen/read_examen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

import '../Model/calendriers_model.dart';
import '../Model/exam_schedule_model.dart';
import '../controller/Examen_controller.dart';

class Examen extends StatefulWidget {
  final Calendriers idGroup;
  const Examen({super.key,required this.idGroup});

  @override
  State<Examen> createState() => _ExamenState();
}

class _ExamenState extends State<Examen> {
  final _formKey = GlobalKey<FormState>();
  final subjectcontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final startTimecontroller = TextEditingController();
  final endTimecontroller = TextEditingController();
  final roomcontroller = TextEditingController();
  final groupcontroller = TextEditingController();
  var _selectedRoom;
  var _selectedGroup;

  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  ExamenController examenController = ExamenController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: BackButton(onPressed: (){
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ReadExamen( idGroup: widget.idGroup ,)),
              );
      },)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "choose  a subject",
                ),
                controller: subjectcontroller,
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
              TextField(
                  controller: datecontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy/MM/dd').format(pickedDate);
                      setState(() {
                        datecontroller.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  }),
              ElevatedButton(
                child: const Text("say when"),
                onPressed: () => TimeRangePicker.show(
                  context: context,
                  unSelectedEmpty: true,
                  startTime: TimeOfDay(
                      hour: _startTime.hour, minute: _startTime.minute),
                  endTime:
                      TimeOfDay(hour: _endTime.hour, minute: _endTime.minute),
                  onSubmitted: (TimeRangeValue value) {
                    setState(() {
                      _startTime = value.startTime!;
                      _endTime = value.endTime!;
                      log(_startTime.minute.toString().padLeft(2, '0'));
                    });
                  },
                ),
              ),
              _startTime == _endTime
                  ? const Text("")
                  : Text(
                      "Time : ${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')} to ${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}"),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.validate();
                  final examen = ExamSchedule(
                      id: "",
                      date: datecontroller.text,
                      endTime:
                          "${datecontroller.text} ${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}:00",
                      group: widget.idGroup.id.trim(),
                      room: _selectedRoom,
                      startTime:
                          '${datecontroller.text} ${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}:00',
                      subject: subjectcontroller.text);

                  examenController.createExamenSchedule(examen);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ReadExamen(idGroup: widget.idGroup,)));
                },
                child: const Text('Add Examen'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
