import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AcceuilEtudiant extends StatefulWidget {
  const AcceuilEtudiant({super.key});

  @override
  State<AcceuilEtudiant> createState() => _AcceuilEtudiantState();
}

class _AcceuilEtudiantState extends State<AcceuilEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("etudiant "),
      ),
    );
  }
}
