import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AcceuilEmp extends StatefulWidget {
  const AcceuilEmp({super.key});

  @override
  State<AcceuilEmp> createState() => _AcceuilEmpState();
}

class _AcceuilEmpState extends State<AcceuilEmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("employé"),
      ),
    );
  }
}
