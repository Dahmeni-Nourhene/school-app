import 'package:essai2/afef/screens/Admin_Screen/models/student.dart';
import 'package:essai2/afef/screens/Admin_Screen/showdetailsstudent.dart';
import 'package:essai2/afef/screens/Admin_Screen/showdetailsteacher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TeacherListPage extends StatefulWidget {
  const TeacherListPage({super.key});

  @override
  State<TeacherListPage> createState() => _TeacherListPageState();
}

class _TeacherListPageState extends State<TeacherListPage> {
  late List<DocumentSnapshot> _teachers;

  @override
  void initState() {
    super.initState();
    _fetchTeacher();
  }

  void _fetchTeacher() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('teachers').get();
    setState(() {
      _teachers = snapshot.docs;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameensController = TextEditingController();
  final _surnameensController = TextEditingController();
  final _datenaissanceensController = TextEditingController();
  final _emailensController = TextEditingController();
  final _deptController = TextEditingController();
  final _gradeController = TextEditingController();
  final _dateembaucheController = TextEditingController();
  final _phoneensController = TextEditingController();
  final _addressensController = TextEditingController();
  final _cityensController = TextEditingController();
  @override
  void dispose() {
    _nameensController.dispose();
    _datenaissanceensController.dispose();
    _deptController.dispose();
    _gradeController.dispose();
    _dateembaucheController.dispose();
    _surnameensController.dispose();
    _emailensController.dispose();
    _phoneensController.dispose();
    _addressensController.dispose();
    _cityensController.dispose();

    super.dispose();
  }

  void _editTeacher(String teacherId) {
    // Récupérer la référence à l'enseignant à modifier dans Firebase
    final DocumentReference teacherRef =
        FirebaseFirestore.instance.collection('teachers').doc(teacherId);

    // Récupérer les données actuelles de l'enseignant à partir de Firebase
    teacherRef.get().then((DocumentSnapshot teacherSnapshot) {
      if (teacherSnapshot.exists) {
        // Afficher une boîte de dialogue contenant un formulaire pré-rempli avec les données actuelles de l'enseignat
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final TextEditingController nameensController =
                TextEditingController(text: teacherSnapshot['nom']);
            final TextEditingController addressensController =
                TextEditingController(text: teacherSnapshot['adresse']);
            final TextEditingController cityensController =
                TextEditingController(text: teacherSnapshot['ville']);

            final TextEditingController surnameensController =
                TextEditingController(text: teacherSnapshot['prenom']);
            final TextEditingController datenaissanceensController =
                TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        teacherSnapshot['date de naissance']
                            .toDate()
                            .toString())));
            final TextEditingController dateembaucheController =
                TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        teacherSnapshot['date d\'embauche']
                            .toDate()
                            .toString())));

            final TextEditingController gradeController =
                TextEditingController(text: teacherSnapshot['grade']);
            final TextEditingController deptController =
                TextEditingController(text: teacherSnapshot['departement']);

            final TextEditingController emailensController =
                TextEditingController(text: teacherSnapshot['email']);
            final TextEditingController phoneensController =
                TextEditingController(text: teacherSnapshot['telephone']);

