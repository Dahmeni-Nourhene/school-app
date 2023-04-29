import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String? _selectedRole;
  String? _selectedSpeciality;
  String? _selectedLevel;
  String? _selectedClass;

  List<String> _roles = ["Etudiant", "Enseignant"];
  List<String> _specialities = [];
  List<String> _levels = [];
  List<String> _classes = [];

  Future<void> _loadSpecialities() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('specialities_licence').get();
    List<String> specialities = [];
    snapshot.docs.forEach((doc) {
      specialities.add(doc.id);
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
      levels.add(doc.id);
    });
    setState(() {
      _levels = levels;
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
      classes.add(doc.id);
    });
    setState(() {
      _classes = classes;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSpecialities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un utilisateur"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rôle :"),
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (value) {
                setState((){
_selectedRole = value!;
if (_selectedRole == "Etudiant") {
_loadSpecialities();
}
});
},
items: _roles.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
);
}).toList(),
),
SizedBox(height: 16.0),
if (_selectedRole == "Etudiant" && _specialities.isNotEmpty)
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Spécialité :"),
DropdownButton<String>(
value: _selectedSpeciality,
onChanged: (value) {
setState(() {
_selectedSpeciality = value!;
_loadLevels();
});
},
items: _specialities.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
);
}).toList(),
),
SizedBox(height: 16.0),
if (_levels.isNotEmpty)
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Niveau :"),
DropdownButton<String>(
value: _selectedLevel,
onChanged: (value) {
setState(() {
_selectedLevel = value!;
_loadClasses();
});
},
items: _levels.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
);
}).toList(),
),
SizedBox(height: 16.0),
if (_classes.isNotEmpty)
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Classe :"),
DropdownButton<String>(
value: _selectedClass,
onChanged: (value) {
setState(() {
_selectedClass = value!;
});
},
items: _classes.map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Text(value),
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
),
);
}
}
