import 'package:cloud_firestore/cloud_firestore.dart';

class ExamSchedule {
  String id;
  
  final String date;
  final String endTime;
  final String startTime;
  final String group;
  final String room;
  final String subject;

  ExamSchedule(
     {required this.id,
     
      required this.date,
      required this.endTime,
      required this.startTime,
      required this.group,
      required this.room,
      required this.subject,
      });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      id:json['id'],
      
        date: json['date'],
        endTime: json['endTime'],
        startTime: json['startTime'],
        group: json['group'],
        room: json['room'],
        subject: json['subject'],
 );
  }

  toJson() {
    return {
      'id': id,
      
      'date': date,
      'endTime': endTime,
      'startTime': startTime,
      'group': group,
      'room': room,
      'subject': subject,
    };
  }
}
