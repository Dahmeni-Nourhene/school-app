/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String nom;
  final String prenom;
  final String filiere;
  final String groupe;
  final String note;

  Note(this.id, this.nom, this.prenom, this.filiere, this.groupe, this.note);
}

class GestionNote extends StatefulWidget {
  @override
  _GestionNoteState createState() => _GestionNoteState();
}

class _GestionNoteState extends State<GestionNote> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _filiereController = TextEditingController();
  final TextEditingController _groupeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<Note> notes = [];

  CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote() {
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String filiere = _filiereController.text;
    String groupe = _groupeController.text;
    String note = _noteController.text;

    return notesCollection
        .add({
          'nom': nom,
          'prenom': prenom,
          'filiere': filiere,
          'groupe': groupe,
          'note': note
        })
        .then((value) => print("Note ajoutée avec succès"))
        .catchError(
            (error) => print("Erreur lors de l'ajout de la note : $error"));
  }

  Future<void> updateNote(Note note) {
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String filiere = _filiereController.text;
    String groupe = _groupeController.text;
    String note = _noteController.text;

    return notesCollection
        .doc(note.id)
        .update({
          'nom': nom,
          'prenom': prenom,
          'filiere': filiere,
          'groupe': groupe,
          'note': note
        })
        .then((value) => print("Note modifiée avec succès"))
        .catchError((error) =>
            print("Erreur lors de la modification de la note : $error"));
  }

  Future<void> deleteNote(Note note) {
    return notesCollection
        .doc(note.id)
        .delete()
        .then((value) => print("Note supprimée avec succès"))
        .catchError((error) =>
            print("Erreur lors de la suppression de la note : $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des notes"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nomController,
              decoration: InputDecoration(hintText: 'Nom'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _prenomController,
              decoration: InputDecoration(hintText: 'Prénom'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _filiereController,
              decoration: InputDecoration(hintText: 'Filière'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _groupeController,
              decoration: InputDecoration(hintText: 'Groupe'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _noteController,
              decoration: InputDecoration(hintText: 'Note'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await addNote();
                  setState(() {
                    _nomController.clear();
                    _prenomController.clear();
                    _filiereController.clear();
                    _groupeController.clear();
                    _noteController.clear();
                  });
                },
                child: Text("Ajouter"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await updateNote(notes.last);
                  setState(() {
                    _nomController.clear();
                    _prenomController.clear();
                    _filiereController.clear();
                    _groupeController.clear();
                    _noteController.clear();
                  });
                },
                child: Text("Modifier"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await deleteNote(notes.last);
                  setState(() {
                    _nomController.clear();
                    _prenomController.clear();
                    _filiereController.clear();
                    _groupeController.clear();
                    _noteController.clear();
                  });
                },
                child: Text("Supprimer"),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: notesCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Erreur de chargement des notes');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                notes = snapshot.data!.docs
                    .map((doc) => Note(
                          doc.id,
                          doc['nom'],
                          doc['prenom'],
                          doc['filiere'],
                          doc['groupe'],
                          doc['note'],
                        ))
                    .toList();

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${notes[index].nom} ${notes[index].prenom}'),
                      subtitle: Text(
                          '${notes[index].filiere} ${notes[index].groupe}'),
                      trailing: Text(notes[index].note),
                      onTap: () {
                        setState(() {
                          _nomController.text = notes[index].nom;
                          _prenomController.text = notes[index].prenom;
                          _filiereController.text = notes[index].filiere;
                          _groupeController.text = notes[index].groupe;
                          _noteController.text = notes[index].note;
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/