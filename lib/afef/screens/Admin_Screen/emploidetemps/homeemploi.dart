/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espimapp/screens/Admin_Screen/emploidetemps/addemploi.dart';
import 'package:espimapp/screens/Admin_Screen/emploidetemps/tableemploipage.dart';
import 'package:flutter/material.dart';

class HomePageEmploi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emplois du temps'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('emploi_temps').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.size == 0) {
            return Center(child: Text('Aucun emploi du temps disponible'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (BuildContext context, int index) {
              final timetable = snapshot.data!.docs[index];

              return ListTile(
                title: Text(
                    '${timetable['année universitaire']} - ${timetable['semestre']}'),
                subtitle:
                    Text('${timetable['spécialité']} - ${timetable['groupe']}'),
                onTap: () {
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TimetablePage(timetableId: timetable.id)),
                  );*/
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScheduleScreen(universityId: Widget, specialtyId: widget.specialtyId, classId: widget.classId, groupId: widget.groupId, semesterId: widget.semesterId, weekId: widget.weekId)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
*/