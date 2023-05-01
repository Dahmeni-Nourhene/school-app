import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/AdminHomePage.dart';
import 'package:essai2/Model/exam_schedule_model.dart';
import 'package:essai2/screen/create_examen.dart';
import 'package:essai2/screen/update_examen.dart';
import 'package:flutter/material.dart';

import '../Model/calendriers_model.dart';
import '../controller/Examen_controller.dart';
import '../buttonsF/calender_firebase.dart';

class ReadExamen extends StatefulWidget {
  final Calendriers idGroup;
  const ReadExamen({super.key, required this.idGroup});

  @override
  State<ReadExamen> createState() => _ReadExamenState();
}

class _ReadExamenState extends State<ReadExamen> {
  ExamenController examenController = ExamenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: const Text(
            'Calendrier des examens',
            
          ),
leading: BackButton(onPressed: (){
  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LoadDataFromFireBase( calendarId: widget.idGroup ,)),
              );
}),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.cyan[700],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Examen(idGroup: widget.idGroup ,)),
              );
            },
            child: const Icon(
              Icons.add,
            )),
        body: StreamBuilder<List<ExamSchedule>>(
            stream: examenController.readExamSchedule(widget.idGroup.id.trim()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('somthing went wrong ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final examen = snapshot.data!;
                return ListView(
                  children: examen.map((document) {
                    return ListTile(
                      title: Text(document.subject),
                      subtitle:
                          Text("${document.startTime}\n${document.endTime}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateExamen(
                                              examen: document,
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.teal,
                              )),
                          IconButton(
                              onPressed: () {
                                examenController
                                    .deleteExamenSchedule(document.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
