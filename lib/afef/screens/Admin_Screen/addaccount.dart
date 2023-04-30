import 'package:essai2/afef/screens/Admin_Screen/models/specialities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  List<String> _formations = ['licence', 'master'];
  String _selectedRole = 'admin';
  //String _selectedSpeciality = 'LFG';
  String? _selectedSpeciality;
  String? _selectedLevel;
  String? _selectedClass;
  String? _selectedFormation = 'licence';
  List<String> _specialities = [];
  List<String> _levels = [];
  List<String> _classes = [];

  //List<String> _specialities = [];
  //Définir les variables d'état pour stocker les options de menu de la spécialité, du niveau et de la classe

//Méthode pour mettre à jour les options de menu de la spécialité, du niveau et de la classe en fonction de la formation sélectionnée

  @override
  void initState() {
    super.initState();
    _loadSpecialities();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _addUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (_selectedRole == 'etudiant') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'role': _selectedRole,
          'speciality': _selectedSpeciality,
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'role': _selectedRole,
        });
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Le mot de passe est trop faible.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cette adresse e-mail est déjà utilisée.'),
          ),
        );
      }
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
          backgroundColor: Colors.cyan[700],
          title: Text('Ajouter un utilisateur'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nom complet'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Adresse e-mail'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une adresse e-mail.';
                      }
                      if (!value.contains('@')) {
                        return 'Veuillez entrer une adresse e-mail valide.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe.';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères.';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    items: ['etudiant', 'admin', 'employé', 'enseignant']
                        .map<DropdownMenuItem<String>>((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(
                          role.toUpperCase(),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                        _selectedRole = value;
                        _selectedSpeciality = null;
                        _selectedLevel = null;
                        _selectedClass = null;
                        _levels = [];
                        _classes = [];

                        if (_selectedRole == 'etudiant') {
                          _formations = ["licence", "master"];
                        }
                      });
                      _loadSpecialities();
                    },
                    decoration: InputDecoration(labelText: 'Rôle'),
                  ),
                  if (_selectedRole == "etudiant" && _formations.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Text("Formation :"),
                        //AFEEEEEEEEEEEEEEEEEEEFFFFFFFnnnn
                        DropdownButtonFormField<String>(
                          value: _selectedFormation,
                          items: _formations
                              .map((formation) => DropdownMenuItem<String>(
                                    value: formation,
                                    child: Text(formation),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFormation = value;
                              _selectedSpeciality = null;
                              _selectedLevel = null;
                              _selectedClass = null;
                              _levels = [];
                              _classes = [];

                              if (_selectedFormation == "Licence") {
                                _loadSpecialities();
                              }
                            });
                          },
                          decoration: InputDecoration(labelText: 'Formation'),
                        ),
                        if (_selectedFormation == "licence" &&
                            _specialities.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.0),
                              Text("Spécialité :"),
                              DropdownButtonFormField<String>(
                                value: _selectedSpeciality,
                                items: _specialities.map((speciality) {
                                  return DropdownMenuItem<String>(
                                    value: speciality,
                                    child: Text(speciality),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSpeciality = value;
                                    _loadLevels();
                                  });
                                },
                              ),
                              if (_selectedSpeciality != null &&
                                  _specialities.isNotEmpty)

                                // &&_levels.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16.0),
                                    Text("Niveau :"),
                                    DropdownButtonFormField<String>(
                                      value: _selectedLevel,
                                      items: _levels.map((level) {
                                        return DropdownMenuItem<String>(
                                          value: level,
                                          child: Text(level),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedLevel = value;
                                          _loadClasses();
                                        });
                                      },
                                    ),
                                    if (_selectedLevel != null &&
                                        _classes.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 16.0),
                                          Text("Classe :"),
                                          DropdownButtonFormField<String>(
                                            value: _selectedClass,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedClass = value;
                                              });
                                            },
                                            items: _classes.map((classe) {
                                              return DropdownMenuItem<String>(
                                                value: classe,
                                                child: Text(classe),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                            ],
                          ),
                      ],
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[700],
                      elevation: 13.0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addUser();
                      }
                    },
                    child: Text(
                      'Ajouter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _loadSpecialities() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('specialities_licence')
        .get();
    List<String> specialities = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      specialities.add(data[
          'name']); // récupère le nom de la spécialité depuis les données du document
    });
    setState(() {
      _specialities = specialities;
    });
  }

  Future<void> _loadLevels() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('specialities_licence')
        .doc(_selectedSpeciality)
        .collection('levels')
        .get();
    List<String> levels = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      levels.add(data['name']);
      for (var documentSnapshot in snapshot.docs) {
        print(documentSnapshot.data());
      }
    });
    setState(() {
      _levels = levels;
      _selectedLevel = null;
      _selectedClass = null;
    });
  }

  Future<void> _loadClasses() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('specialities_licence')
        .doc(_selectedSpeciality)
        .collection('levels')
        .doc(_selectedLevel)
        .collection('classes')
        .get();

    List<String> classes = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      classes.add(data['name']);
    });
    setState(() {
      _classes = classes;
    });
  }
}
