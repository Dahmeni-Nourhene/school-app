import 'package:essai2/essais/test.dart';
import 'package:essai2/buttonsF/calender_firebase.dart';
import 'package:essai2/screen/read_examen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AdminHomePage.dart';

import 'CalendrierExamen/Semesters/Semester1/Mastere/final2.dart';

import 'afef/screens/Admin_Screen/firstpageadmin.dart';
import 'buttonsF/add_calendrier.dart';
import 'essais/essai.dart';
import 'firebase_options.dart';
import 'GestionNote/gestion_note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      home: AdminHomePage(),
      theme: ThemeData(primaryColor: Colors.cyan[700]),
    );
  }
}
