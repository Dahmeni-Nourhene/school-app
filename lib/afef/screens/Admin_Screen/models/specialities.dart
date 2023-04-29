import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Formation {
  final String name;
  final String id;

  Formation({required this.name, required this.id});

  factory Formation.fromSnapshot(DocumentSnapshot snapshot) {
    return Formation(name: snapshot['name'], id: snapshot.id);
  }
}

class Speciality {
  final String name;
  final String formation;
  final String id;

  Speciality({required this.name, required this.formation, required this.id});

  factory Speciality.fromSnapshot(DocumentSnapshot snapshot) {
    return Speciality(
        name: snapshot['name'],
        formation: snapshot['formation'],
        id: snapshot.id);
  }
}

class AddSpecialityScreen extends StatefulWidget {
  final Formation formation;

  const AddSpecialityScreen({super.key, required this.formation});

  @override
  State<AddSpecialityScreen> createState() => _AddSpecialityScreenState();
}

class _AddSpecialityScreenState extends State<AddSpecialityScreen> {
  final _specialityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une spécialité'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Formation : ${widget.formation.name}'),
              TextField(
                controller: _specialityController,
                decoration: InputDecoration(
                  labelText: 'Nom de spécialité',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final specialityName = _specialityController.text.trim();
                  if (specialityName.isNotEmpty) {
                    FirebaseFirestore.instance.collection('speciality').add({
                      'name': specialityName,
                      'Formation': widget.formation.id,
                    });
                    _specialityController.clear();
                  }
                },
                child: Text('Ajouter la spécialité'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialityListScreen extends StatelessWidget {
  final Formation formation;

  SpecialityListScreen({required this.formation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formation.name),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('speciality')
            .where('formation', isEqualTo: formation.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final specialitys = snapshot.data!.docs
              .map((doc) => Speciality.fromSnapshot(doc))
              .toList();
          return ListView.builder(
            itemCount: specialitys.length,
            itemBuilder: (context, index) {
              final specialitie = specialitys[index];
              return ListTile(
                title: Text(specialitie.name),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddSpecialityScreen(formation: formation),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddFormationScreen extends StatefulWidget {
  @override
  _AddFormationScreenState createState() => _AddFormationScreenState();
}

class _AddFormationScreenState extends State<AddFormationScreen> {
  final _formationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Formation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _formationController,
                decoration: InputDecoration(
                  labelText: 'Nom de la formation',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final formationName = _formationController.text.trim();
                  if (formationName.isNotEmpty) {
                    FirebaseFirestore.instance.collection('formation').add({
                      'name': formationName,
                    });
                    _formationController.clear();
                  }
                },
                child: Text('Ajouter la formation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormationsListScreen extends StatefulWidget {
  @override
  State<FormationsListScreen> createState() => _FormationsListScreenState();
}

class _FormationsListScreenState extends State<FormationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('formation'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('formation').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final formations = snapshot.data!.docs
              .map((doc) => Formation.fromSnapshot(doc))
              .toList();
          return ListView.builder(
            itemCount: formations.length,
            itemBuilder: (context, index) {
              final formation = formations[index];
              return ListTile(
                title: Text(formation.name),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SpecialityListScreen(formation: formation),
                  ));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddFormationScreen(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