            return AlertDialog(
              title: Text('Modifier l\'enseignant'),
              content: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameensController,
                        decoration: InputDecoration(labelText: 'Nom'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le nom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: surnameensController,
                        decoration: InputDecoration(labelText: 'Prénom'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le prénom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailensController,
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'L\'email est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phoneensController,
                        decoration: InputDecoration(labelText: 'Téléphone'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le téléphone est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: datenaissanceensController,
                        decoration:
                            InputDecoration(labelText: 'Date de naissance'),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La date de naissance est requise.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: deptController,
                        decoration: InputDecoration(labelText: 'Département'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La département est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: gradeController,
                        decoration: InputDecoration(labelText: 'Grade'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le grade est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dateembaucheController,
                        decoration:
                            InputDecoration(labelText: 'Date d\'embauche'),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La date d\'embauche est requise.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: addressensController,
                        decoration: InputDecoration(labelText: 'Adresse'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'L\'adresse est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cityensController,
                        decoration: InputDecoration(labelText: 'Ville'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La ville est requis.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Enregistrer'),
                  onPressed: () {
                    // Mettre à jour les informations de l'enseignant dans Firebase
                    teacherRef.update({
                      'nom': nameensController.text,
                      'prenom': surnameensController.text,
                      'email': emailensController.text,
                      'telephone': phoneensController.text,
                      'date d\'embauche': Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd')
                              .parse(dateembaucheController.text)),
                      'date de naissance': Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd')
                              .parse(datenaissanceensController.text)),
                      'grade': gradeController.text,
                      'departement': deptController.text,
                      'adresse': addressensController.text,
                      'ville': cityensController.text,
                    }).then((value) {
                      print('Enseignant mis à jour avec succès');
                    }).catchError((error) {
                      print(
                          'Erreur lors de la mise à jour de l\'enseigant: $error');
                    });

                    _fetchTeacher();

                    // Mettre à jour les informations de l'enseignant dans l'interface utilisateur
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('teachers')
                          .doc(teacherId)
                          .update({
                        'nom': nameensController.text,
                        'prenom': surnameensController.text,
                        'email': emailensController.text,
                        'telephone': phoneensController.text,
                        'adresse': addressensController.text,
                        'ville': cityensController.text,
                        'date d\'embauche': Timestamp.fromDate(
                            DateFormat('yyyy-MM-dd')
                                .parse(dateembaucheController.text)),
                        'date de naissance': Timestamp.fromDate(
                            DateFormat('yyyy-MM-dd')
                                .parse(datenaissanceensController.text)),
                        'grade': gradeController.text,
                        'departement': deptController.text,
                      });
                    });

                    // Fermer la boîte de dialogue
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text(
          'Liste des enseignants',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('teachers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Une erreur est survenue.');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Text('Aucun enseigant trouvé.');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Supprimer l\'enseigant?'),
                                content: Text(
                                    'Voulez-vous vraiment supprimer ce enseigant ?'),
                                actions: [
                                  TextButton(
                                    child: Text('Annuler'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Supprimer'),
                                    onPressed: () async {
                                      deleteTeacher(document.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        color: Colors.cyan[700],
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          _editTeacher(document.id);
                        },
                      ),
                    ],
                  ),
                  title: Text(
                    data['nom'] + ' ' + data['prenom'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TeachersDetailsPage(teacher: data)),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ajouter un enseigant'),
                content: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _nameensController,
                          decoration: InputDecoration(labelText: 'Nom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le nom est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _surnameensController,
                          decoration: InputDecoration(labelText: 'Prénom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le prénom est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailensController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'email est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneensController,
                          decoration: InputDecoration(labelText: 'Téléphone'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le téléphone est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _datenaissanceensController,
                          decoration:
                              InputDecoration(labelText: 'Date de naissance'),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'La date de naissance est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _addressensController,
                          decoration: InputDecoration(labelText: 'Adresse'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'adresse est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _gradeController,
                          decoration: InputDecoration(labelText: 'Grade'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le grade est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _deptController,
                          decoration: InputDecoration(labelText: 'Departement'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le departement est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _dateembaucheController,
                          decoration:
                              InputDecoration(labelText: 'Date d\'embauche'),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'La date d\'embauche  est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _cityensController,
                          decoration: InputDecoration(labelText: 'Ville'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'La ville est requise.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Annuler'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[700]),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseFirestore.instance
                              .collection('teachers')
                              .add({
                            'nom': _nameensController.text,
                            'prenom': _surnameensController.text,
                            'email': _emailensController.text,
                            'telephone': _phoneensController.text,
                            'adresse': _addressensController.text,
                            'ville': _cityensController.text,
                            'date de naissance': DateFormat('yyyy-MM-dd')
                                .parse(_datenaissanceensController.text),
                            'date d\'embauche': DateFormat('yyyy-MM-dd')
                                .parse(_dateembaucheController.text),
                            'grade': _gradeController.text,
                            'departement': _deptController.text,
                          });
                          Navigator.of(context).pop();
                        } catch (e) {
                          print('Error adding teacher: $e');
                        }
                      }
                    },
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void deleteTeacher(String teacherId) {
    FirebaseFirestore.instance.collection('teachers').doc(teacherId).delete();
  }
}
