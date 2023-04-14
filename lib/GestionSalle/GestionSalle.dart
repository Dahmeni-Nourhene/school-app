import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _newRoomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('Ajouter une salle'),
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
                    return 'Veuillez entrer un nom de salle';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _newRoomName = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nom de la nouvelle salle',
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
                        .collection('rooms')
                        .add({'name': _newRoomName});
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

class MainScreenRoom extends StatelessWidget {
  const MainScreenRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('les salles'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<Widget> roomButtons = [];
          for (var doc in snapshot.data!.docs) {
            var roomName = doc['name'];
            roomButtons.add(
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
                        onPressed: () {},
                        child: Text(
                          roomName,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
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
                const Text('choisir salle:',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
                const SizedBox(height: 8.0),
                ...roomButtons,
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
                              builder: (context) => AddRoomScreen()),
                        );
                      },
                      child: const Text('Ajouter une salle',
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
