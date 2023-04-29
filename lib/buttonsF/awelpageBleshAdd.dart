import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'calender_firebase.dart';
import '../AdminHomePage.dart';
import '../Model/exam_schedule_model.dart';
import 'add_calendrier.dart';

class CalendPage extends StatefulWidget {
  @override
  _CalendPageState createState() => _CalendPageState();
}

class _CalendPageState extends State<CalendPage> {
  CollectionReference calendriers =
      FirebaseFirestore.instance.collection('calendriers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdminHomePage()));
          },
        ),
        backgroundColor: Colors.cyan[700],
        title: Text('Calendriers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: calendriers.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> formationsData =
              snapshot.data!.docs.cast<QueryDocumentSnapshot>();

          List formation = formationsData.toList();

          return ListView.builder(
            itemCount: formation.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(
                    formationsData[index].get('nom'),
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadDataFromFireBase( calendarId: formationsData[index].get('nom') , 
                          
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AjouterFormationDialog(
              onValider: (nomCalendrier) {
                calendriers.add({
                  'nom': nomCalendrier,
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AjouterFormationDialog extends StatelessWidget {
  final Function(String) onValider;

  AjouterFormationDialog({required this.onValider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AjouterCalendrier(),
    );
  }
}
