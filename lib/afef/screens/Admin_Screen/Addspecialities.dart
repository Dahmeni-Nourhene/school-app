import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'finalspeciality.dart';
import 'models/specialities.dart';

class SpecialitiesPage extends StatelessWidget {
  final String formationId;

  SpecialitiesPage({required this.formationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Specialités'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Formations')
            .doc(formationId)
            .collection('specialites')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Une erreur est survenue');
          }
          
          
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
 // Crée une Map pour stocker les spécialités de chaque formation
          Map<String, List<DocumentSnapshot>> specialitesParFormation = {};

           for (DocumentSnapshot doc in snapshot.data!.docs) {
            // Récupère le nom de la formation à partir du chemin du document
            String formationNom = doc.reference.parent.parent!.id;
             // Si la formation n'a pas encore de spécialités, crée une nouvelle liste vide
            if (specialitesParFormation[formationNom] == null) {
              specialitesParFormation[formationNom] = [];
            }
            // Ajoute la spécialité à la liste correspondante
            specialitesParFormation[formationNom]!.add(doc);
          }
          // Crée une ListView pour afficher les spécialités de chaque formation
          return ListView.builder(
            itemCount: specialitesParFormation.length,
            itemBuilder: (BuildContext context, int index) {
              String formationNom = specialitesParFormation.keys.elementAt(index);
              List<DocumentSnapshot> specialites = specialitesParFormation[formationNom]!;

              return ExpansionTile(
                title: Text(formationNom),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: specialites.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot specialite = specialites[index];

                      return ListTile(
                        title: Text(specialite['name']),
                        subtitle: Text(specialite['description']),
                        trailing: Text(specialite['level']),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSpecialityPage(formationId: formationId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
           
              
      
    
