import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSpecialityPage extends StatefulWidget {
  final String formationId;

  const AddSpecialityPage({super.key, required this.formationId});

  @override
  State<AddSpecialityPage> createState() => _AddSpecialityPageState();
}

class _AddSpecialityPageState extends State<AddSpecialityPage> {
  final _formKey = GlobalKey<FormState>();
  List<QueryDocumentSnapshot> _specialites = [];
  String _selectedformation = 'Licence';
  final TextEditingController _namespecialityController =
      TextEditingController();

  final TextEditingController _levelspecialityController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _classes = [];

  final _classesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Formations')
          .doc(widget.formationId)
          .collection('specialites')
          .get();

      if (mounted) {
        setState(() {
          _specialites = snapshot.docs;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addSpeciality() async {
    try {
      if (_formKey.currentState!.validate()) {
        await FirebaseFirestore.instance
            .collection('Formations')
            .doc(widget.formationId)
            .collection('specialites')
            .add({
          'name': _namespecialityController.text,
          'description': _descriptionController.text,
          'level': _levelspecialityController.text,
          'formation': _selectedformation,
          'classes': _classes,
        });
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter Specialité'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namespecialityController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Le nom est requis.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'La description est requis.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _levelspecialityController,
              decoration: const InputDecoration(
                labelText: 'Level',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Le niveau est requis.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _classesController,
              decoration: InputDecoration(
                labelText: 'Classes',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _classes.add(_classesController.text);
                      _classesController.clear();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ..._classes.map((cls) => Chip(label: Text(cls))),
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder<QuerySnapshot>(
                future:
                    FirebaseFirestore.instance.collection('Formations').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Une erreur est survenue');
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<DropdownMenuItem<String>> formations = [];
                  for (var doc in snapshot.data!.docs) {
                    formations.add(DropdownMenuItem<String>(
                      value: doc['name'],
                      child: Text(doc['name']),
                    ));
                  }
                  return DropdownButtonFormField<String>(
                    value: _selectedformation,
                    items: formations,
                    onChanged: (value) {
                      setState(() {
                        _selectedformation = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Formation'),
                  );
                }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addSpeciality();
                }
              },
              child: const Text('Ajouter Spécialité'),
            ),
          ],
        ),
      ),
    );
  }
}
