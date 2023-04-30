import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../AdminHomePage.dart';


class FormationPage extends StatefulWidget {
  @override
  _FormationPageState createState() => _FormationPageState();
}

class _FormationPageState extends State<FormationPage> {
  CollectionReference formations =
      FirebaseFirestore.instance.collection('diplomes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdminHomePage()));
          },
        ),
        backgroundColor: Colors.cyan[700],
        title: Text('Formations'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: formations.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> formationsData = snapshot.data!.docs;

          List<Specialite> formation = formationsData
              .map((doc) => Specialite.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: formation.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(
                    formation[index].nom,
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialitesPage(
                            formation[index].nom), /////on va changer
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AjouterFormationDialog(
              onValider: (nomFormation) {
                formations.add({
                  'nom': nomFormation,
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

//////////////////
class AjouterFormationDialog extends StatefulWidget {
  final Function(String) onValider;

  AjouterFormationDialog({required this.onValider});

  @override
  _AjouterFormationDialogState createState() => _AjouterFormationDialogState();
}

class _AjouterFormationDialogState extends State<AjouterFormationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ajouter un Diplôme'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nomController,
          decoration: InputDecoration(
            labelText: 'Nom du diplômr',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un nom de diplômr';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Valider'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onValider(_nomController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

//////////////

class SpecialitesPage extends StatefulWidget {
  final String idFormation;

  SpecialitesPage(this.idFormation);

  @override
  _SpecialitesPageState createState() => _SpecialitesPageState();
}

class _SpecialitesPageState extends State<SpecialitesPage> {
  CollectionReference specialites =
      FirebaseFirestore.instance.collection('specialites');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('specialites'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: specialites
            .where('idFormation', isEqualTo: widget.idFormation)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> specialitesData = snapshot.data!.docs;

          List<Niveau> specialites =
              specialitesData.map((doc) => Niveau.fromFirestore(doc)).toList();
          List<QueryDocumentSnapshot> FormationsData = snapshot.data!.docs;

          List<Specialite> formations =
              FormationsData.map((doc) => Specialite.fromFirestore(doc))
                  .toList();

          return ListView.builder(
            itemCount: specialites.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(specialites[index].nom),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NiveauxPage(
                            specialites[index].nom, widget.idFormation),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AjouterSpecialiteDialog(
              onValider: (nomSpecialites) {
                specialites.add({
                  'nom': nomSpecialites,
                  'idFormation': widget.idFormation,
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AjouterSpecialiteDialog extends StatefulWidget {
  final Function(String) onValider;

  AjouterSpecialiteDialog({required this.onValider});

  @override
  _AjouterSpecialiteDialogState createState() =>
      _AjouterSpecialiteDialogState();
}

class _AjouterSpecialiteDialogState extends State<AjouterSpecialiteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ajouter une spécialité'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nomController,
          decoration: InputDecoration(
            labelText: 'Nom de la spécialité',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un nom de spécialité';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Valider'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onValider(_nomController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class NiveauxPage extends StatefulWidget {
  final String idFormation;
  final String idSpecialite;

  NiveauxPage(this.idSpecialite, this.idFormation);

  @override
  _NiveauxPageState createState() => _NiveauxPageState();
}

class _NiveauxPageState extends State<NiveauxPage> {
  CollectionReference niveaux =
      FirebaseFirestore.instance.collection('niveaux');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Niveaux'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: niveaux
            .where('idFormation', isEqualTo: widget.idFormation)
            .where('idSpecialite', isEqualTo: widget.idSpecialite)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> niveauxData = snapshot.data!.docs;

          List<Niveau> niveaux =
              niveauxData.map((doc) => Niveau.fromFirestore(doc)).toList();
          List<QueryDocumentSnapshot> specialitesData = snapshot.data!.docs;

          List<Specialite> specialites = specialitesData
              .map((doc) => Specialite.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: niveaux.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(niveaux[index].nom),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassesPage(niveaux[index].nom,
                            widget.idSpecialite, widget.idFormation),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AjouterNiveauDialog(
              onValider: (nomNiveau) {
                niveaux.add({
                  'nom': nomNiveau,
                  'idFormation': widget.idFormation,
                  'idSpecialite': widget.idSpecialite,
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ClassesPage extends StatefulWidget {
  final String idFormation;
  final String idNiveau;

  final String idSpecialite;

  ClassesPage(this.idNiveau, this.idSpecialite, this.idFormation);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  CollectionReference classes =
      FirebaseFirestore.instance.collection('classes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Classes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: classes
            .where('idFormation', isEqualTo: widget.idFormation)
            .where('idSpecialite', isEqualTo: widget.idSpecialite)
            .where('idNiveau', isEqualTo: widget.idNiveau)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> classesData = snapshot.data!.docs;
          List<Classe> classes =
              classesData.map((doc) => Classe.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(classes[index].nom),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentsListScreen(
                          speciality: widget.idSpecialite,
                          level: widget.idNiveau,
                          formation: widget.idFormation,
                          classe: classes[index].nom,
                        ),
                      ),
                    );*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupePage(
                            widget.idNiveau,
                            widget.idSpecialite,
                            widget.idFormation,
                            classes[index].nom),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AjouterClasseDialog(
              onValider: (nomClasse) {
                classes.add({
                  'nom': nomClasse,
                  'idFormation': widget.idFormation,
                  'idSpecialite': widget.idSpecialite,
                  'idNiveau': widget.idNiveau,
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Specialite {
  final String id;
  final String nom;
  final String idFormation;

  Specialite({
    required this.id,
    required this.nom,
    required this.idFormation,
  });

  factory Specialite.fromFirestore(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Specialite(
      id: doc.id,
      nom: data['nom'] ?? '',
      idFormation: data['idFormation'] ?? '',

      //idSpecialite: data['idSpecialite'] ?? '',
    );
  }
}

class Niveau {
  final String id;
  final String nom;
  final String idFormation;
  final String idSpecialite;

  Niveau({
    required this.id,
    required this.nom,
    required this.idFormation,
    required this.idSpecialite,
  });

  factory Niveau.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Niveau(
      id: doc.id,
      nom: data['nom'] ?? '',
      idFormation: data['idFormation'] ?? '',
      idSpecialite: data['idSpecialite'] ?? '',
    );
  }
}

class Classe {
  final String id;
  final String nom;
  final String idFormation;
  final String idSpecialite;
  final String idNiveau;

  Classe({
    required this.id,
    required this.nom,
    required this.idFormation,
    required this.idSpecialite,
    required this.idNiveau,
  });

  factory Classe.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Classe(
      id: doc.id,
      nom: data['nom'] ?? '',
      idFormation: data['idFormation'] ?? '',
      idSpecialite: data['idSpecialite'] ?? '',
      idNiveau: data['idNiveau'] ?? '',
    );
  }
}

class AjouterNiveauDialog extends StatefulWidget {
  final Function(String) onValider;

  AjouterNiveauDialog({required this.onValider});

  @override
  _AjouterNiveauDialogState createState() => _AjouterNiveauDialogState();
}

class _AjouterNiveauDialogState extends State<AjouterNiveauDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ajouter un niveau'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nomController,
          decoration: InputDecoration(
            labelText: 'Nom du niveau',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un nom de niveau';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Valider'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onValider(_nomController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class AjouterClasseDialog extends StatefulWidget {
  final Function(String) onValider;

  const AjouterClasseDialog({Key? key, required this.onValider})
      : super(key: key);

  @override
  _AjouterClasseDialogState createState() => _AjouterClasseDialogState();
}

class _AjouterClasseDialogState extends State<AjouterClasseDialog> {
  final TextEditingController _nomClasseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ajouter une classe"),
      content: TextField(
        controller: _nomClasseController,
        decoration: InputDecoration(
          hintText: "Nom de la classe",
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Annuler"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text("Valider"),
          onPressed: () {
            widget.onValider(_nomClasseController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class AjouterGroupeDialog extends StatefulWidget {
  final Function(String) onValider;

  const AjouterGroupeDialog({Key? key, required this.onValider})
      : super(key: key);

  @override
  _AjouterGroupeDialogState createState() => _AjouterGroupeDialogState();
}

class _AjouterGroupeDialogState extends State<AjouterGroupeDialog> {
  final TextEditingController _nomGroupeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ajouter un groupe"),
      content: TextField(
        controller: _nomGroupeController,
        decoration: InputDecoration(
          hintText: "Nom de groupe",
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Annuler"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text("Valider"),
          onPressed: () {
            widget.onValider(_nomGroupeController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class GroupePage extends StatefulWidget {
  final String idFormation;
  final String idNiveau;

  final String idSpecialite;
  final String idClasse;

  GroupePage(this.idNiveau, this.idSpecialite, this.idFormation, this.idClasse);

  @override
  _GroupePageState createState() => _GroupePageState();
}

class _GroupePageState extends State<GroupePage> {
  CollectionReference groupes =
      FirebaseFirestore.instance.collection('groupes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Classes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: groupes
            .where('idFormation', isEqualTo: widget.idFormation)
            .where('idSpecialite', isEqualTo: widget.idSpecialite)
            .where('idNiveau', isEqualTo: widget.idNiveau)
            .where('idClasse', isEqualTo: widget.idClasse)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> groupesData = snapshot.data!.docs;
          List<Groupe> groupes =
              groupesData.map((doc) => Groupe.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: groupes.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(groupes[index].nom),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentsListScreen(
                          speciality: widget.idSpecialite,
                          level: widget.idNiveau,
                          formation: widget.idFormation,
                          classe: groupes[index].nom,
                        ),
                      ),
                    );*/
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AjouterGroupeDialog(
              onValider: (nomClasse) {
                groupes.add({
                  'nom': nomClasse,
                  'idFormation': widget.idFormation,
                  'idSpecialite': widget.idSpecialite,
                  'idNiveau': widget.idNiveau,
                  'idClasse': widget.idClasse,
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Groupe {
  final String id;
  final String nom;
  final String idFormation;
  final String idSpecialite;
  final String idNiveau;
  final String idClasse;

  Groupe({
    required this.id,
    required this.nom,
    required this.idFormation,
    required this.idSpecialite,
    required this.idNiveau,
    required this.idClasse,
  });

  factory Groupe.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Groupe(
      id: doc.id,
      nom: data['nom'] ?? '',
      idFormation: data['idFormation'] ?? '',
      idSpecialite: data['idSpecialite'] ?? '',
      idNiveau: data['idNiveau'] ?? '',
      idClasse: data['idClasse'] ?? '',
    );
  }
}
