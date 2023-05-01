// import 'dart:developer';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:simple_time_range_picker/simple_time_range_picker.dart';

// import '../Model/exam_schedule_model.dart';
// import '../buttonsF/awelpageBleshAdd.dart';
// import '../controller/Examen_controller.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essai2/AdminHomePage.dart';
// import 'package:essai2/Model/exam_schedule_model.dart';
// import 'package:essai2/screen/create_examen.dart';
// import 'package:essai2/screen/update_examen.dart';
// import 'package:flutter/material.dart';

// import '../controller/Examen_controller.dart';
// import '../buttonsF/calender_firebase.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essai2/screen/read_examen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:intl/intl.dart';

// import '../essais/essai_finaaaal.dart';

// class LoadDataFromFireBase extends StatelessWidget {
//   final String calendarId;

//   LoadDataFromFireBase({required this.calendarId});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'FireBase',
//       home: LoadDataFromFireStore(calendarId: calendarId),
//     );
//   }
// }

// class LoadDataFromFireStore extends StatefulWidget {
//   final String calendarId;

//   LoadDataFromFireStore({required this.calendarId});

//   @override
//   LoadDataFromFireStoreState createState() => LoadDataFromFireStoreState();
// }

// class LoadDataFromFireStoreState extends State<LoadDataFromFireStore> {
//   List<Color> _colorCollection = <Color>[];
//   MeetingDataSource? events;
//   // final List<String> options = <String>['Add', 'Delete', 'Update'];
//   final databaseReference = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     _initializeEventColor();
//     getDataFromFireStore().then((results) {
//       SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//         setState(() {});
//       });
//     });
//     super.initState();
//   }

//   Future<void> getDataFromFireStore() async {
//     var snapShotsValue = await databaseReference
//         .collection("exam_schedule")
//         .where('calendarId', isEqualTo: widget.calendarId)
//         // .doc(widget.calendarId)
//         //.collection("events")
//         .get();
//     final Random random = new Random();
//     List<Meeting> list = snapShotsValue.docs
//         .map((e) => Meeting(
//             eventName: e.data()['subject'],
//             from:
//                 DateFormat('yyyy/MM/dd HH:mm:ss').parse(e.data()['startTime']),
//             to: DateFormat('yyyy/MM/dd HH:mm:ss').parse(e.data()['endTime']),
//             background: _colorCollection[random.nextInt(9)],
//             isAllDay: false))
//         .toList();

//     setState(() {
//       events = MeetingDataSource(list);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.cyan[700],
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => CalendPage()),
//               );
//             },
//           ),
//           title: Text(widget.calendarId),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => ReadExamen1111()),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: SfCalendar(
//           view: CalendarView.week,
//           firstDayOfWeek: 1,
//           dataSource: events,
//           timeSlotViewSettings: const TimeSlotViewSettings(
//             startHour: 7,
//             endHour: 18,
//             nonWorkingDays: <int>[DateTime.sunday],
//             timeIntervalHeight: 50,
//             timeFormat: 'HH:mm',
//             dateFormat: 'd',
//             dayFormat: 'EEE',
//           ),
//         ));
//   }

//   void _initializeEventColor() {
//     _colorCollection.add(const Color(0xFF0F8644));
//     _colorCollection.add(const Color(0xFF8B1FA9));
//     _colorCollection.add(const Color(0xFFD20100));
//     _colorCollection.add(const Color(0xFFFC571D));
//     _colorCollection.add(const Color(0xFF36B37B));
//     _colorCollection.add(const Color(0xFF01A1EF));
//     _colorCollection.add(const Color(0xFF3D4FB5));
//     _colorCollection.add(const Color(0xFFE47C73));
//     _colorCollection.add(const Color(0xFF636363));
//     _colorCollection.add(const Color(0xFF0A8043));
//   }
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
// }

// class Meeting {
//   String? eventName;
//   DateTime? from;
//   DateTime? to;
//   Color? background;
//   bool? isAllDay;

//   Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay});
// }

