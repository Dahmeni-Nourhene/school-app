import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/afef/screens/Admin_Screen/formation_speciality_niveau_classe/levelicence.dart';
import 'package:flutter/material.dart';

class SpecialityLicencePage extends StatefulWidget {
  @override
  _SpecialityLicencePageState createState() => _SpecialityLicencePageState();
}

class _SpecialityLicencePageState extends State<SpecialityLicencePage> {
  final _formKey = GlobalKey<FormState>();
  final _specialityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spécialités de Licence'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('specialities_licence')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final specialities = snapshot.data!.docs;
          return ListView.builder(
            itemCount: specialities.length,
            itemBuilder: (context, index) {
              final speciality =
                  specialities[index].data() as Map<String, dynamic>;
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
                        child: Text(speciality['name']),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LevelLicencePage(specialities[index]),
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
              return AlertDialog(
                title: Text('Ajouter une spécialité'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _specialityController,
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
                            .add({
                          'name': _specialityController.text,
                        });
                        _specialityController.clear();
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
