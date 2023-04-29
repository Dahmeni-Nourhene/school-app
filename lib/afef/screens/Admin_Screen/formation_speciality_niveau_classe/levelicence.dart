import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'classelicence.dart';

class LevelLicencePage extends StatelessWidget {
  final DocumentSnapshot speciality;

  LevelLicencePage(this.speciality);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(speciality['name']),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('specialities_licence')
            .doc(speciality.id)
            .collection('levels')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final levels = snapshot.data!.docs;
          return ListView.builder(
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index].data() as Map<String, dynamic>;
              return SingleChildScrollView(
                child: ListTile(
                  title: Container(
                    margin: const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[50],
                          elevation: 13,
                        ),
                        child: Text(level['name']),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ClassLicencePage(levels[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final _formKey = GlobalKey<FormState>();
              final _levelController = TextEditingController();
              return AlertDialog(
                title: Text('Ajouter un niveau'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _levelController,
                    decoration: InputDecoration(labelText: 'Nom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le nom ne peut pas être vide';
                      }
                      return null;
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Annuler'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('specialities_licence')
                            .doc(speciality.id)
                            .collection('levels')
                            .add({
                          'name': _levelController.text,
                        });
                        _levelController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Ajouter'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