// class ExamSchedule {
//   String id;

//   final String date;
//   final String endTime;
//   final String startTime;
//   final String group;
//   final String room;
//   final String subject;

//   ExamSchedule({
//     required this.id,
//     required this.date,
//     required this.endTime,
//     required this.startTime,
//     required this.group,
//     required this.room,
//     required this.subject,
//   });

//   factory ExamSchedule.fromJson(Map<String, dynamic> json) {
//     return ExamSchedule(
//       id: json['id'],
//       date: json['date'],
//       endTime: json['endTime'],
//       startTime: json['startTime'],
//       group: json['group'],
//       room: json['room'],
//       subject: json['subject'],
//     );
//   }

//   toJson() {
//     return {
//       'id': id,
//       'date': date,
//       'endTime': endTime,
//       'startTime': startTime,
//       'group': group,
//       'room': room,
//       'subject': subject,
//     };
//   }
// }

// class ReadExamen1111 extends StatefulWidget {
//   const ReadExamen1111({super.key});
// ////////////////////////////////

// ////////////////////////////////
//   @override
//   State<ReadExamen1111> createState() => _ReadExamen1111State();
// }

// class _ReadExamen1111State extends State<ReadExamen1111> {
//   ExamenController examenController = ExamenController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.cyan[700],
//           title: const Text(
//             'Calendrier des examens',
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         LoadDataFromFireStore(calendarId: 'calendarId')),
//               );
//             },
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//             backgroundColor: Colors.cyan[700],
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  Examen(idGroup: "",)),
//               );
//             },
//             child: const Icon(
//               Icons.add,
//             )),
//         body: StreamBuilder<List<ExamSchedule>>(
//             stream: examenController.readExamSchedule(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text('somthing went wrong ${snapshot.error}'),
//                 );
//               } else if (snapshot.hasData) {
//                 final examen = snapshot.data!;
//                 return ListView(
//                   children: examen.map((document) {
//                     return ListTile(
//                       title: Text(document.subject),
//                       subtitle:
//                           Text("${document.startTime}\n${document.endTime}"),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => UpdateExamen(
//                                               examen: document,
//                                             )));
//                               },
//                               icon: const Icon(
//                                 Icons.edit,
//                                 color: Colors.teal,
//                               )),
//                           IconButton(
//                               onPressed: () {
//                                 examenController
//                                     .deleteExamenSchedule(document.id);
//                               },
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               ))
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }));
//   }
// }

// class ExamenController {
//   Stream<List<ExamSchedule>> readExamSchedule() => FirebaseFirestore.instance
//       .collection('exam_schedule')
//       .snapshots()
//       .map((snapshots) => snapshots.docs
//           .map((doc) => ExamSchedule.fromJson(doc.data()))
//           .toList());

//   Future createExamenSchedule(ExamSchedule examen) async {
//     final docExamen =
//         FirebaseFirestore.instance.collection('exam_schedule').doc();
//     examen.id = docExamen.id;
//     final json = examen.toJson();
//     await docExamen.set(json);
//   }

//   Future<ExamSchedule?> getOneExamenSchedule(String id) async {
//     final docExamen =
//         FirebaseFirestore.instance.collection('exam_schedule').doc(id);
//     final snapshot = await docExamen.get();
//     if (snapshot.exists) {
//       return ExamSchedule.fromJson(snapshot.data()!);
//     }
//   }

//   Future updateExamenSchedule(String id, ExamSchedule examen) async {
//     final docExamen =
//         FirebaseFirestore.instance.collection('exam_schedule').doc(id);
//     final json = examen.toJson();
//     await docExamen.update(json);
//   }

//   Future deleteExamenSchedule(String id) async {
//     final docExamen =
//         FirebaseFirestore.instance.collection('exam_schedule').doc(id);
//     docExamen.delete();
//   }
// }

// class UpdateExamen extends StatefulWidget {
//   final ExamSchedule examen;
//   const UpdateExamen({super.key, required this.examen});

