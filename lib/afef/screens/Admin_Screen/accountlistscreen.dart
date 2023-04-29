import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/afef/screens/Admin_Screen/addaccount.dart';
import 'package:flutter/material.dart';

class AccountListScreen extends StatefulWidget {
  final String role;
  const AccountListScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  late List<DocumentSnapshot> _users;

  @override
  void initState() {
    super.initState();
    _fetchusers();
  }

/* cette methode utilser pour récup les donnée appartir de firebase et pour l'affiche dans UI 
-elle récup les document de la collection students 
puis stock les document récupérer danns une variable _student : les donné sous forme de liste de type QueryDocumentSnapshot*/
  void _fetchusers() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _users = snapshot.docs;
    });
  }

  void _editUser(String userId) {
    // Récupérer la référence à l'étudiant à modifier dans Firebase
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Récupérer les données actuelles de l'étudiant à partir de Firebase
    userRef.get().then((DocumentSnapshot userSnapshot) {
      if (userSnapshot.exists) {
        // Afficher une boîte de dialogue contenant un formulaire pré-rempli avec les données actuelles de l'étudiant
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final TextEditingController nameuserController =
                TextEditingController(text: userSnapshot['name']);
            final TextEditingController emailuserController =
                TextEditingController(text: userSnapshot['email']);

            return AlertDialog(
              title: const Text('Modifier l\'utilisateur'),
              content: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameuserController,
                        decoration: const InputDecoration(labelText: 'Nom Complet'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le nom est requis.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailuserController,
                        decoration: const InputDecoration(labelText: 'email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Le email est requis.';
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
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('Enregistrer'),
                  onPressed: () {
                    // Mettre à jour les informations de l'étudiant dans Firebase
                    userRef.update({
                      'name': nameuserController.text,
                      'email': emailuserController.text,
                    }).then((value) {
                      print('user mis à jour avec succès');
                    }).catchError((error) {
                      print(
                          'Erreur lors de la mise à jour de l\'étudiant: $error');
                    });

                    _fetchusers();

                    // Mettre à jour les informations de l'étudiant dans l'interface utilisateur
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .update({
                        'name': nameuserController.text,
                        'email': emailuserController.text,
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
        title: Text('Comptes des  ${widget.role} '),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: widget.role)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  trailing: IconButton(
                    color: Colors.cyan[700],
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      _editUser(document.id);
                    },
                  ),
                  title: Text(
                    data['name'] + ' ' + data['email'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {},
                ),
              );
            }).toList(),
          );

          /*return ListView.builder(
            
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(documents[index]['name']),
                  subtitle: Text(documents[index]['email']),
                  trailing: IconButton(
                    color: Colors.cyan[700],
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      _editUser(documents.index);
                    },
                  ),
                  onTap: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployesDetailsPage(employe: data),
                        ));*/
                  },
                ),
              );
            },
          );*/
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()));
        },
        backgroundColor: Colors.cyan[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class StudentsListScreen extends StatelessWidget {
  final String speciality;

  const StudentsListScreen({Key? key, required this.speciality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Liste des étudiants de $speciality'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('speciality', isEqualTo: speciality)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return const Center(
                child: Text(
                    'Aucun étudiant dans cette spécialité pour le moment.'));
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(documents[index]['name']),
                  subtitle: Text(documents[index]['email']),
                  onTap: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployesDetailsPage(employe: data),
                        ));*/
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()));
        },
        backgroundColor: Colors.cyan[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
