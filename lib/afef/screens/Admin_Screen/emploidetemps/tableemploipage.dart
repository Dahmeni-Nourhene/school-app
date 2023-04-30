import 'package:essai2/afef/screens/Admin_Screen/emploidetemps/addemploi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({
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
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des plannings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
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
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                child: ListTile(
                  title: Text(document['session']),
                  subtitle: Text(
                      '${document['day']} de ${document['startTime'].toDate().hour}:${document['startTime'].toDate().minute} à ${document['endTime'].toDate().hour}:${document['endTime'].toDate().minute}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteSchedule(document.id);
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddScheduleScreen(
                    universityId: widget.universityId,
                    specialtyId: widget.specialtyId,
                    classId: widget.classId,
                    groupId: widget.groupId,
                    semesterId: widget.semesterId,
                    weekId: widget.weekId)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteSchedule(String documentId) async {
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
          .doc(documentId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Le planning a été supprimé avec succès.')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
  }
}
