import 'package:essai2/afef/screens/Admin_Screen/models/student.dart';
import 'package:essai2/afef/screens/Admin_Screen/showdetailsstudent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late List<DocumentSnapshot> _students;

  @override
  void initState() {
    super.initState();
    _fetchStudents();

   
  }
/* cette methode utilser pour récup les donnée appartir de firebase et pour l'affiche dans UI 
-elle récup les document de la collection students 
puis stock les document récupérer danns une variable _student : les donné sous forme de liste de type QueryDocumentSnapshot*/
  void _fetchStudents() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('students').get();
    setState(() {
      _students = snapshot.docs;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _datenaissanceController = TextEditingController();
  final _emailController = TextEditingController();
  final _filiereController = TextEditingController();
  final _niveauxController = TextEditingController();
  final _dateinscriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  
/* Cette méthode est appelée pour chaque contrôleur de saisie de texte créé dans le widget
, afin de libérer les ressources de chaque contrôleur.
 Cela permet d'éviter les fuites de mémoire dans l'application et d'optimiser les performances.*/
  @override
  void dispose() {
    _nameController.dispose();
    _datenaissanceController.dispose();
    _filiereController.dispose();
    _niveauxController.dispose();
    _dateinscriptionController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _editStudent(String studentId) {
    // Récupérer la référence à l'étudiant à modifier dans Firebase
    final DocumentReference studentRef =
        FirebaseFirestore.instance.collection('students').doc(studentId);

    // Récupérer les données actuelles de l'étudiant à partir de Firebase
    studentRef.get().then((DocumentSnapshot studentSnapshot) {
      if (studentSnapshot.exists) {
        // Afficher une boîte de dialogue contenant un formulaire pré-rempli avec les données actuelles de l'étudiant
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final TextEditingController nameController =
                TextEditingController(text: studentSnapshot['nom']);
            final TextEditingController addressController =
                TextEditingController(text: studentSnapshot['adresse']);
            final TextEditingController cityController =
                TextEditingController(text: studentSnapshot['ville']);
            final TextEditingController stateController =
                TextEditingController(text: studentSnapshot['etat']);
            final TextEditingController surnameController =
                TextEditingController(text: studentSnapshot['prenom']);
            final TextEditingController datenaissanceController =
                TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        studentSnapshot['date de naissance']
                            .toDate()
                            .toString())));
            final TextEditingController dateinscriptionController =
                TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        studentSnapshot['date d\'inscription']
                            .toDate()
                            .toString())));

            final TextEditingController filiereController =
                TextEditingController(text: studentSnapshot['filiere']);
            final TextEditingController niveauController =
                TextEditingController(text: studentSnapshot['niveau']);

            final TextEditingController emailController =
                TextEditingController(text: studentSnapshot['email']);
            final TextEditingController phoneController =
                TextEditingController(text: studentSnapshot['telephone']);

            return AlertDialog(
              title: Text('Modifier l\'étudiant'),
              content: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Nom'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le nom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: surnameController,
                        decoration: InputDecoration(labelText: 'Prénom'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le prénom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
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
                        controller: phoneController,
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
                        controller: datenaissanceController,
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
                        controller: filiereController,
                        decoration: InputDecoration(labelText: 'Filiére'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La filiére est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: niveauController,
                        decoration: InputDecoration(labelText: 'Niveau'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le niveau est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dateinscriptionController,
                        decoration:
                            InputDecoration(labelText: 'Date d\'inscription'),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La date de naissance est requise.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(labelText: 'Adresse'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'L\'adresse est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: stateController,
                        decoration: InputDecoration(labelText: 'Etat'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'L\'etat est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cityController,
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
                    // Mettre à jour les informations de l'étudiant dans Firebase
                    studentRef.update({
                      'nom': nameController.text,
                      'prenom': surnameController.text,
                      'email': emailController.text,
                      'telephone': phoneController.text,
                      'date d\'inscription': Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd')
                              .parse(dateinscriptionController.text)),
                      'date de naissance': Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd')
                              .parse(datenaissanceController.text)),
                      'filiere': filiereController.text,
                      'niveau': niveauController.text,
                      'adresse': addressController.text,
                      'ville': cityController.text,
                      'etat': stateController.text,
                    }).then((value) {
                      print('Etudiant mis à jour avec succès');
                    }).catchError((error) {
                      print(
                          'Erreur lors de la mise à jour de l\'étudiant: $error');
                    });

                    _fetchStudents();

                    // Mettre à jour les informations de l'étudiant dans l'interface utilisateur
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('students')
                          .doc(studentId)
                          .update({
                        'nom': nameController.text,
                        'prenom': surnameController.text,
                        'email': emailController.text,
                        'telephone': phoneController.text,
                        'adresse': addressController.text,
                        'ville': cityController.text,
                        'etat': stateController.text,
                        'date d\'inscription': Timestamp.fromDate(
                            DateFormat('yyyy-MM-dd')
                                .parse(dateinscriptionController.text)),
                        'date de naissance': Timestamp.fromDate(
                            DateFormat('yyyy-MM-dd')
                                .parse(datenaissanceController.text)),
                        'filiere': filiereController.text,
                        'niveau': niveauController.text,
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
          'Liste des étudiants',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
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
            return const Text('Aucun étudiant trouvé.');
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
                                title: Text('Supprimer l\'étudiant ?'),
                                content: Text(
                                    'Voulez-vous vraiment supprimer cet étudiant ?'),
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
                                      deleteStudent(document.id);
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
                          _editStudent(document.id);
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
                              StudentsDetailsPage(student: data)),
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
                title: Text('Ajouter un étudiant'),
                content: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Nom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le nom est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _surnameController,
                          decoration: InputDecoration(labelText: 'Prénom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le prénom est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'email est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(labelText: 'Téléphone'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le téléphone est requis.';
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
                        TextFormField(
                          controller: _datenaissanceController,
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
                          controller: _addressController,
                          decoration: InputDecoration(labelText: 'Adresse'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'adresse est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _filiereController,
                          decoration: InputDecoration(labelText: 'Filiére'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le filiére est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _niveauxController,
                          decoration: InputDecoration(labelText: 'Niveau'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le niveau est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _dateinscriptionController,
                          decoration:
                              InputDecoration(labelText: 'Date d\'inscription'),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'La date d\'inscription  est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(labelText: 'Ville'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'La ville est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _stateController,
                          decoration: InputDecoration(labelText: 'État'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'état est requis.';
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
                              .collection('students')
                              .add({
                            'nom': _nameController.text,
                            'prenom': _surnameController.text,
                            'email': _emailController.text,
                            'telephone': _phoneController.text,
                            'adresse': _addressController.text,
                            'ville': _cityController.text,
                            'etat': _stateController.text,
                            'date de naissance': DateFormat('yyyy-MM-dd')
                                .parse(_datenaissanceController.text),
                            'date d\'inscription': DateFormat('yyyy-MM-dd')
                                .parse(_dateinscriptionController.text),
                            'filiere': _filiereController.text,
                            'niveau': _niveauxController.text,
                          });
                          Navigator.of(context).pop();
                        } catch (e) {
                          print('Error adding student: $e');
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

  void deleteStudent(String studentId) {
    FirebaseFirestore.instance.collection('students').doc(studentId).delete();
  }

  void _showDeleteStudentDialog(DocumentSnapshot student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Student'),
          content: Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                await student.reference.delete();
                Navigator.of(context).pop();
              },
              child: Text('supprimer'),
            ),
          ],
        );
      },
    );
  }
}

/*class StudentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> student;

  StudentDetailsPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${student['nom']} ${student['prenom']}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${student['email']}'),
              SizedBox(height: 8.0),
              Text('Téléphone: ${student['telephone']}'),
              SizedBox(height: 8.0),
              Text(
                  'Adresse: ${student['adresse']}, ${student['ville']}, ${student['etat']}'),
            ],
          ),
        ),
      ),
    );
  }
}*/







/*


  void _showDeleteStudentDialog(DocumentSnapshot student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Student'),
          content: Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await student.reference.delete();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
*/
