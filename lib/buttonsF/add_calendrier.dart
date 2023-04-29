import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../AdminHomePage.dart';
import 'awelpageBleshAdd.dart';
import 'awlpage.dart';

class AjouterCalendrier extends StatefulWidget {
  @override
  _AjouterCalendrierState createState() => _AjouterCalendrierState();
}

class _AjouterCalendrierState extends State<AjouterCalendrier> {
  late List<DocumentSnapshot> _calendriers;
  String? _selectedLevel;
  String? _selectedClass;
  String? _selectedFormation;
  String? _selectedSpeciality;
  String? _selectedMatiere;
  String? _selectedGroupe;
  List<String> _specialities = [];

  List<String> _diplomes = [];
  List<String> _levels = [];
  List<String> _classes = [];
  List<String> _groupes = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
    _loadSpecialities();
    _loadClasses();
    _loadLevels();
    _loadFormations();
    _loadGroupes();
  }

/* cette methode utilser pour récup les donnée appartir de firebase et pour l'affiche dans UI 
-elle récup les document de la collection calendriers 
puis stock les document récupérer danns une variable _student : les donné sous forme de liste de type QueryDocumentSnapshot*/
  void _fetchStudents() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('calendriers').get();
    setState(() {
      _calendriers = snapshot.docs;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  //final _surnameController = TextEditingController();
  // final _datenaissanceController = TextEditingController();
  // final _emailController = TextEditingController();
  final _filiereController = TextEditingController();
  final _niveauxController = TextEditingController();
  //final _dateinscriptionController = TextEditingController();
  //final _phoneController = TextEditingController();
  // final _addressController = TextEditingController();
  // final _cityController = TextEditingController();
  //final _stateController = TextEditingController();

/* Cette méthode est appelée pour chaque contrôleur de saisie de texte créé dans le widget
, afin de libérer les ressources de chaque contrôleur.
 Cela permet d'éviter les fuites de mémoire dans l'application et d'optimiser les performances.*/
  @override
  void dispose() {
    _nameController.dispose();
    // _datenaissanceController.dispose();
    _filiereController.dispose();
    _niveauxController.dispose();
    //_dateinscriptionController.dispose();
    //_surnameController.dispose();
    //_emailController.dispose();
    //_phoneController.dispose();
    //_addressController.dispose();
    //_cityController.dispose();
    // _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Ajouter un calendrier'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Nom de calendrier'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le nom est requis.';
                      }
                      return null;
                    },
                  ),

                  /*TextButton(
                              onPressed: () async {
                                final newDate = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedbirthDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (newDate != null) {
                                  setState(() {
                                    _selectedbirthDate = newDate;
                                  });
                                }
                              },
                              child: Text(
                                  'Select birthdate: ${DateFormat.yMd().format(_selectedbirthDate)}'),
                            ),*/

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sélectionnez le diplôme :'),
                      DropdownButtonFormField<String>(
                        value: _selectedFormation,
                        items:
                            _diplomes.map<DropdownMenuItem<String>>((diplome) {
                          return DropdownMenuItem<String>(
                            value: diplome,
                            child: Text(diplome),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFormation = value;
                            _selectedSpeciality = null;
                            _selectedLevel = null;
                            _selectedClass = null;
                            _selectedGroupe = null;
                          });

                          _loadSpecialities();
                        },
                        decoration: InputDecoration(labelText: 'Formation'),
                      ),
                      SizedBox(height: 16),
                      if (_selectedFormation != '')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sélectionnez la spécialité :'),
                            DropdownButtonFormField<String>(
                              value: _selectedSpeciality,
                              items: _specialities
                                  .map<DropdownMenuItem<String>>((speciality) {
                                return DropdownMenuItem<String>(
                                  value: speciality,
                                  child: Text(speciality),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  //_selectedFormation = value;
                                  _selectedSpeciality = value;
                                  _selectedLevel = null;
                                  _selectedClass = null;
                                  _selectedGroupe = null;
                                  _levels = [];

                                  _classes = [];
                                  _groupes = [];
                                });
                                _loadLevels();
                              },
                            ),
                            SizedBox(height: 16),
                            if (_selectedSpeciality != "")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Sélectionnez le niveau :'),
                                  DropdownButtonFormField<String>(
                                    value: _selectedLevel,
                                    items: _levels
                                        .map<DropdownMenuItem<String>>((level) {
                                      return DropdownMenuItem<String>(
                                        value: level,
                                        child: Text(level),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _classes = [];
                                        _groupes = [];

                                        _selectedLevel = value!;
                                        _selectedClass = null;
                                        _selectedGroupe = null;
                                      });
                                      _loadClasses();
                                    },
                                    itemHeight: 50,
                                  ),
                                  SizedBox(height: 16),
                                  if (_selectedLevel != "")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DropdownButtonFormField<String>(
                                          value: _selectedClass,
                                          items: _classes
                                              .map<DropdownMenuItem<String>>(
                                                  (_classes) {
                                            return DropdownMenuItem<String>(
                                              value: _classes,
                                              child: Text(_classes),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedClass = value!;
                                              _selectedGroupe = null;
                                            });
                                            _loadGroupes();
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Classe'),
                                        ),
                                        SizedBox(height: 16),
                                        if (_selectedClass != "")
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DropdownButtonFormField<String>(
                                                  value: _selectedGroupe,
                                                  items: _groupes.map<
                                                      DropdownMenuItem<
                                                          String>>((_groupes) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: _groupes,
                                                      child: Text(_groupes),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedGroupe = value!;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Groupe'),
                                                ),
                                                SizedBox(height: 16),
                                              ]),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Annuler'),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan[700]),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseFirestore.instance
                                  .collection('calendriers')
                                  .add({
                                'nom': _nameController.text,
                                'formation': _selectedFormation,
                                'specialité': _selectedSpeciality,
                                'niveau': _selectedLevel,
                                'class': _selectedClass,
                                'groupe': _selectedGroupe,
                              });
                              Navigator.of(context).pop();
                            } catch (e) {
                              print('Error adding student: $e');
                            }
                          }
                        },
                        child: const Text(
                          'Enregistrer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadFormations() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('diplomes').get();
    List<String> diplomes = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      diplomes.add(data[
          'nom']); // récupère le nom de la spécialité depuis les données du document
    });
    setState(() {
      _diplomes = diplomes;
    });
  }

  Future<void> _loadSpecialities() async {
    if (_selectedFormation != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('specialites')
          .where('idFormation', isEqualTo: _selectedFormation)
          .get();
      List<String> specialities = [];
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        specialities.add(data['nom']);
      });
      setState(() {
        _specialities = specialities;
      });
    }
  }

  Future<void> _loadLevels() async {
    if (_selectedSpeciality != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('niveaux')
          .where('idSpecialite', isEqualTo: _selectedSpeciality)
          .get();
      List<String> levels = [];
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        levels.add(data['nom']);
      });
      setState(() {
        _levels = levels;
      });
    }
  }

  Future<void> _loadClasses() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('classes')
        .where('idFormation', isEqualTo: _selectedFormation)
        .where('idSpecialite', isEqualTo: _selectedSpeciality)
        .where('idNiveau', isEqualTo: _selectedLevel)
        .get();

    List<String> classes = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      classes.add(data['nom']);
    });
    setState(() {
      _classes = classes;
    });
  }

  Future<void> _loadGroupes() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('groupes')
        .where('idFormation', isEqualTo: _selectedFormation)
        .where('idSpecialite', isEqualTo: _selectedSpeciality)
        .where('idNiveau', isEqualTo: _selectedLevel)
        .where('idClasse', isEqualTo: _selectedClass)
        .get();

    List<String> groupes = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      groupes.add(data['nom']);
    });
    setState(() {
      _groupes = groupes;
    });
  }
}
