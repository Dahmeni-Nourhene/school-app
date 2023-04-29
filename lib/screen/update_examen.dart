import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

import '../Model/exam_schedule_model.dart';
import '../controller/Examen_controller.dart';

class UpdateExamen extends StatefulWidget {
  final ExamSchedule examen;
  const UpdateExamen({super.key, required this.examen});

  @override
  State<UpdateExamen> createState() => _UpdateExamenState();
}

class _UpdateExamenState extends State<UpdateExamen> {
  final _formKey = GlobalKey<FormState>();
  final subjectcontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final startTimecontroller = TextEditingController();
  final endTimecontroller = TextEditingController();
  final roomcontroller = TextEditingController();
  final groupcontroller = TextEditingController();
  List? start;
  List? end;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  ExamenController examenController = ExamenController();
  @override
  void initState() {
    if (widget.examen == null) {
      //New Record
      subjectcontroller.text = "";
      datecontroller.text = "";
      startTimecontroller.text = "";
      endTimecontroller.text = "";
      roomcontroller.text = "";
      groupcontroller.text = "";
    } else {
      subjectcontroller.text = widget.examen.subject;
      datecontroller.text = widget.examen.date;
      startTimecontroller.text = widget.examen.startTime;
      endTimecontroller.text = widget.examen.endTime;
      roomcontroller.text = widget.examen.room;
      groupcontroller.text = widget.examen.group;

      start = widget.examen.startTime.split(' ');
      end = widget.examen.endTime.split(' ');
      log(start?[1]);
    }

    super.initState();
  }

  @override
  void dispose() {
    subjectcontroller.dispose();
    datecontroller.dispose();
    startTimecontroller.dispose();
    endTimecontroller.dispose();
    roomcontroller.dispose();
    groupcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "choose  a room",
                  ),
                  controller: roomcontroller,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "choose  a group",
                  ),
                  controller: groupcontroller,
                ),
                TextField(
                    controller:
                        datecontroller, //editing controller of this TextField
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
                      });
                    },
                  ),
                ),
                _startTime == _endTime
                    ? Text("Time : ${start?[1]} to ${end?[1]}")
                    : Text(
                        "Time : ${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')} to ${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}"),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    final examen = ExamSchedule(
                        id: widget.examen.id,
                        
                        date: datecontroller.text,
                        endTime: _startTime == _endTime
                            ? widget.examen.endTime
                            : "${datecontroller.text} ${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}:00",
                        group: groupcontroller.text,
                        room: roomcontroller.text,
                        startTime: _startTime == _endTime
                            ? widget.examen.startTime
                            : '${datecontroller.text} ${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}:00',
                        subject: subjectcontroller.text);
                    examenController.updateExamenSchedule(
                        widget.examen.id, examen);
                  },
                  child: const Text('Edit Examen'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
