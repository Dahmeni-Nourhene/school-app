/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espimapp/screens/Admin_Screen/listecompte.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatelessWidget {
  final String specialityName;

  LevelScreen({required this.specialityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niveaux de $specialityName'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('specialities')
            .doc(specialityName)
            .collection('levels')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<Widget> levelButtons = [];
          for (var doc in snapshot.data!.docs) {
            var levelName = doc['name'];
            levelButtons.add(
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentsListScreen(
                          speciality: specialityName, levelName: levelName),
                    ),
                  );
                },
                child: Text(levelName),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              Text('Liste des niveaux:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              ...levelButtons,
            ],
          );
        },
      ),
    );
  }
}
*/