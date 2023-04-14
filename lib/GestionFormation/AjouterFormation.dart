import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FormationPage extends StatefulWidget {
  const FormationPage({super.key});

  @override
  State<FormationPage> createState() => _FormationPageState();
}

class _FormationPageState extends State<FormationPage> {
  final _formKey = GlobalKey<FormState>();
  late String _newFormationName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('gérer les formation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un nom de la formation';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _newFormationName = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nom de la nouvelle Formation',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[50],
                  elevation: 13.00,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await FirebaseFirestore.instance
                        .collection('Formations')
                        .add({'name': _newFormationName});
                    Navigator.pop(context);
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainFormationScreen extends StatefulWidget {
  const MainFormationScreen({super.key});

  @override
  State<MainFormationScreen> createState() => _MainFormationScreenState();
}

class _MainFormationScreenState extends State<MainFormationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('les Formation'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Formations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<Widget> formationButtons = [];
          for (var doc in snapshot.data!.docs) {
            var formationName = doc['name'];
            formationButtons.add(
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 360,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60.0, 60.0),
                          backgroundColor: Colors.cyan[50],
                          elevation: 13.0,
                        ),
                        onPressed: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentsListScreen(
                                      speciality: specialityName)));*/
                        },
                        child: Text(formationName),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                const Text('choisir Formation:',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
                const SizedBox(height: 8.0),
                ...formationButtons,
                const SizedBox(height: 30.0),
                Container(
                  margin: const EdgeInsets.only(left: 100, right: 100),
                  child: SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[50],
                        elevation: 13,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormationPage()),
                        );
                      },
                      child: const Text('Ajouter une Formation',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
