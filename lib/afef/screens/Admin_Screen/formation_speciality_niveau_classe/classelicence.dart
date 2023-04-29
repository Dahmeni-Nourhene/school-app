import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassLicencePage extends StatelessWidget {
  final DocumentSnapshot level;
  ClassLicencePage(this.level);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(level['name']),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('specialities_licence')
            .doc(level.id)
            .collection('levels')
            .doc(level.id)
            .collection('classes')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final classes = snapshot.data!.docs;
          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classe = classes[index].data() as Map<String, dynamic>;
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
                          onPressed: () {},
                          child: Text(classe['name'])),
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
              final _classController = TextEditingController();
              return AlertDialog(
                title: Text('Ajouter une classe'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _classController,
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
                            .doc(level.id)
                            .collection('levels')
                            .doc(level.id)
                            .collection('classes')
                            .add({
                          'name': _classController.text,
                        });
                        _classController.clear();
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
