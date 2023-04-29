import 'package:essai2/afef/screens/Admin_Screen/models/student.dart';
import 'package:essai2/afef/screens/Admin_Screen/showdetailsstudent.dart';
import 'package:essai2/afef/screens/Admin_Screen/showdetailsteacher.dart';
import 'package:essai2/afef/screens/showdetailsemploye.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EmployeListPage extends StatefulWidget {
  const EmployeListPage({super.key});

  @override
  State<EmployeListPage> createState() => _EmployeListPageState();
}

class _EmployeListPageState extends State<EmployeListPage> {
  late List<DocumentSnapshot> _employes;

  @override
  void initState() {
    super.initState();
    _fetchEmploye();
  }

  void _fetchEmploye() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('employes').get();
    setState(() {
      _employes = snapshot.docs;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameempController = TextEditingController();
  final _surnameempController = TextEditingController();
  final _datenaissanceempController = TextEditingController();
  final _emailempController = TextEditingController();
  final _serviceController = TextEditingController();

  final _dateembaucheempController = TextEditingController();
  final _phoneempController = TextEditingController();
  final _addressempController = TextEditingController();
  final _cityempController = TextEditingController();
  @override
  void dispose() {
    _nameempController.dispose();
    _datenaissanceempController.dispose();
    _serviceController.dispose();

    _dateembaucheempController.dispose();
    _surnameempController.dispose();
    _emailempController.dispose();
    _phoneempController.dispose();
    _addressempController.dispose();
    _cityempController.dispose();

    super.dispose();
  }

  void _editEmploye(String employeId) {
    // Récupérer la référence à l'employe à modifier dans Firebase
    final DocumentReference employeRef =
        FirebaseFirestore.instance.collection('employes').doc(employeId);

    // Récupérer les données actuelles de l'employs à partir de Firebase

    employeRef.get().then((DocumentSnapshot employeSnapshot) {
      if (employeSnapshot.exists) {
        final employeData = employeSnapshot.data() as Map<String, dynamic>;

        // Afficher une boîte de dialogue contenant un formulaire pré-rempli avec les données actuelles de l'employes
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final TextEditingController nameempController =
                TextEditingController(text: employeData['nom']);

            final TextEditingController addressempController =
                TextEditingController(text: employeData['adresse']);
            final TextEditingController cityempController =
                TextEditingController(text: employeData['ville']);

            final TextEditingController surnameempController =
                TextEditingController(text: employeData['prenom']);
            final TextEditingController datenaissanceempController =
                TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        employeData['date de naissance'].toDate().toString())));
            final TextEditingController dateembaucheempController =
                TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        employeData['date d\'embauche'].toDate().toString())));

            final TextEditingController serviceController =
                TextEditingController(text: employeData['service']);

            final TextEditingController emailempController =
                TextEditingController(text: employeData['email']);
            final TextEditingController phoneempController =
                TextEditingController(text: employeData['telephone']);

            return AlertDialog(
              title: Text('Modifier l\'employe'),
              content: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameempController,
                        decoration: InputDecoration(labelText: 'Nom'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le nom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: surnameempController,
                        decoration: InputDecoration(labelText: 'Prénom'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le prénom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailempController,
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
                        controller: phoneempController,
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
                        controller: datenaissanceempController,
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
                        controller: serviceController,
                        decoration: InputDecoration(labelText: 'Service'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La Service est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dateembaucheempController,
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
                        controller: addressempController,
                        decoration: InputDecoration(labelText: 'Adresse'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'L\'adresse est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cityempController,
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
                    // Mettre à jour les informations de l'employes dans Firebase
                    employeRef.update({
                      'nom': nameempController.text,
                      'prenom': surnameempController.text,
                      'email': emailempController.text,
                      'telephone': phoneempController.text,
                      'date d\'embauche': Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd')
                              .parse(dateembaucheempController.text)),
                      'date de naissance': Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd')
                              .parse(datenaissanceempController.text)),
                      'service': serviceController.text,
                      'adresse': addressempController.text,
                      'ville': cityempController.text,
                    }).then((value) {
                      print('Employe mis à jour avec succès');
                    }).catchError((error) {
                      print(
                          'Erreur lors de la mise à jour de l\'employe: $error');
                    });

                    _fetchEmploye();

                    // Mettre à jour les informations de l'employes dans l'interface utilisateur
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('employes')
                          .doc(employeId)
                          .update({
                        'nom': nameempController.text,
                        'prenom': surnameempController.text,
                        'email': emailempController.text,
                        'telephone': phoneempController.text,
                        'adresse': addressempController.text,
                        'ville': cityempController.text,
                        'date d\'embauche': Timestamp.fromDate(
                            DateFormat('yyyy-MM-dd')
                                .parse(dateembaucheempController.text)),
                        'date de naissance': Timestamp.fromDate(
                            DateFormat('yyyy-MM-dd')
                                .parse(datenaissanceempController.text)),
                        'service': serviceController.text,
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
          'Liste des employés',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('employes').snapshots(),
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
            return const Text('Aucun employé trouvé.');
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
                                title: Text('Supprimer l\'employé?'),
                                content: Text(
                                    'Voulez-vous vraiment supprimer ce employé ?'),
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
                                      deleteEmploye(document.id);
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
                          _editEmploye(document.id);
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
                              EmployesDetailsPage(employe: data),
                        ));
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
                title: Text('Ajouter un employé'),
                content: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _nameempController,
                          decoration: InputDecoration(labelText: 'Nom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le nom est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _surnameempController,
                          decoration: InputDecoration(labelText: 'Prénom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le prénom est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailempController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'email est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneempController,
                          decoration: InputDecoration(labelText: 'Téléphone'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le téléphone est requis.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _datenaissanceempController,
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
                          controller: _addressempController,
                          decoration: InputDecoration(labelText: 'Adresse'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'L\'adresse est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _serviceController,
                          decoration: InputDecoration(labelText: 'service'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Le grade est requise.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _dateembaucheempController,
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
                          controller: _cityempController,
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
                              .collection('employes')
                              .add({
                            'nom': _nameempController.text,
                            'prenom': _surnameempController.text,
                            'email': _emailempController.text,
                            'telephone': _phoneempController.text,
                            'adresse': _addressempController.text,
                            'ville': _cityempController.text,
                            'date de naissance': DateFormat('yyyy-MM-dd')
                                .parse(_datenaissanceempController.text),
                            'date d\'embauche': DateFormat('yyyy-MM-dd')
                                .parse(_dateembaucheempController.text),
                            'service': _serviceController.text,
                          });
                          Navigator.of(context).pop();
                        } catch (e) {
                          print('Error adding employe: $e');
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

  void deleteEmploye(String employeId) {
    FirebaseFirestore.instance.collection('employes').doc(employeId).delete();
  }

  void _showDeleteEmployeDialog(DocumentSnapshot employe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete employe'),
          content: Text('Are you sure you want to delete this employe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                await employe.reference.delete();
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