//   @override
//   State<UpdateExamen> createState() => _UpdateExamenState();
// }

// class _UpdateExamenState extends State<UpdateExamen> {
//   final _formKey = GlobalKey<FormState>();
//   final subjectcontroller = TextEditingController();
//   final datecontroller = TextEditingController();
//   final startTimecontroller = TextEditingController();
//   final endTimecontroller = TextEditingController();
//   final roomcontroller = TextEditingController();
//   final groupcontroller = TextEditingController();
//   List? start;
//   List? end;
//   TimeOfDay _startTime = TimeOfDay.now();
//   TimeOfDay _endTime = TimeOfDay.now();
//   ExamenController examenController = ExamenController();
//   @override
//   void initState() {
//     if (widget.examen == null) {
//       //New Record
//       subjectcontroller.text = "";
//       datecontroller.text = "";
//       startTimecontroller.text = "";
//       endTimecontroller.text = "";
//       roomcontroller.text = "";
//       groupcontroller.text = "";
//     } else {
//       subjectcontroller.text = widget.examen.subject;
//       datecontroller.text = widget.examen.date;
//       startTimecontroller.text = widget.examen.startTime;
//       endTimecontroller.text = widget.examen.endTime;
//       roomcontroller.text = widget.examen.room;
//       groupcontroller.text = widget.examen.group;

//       start = widget.examen.startTime.split(' ');
//       end = widget.examen.endTime.split(' ');
//       //log(start?[1]);
//     }

//     super.initState();
//   }

//   @override
//   void dispose() {
//     subjectcontroller.dispose();
//     datecontroller.dispose();
//     startTimecontroller.dispose();
//     endTimecontroller.dispose();
//     roomcontroller.dispose();
//     groupcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: "choose  a subject",
//                   ),
//                   controller: subjectcontroller,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: "choose  a room",
//                   ),
//                   controller: roomcontroller,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: "choose  a group",
//                   ),
//                   controller: groupcontroller,
//                 ),
//                 TextField(
//                     controller:
//                         datecontroller, //editing controller of this TextField
//                     decoration: const InputDecoration(
//                         icon: Icon(Icons.calendar_today),
//                         labelText: "Enter Date"),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101));
//                       if (pickedDate != null) {
//                         String formattedDate =
//                             DateFormat('yyyy/MM/dd').format(pickedDate);
//                         setState(() {
//                           datecontroller.text = formattedDate;
//                         });
//                       } else {
//                         print("Date is not selected");
//                       }
//                     }),
//                 ElevatedButton(
//                   child: const Text("say when"),
//                   onPressed: () => TimeRangePicker.show(
//                     context: context,
//                     unSelectedEmpty: true,
//                     startTime: TimeOfDay(
//                         hour: _startTime.hour, minute: _startTime.minute),
//                     endTime:
//                         TimeOfDay(hour: _endTime.hour, minute: _endTime.minute),
//                     onSubmitted: (TimeRangeValue value) {
//                       setState(() {
//                         _startTime = value.startTime!;
//                         _endTime = value.endTime!;
//                       });
//                     },
//                   ),
//                 ),
//                 _startTime == _endTime
//                     ? Text("Time : ${start?[1]} to ${end?[1]}")
//                     : Text(
//                         "Time : ${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')} to ${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}"),
//                 ElevatedButton(
//                   onPressed: () {
//                     _formKey.currentState!.validate();
//                     final examen = ExamSchedule(
//                         id: widget.examen.id,
//                         date: datecontroller.text,
//                         endTime: _startTime == _endTime
//                             ? widget.examen.endTime
//                             : "${datecontroller.text} ${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}:00",
//                         group: groupcontroller.text,
//                         room: roomcontroller.text,
//                         startTime: _startTime == _endTime
//                             ? widget.examen.startTime
//                             : '${datecontroller.text} ${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}:00',
//                         subject: subjectcontroller.text);
//                     examenController.updateExamenSchedule(
//                         widget.examen.id, examen);
//                   },
//                   child: const Text('Edit Examen'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
