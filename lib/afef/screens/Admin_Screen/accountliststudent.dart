import 'package:essai2/afef/screens/Admin_Screen/gestionspecialite.dart';
import 'package:essai2/afef/screens/Admin_Screen/listecompte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/afef/screens/Admin_Screen/addaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AccountStudentList extends StatefulWidget {
  const AccountStudentList({super.key});

  @override
  State<AccountStudentList> createState() => _AccountStudentListState();
}

class _AccountStudentListState extends State<AccountStudentList> {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
