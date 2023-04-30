import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AcceuilEns extends StatefulWidget {
  const AcceuilEns({super.key});

  @override
  State<AcceuilEns> createState() => _AcceuilEnsState();
}

class _AcceuilEnsState extends State<AcceuilEns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("enseignant"),
      ),
    );
  }
}
