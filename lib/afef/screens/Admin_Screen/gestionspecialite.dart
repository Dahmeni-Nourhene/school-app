import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/afef/screens/Admin_Screen/accountlistscreen.dart';
import 'package:essai2/afef/screens/Admin_Screen/listecompte.dart';
import 'package:flutter/material.dart';

class AddSpecialityScreen extends StatefulWidget {
  const AddSpecialityScreen({super.key});

  @override
  State<AddSpecialityScreen> createState() => _AddSpecialityScreenState();
}

class _AddSpecialityScreenState extends State<AddSpecialityScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _newSpecialityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('Ajouter une spécialité'),
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
                    return 'Veuillez entrer un nom de spécialité';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _newSpecialityName = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nom de la nouvelle spécialité',
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
                        .collection('specialities')
                        .add({'name': _newSpecialityName});
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('Comptes étudiants'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('specialities').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<Widget> specialityButtons = [];
          for (var doc in snapshot.data!.docs) {
            var specialityName = doc['name'];
            specialityButtons.add(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentsListScreen(
                                      speciality: specialityName)));
                        },
                        child: Text(specialityName),
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
                const Text('choisir spécialité:',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
                const SizedBox(height: 8.0),
                ...specialityButtons,
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
                              builder: (context) => AddSpecialityScreen()),
                        );
                      },
                      child: const Text('Ajouter une spécialité',
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
