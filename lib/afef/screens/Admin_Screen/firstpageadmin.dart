// import 'package:essai2/afef/screens/Admin_Screen/Addspecialities.dart';
// import 'package:essai2/afef/screens/Admin_Screen/addaccount.dart';
// import 'package:essai2/afef/screens/Admin_Screen/calendrier_examens.dart';

// import 'package:essai2/afef/screens/Admin_Screen/emploidetemps/tableemploipage.dart';
// import 'package:essai2/afef/screens/Admin_Screen/formation_speciality_niveau_classe/listof_formation.dart';
// import 'package:essai2/afef/screens/Admin_Screen/germembre.dart';
// import 'package:essai2/afef/screens/Admin_Screen/gestionformation.dart';
// import 'package:essai2/afef/screens/Admin_Screen/gestionspecialite.dart';
// import 'package:essai2/afef/screens/Admin_Screen/Addspecialities.dart';

// import 'package:essai2/afef/screens/Admin_Screen/listecompte.dart';
// import 'package:essai2/afef/screens/Admin_Screen/models/specialities.dart';

// import 'package:essai2/afef/screens/Loginpage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../CalendrierExamen/Semesters/Semester1/listeGroupCalendrier.dart';
// import '../../../GestionSalle/RepartitionSalle.dart';
// import 'finalspeciality.dart';

// class AcceuilAdmin extends StatefulWidget {
//   const AcceuilAdmin({super.key});

//   @override
//   State<AcceuilAdmin> createState() => _AcceuilAdminState();
// }

// class _AcceuilAdminState extends State<AcceuilAdmin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.cyan[700],
//         title: Text('Accueil'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               child: Text('Menu'),
//               decoration: BoxDecoration(
//                 color: Colors.cyan.shade700,
//               ),
//             ),
//             SizedBox(
//               height: 1,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Gestion des comptes'),
//               onTap: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => AccountListPage()));
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Liste  des membres'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => ListeMembre()));
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Gestion des absences'),
//               onTap: () {
//                 // Mettre à jour la page en fonction de l'option de menu sélectionnée
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               title: Text('Gestion des notes'),
//               tileColor: Colors.cyan[50],
//               onTap: () {
//                 // Mettre à jour la page en fonction de l'option de menu sélectionnée
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//                 title: Text('Gestion des salles'),
//                 tileColor: Colors.cyan[50],
//                 onTap: () {}),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Gestion de l\'emploi du temps'),
//               onTap: () {
//                 // Mettre à jour la page en fonction de l'option de menu sélectionnée
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Gestion Calendrier des examens'),
//               onTap: () {
//                 /*Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ExamSchedulePage()));*/
//                 // Mettre à jour la page en fonction de l'option de menu sélectionnée
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Gestion des classes '),
//               onTap: () {
//                 // Mettre à jour la page en fonction de l'option de menu sélectionnée
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Gestion des paiements'),
//               onTap: () {
//                 // Mettre à jour la page en fonction de l'option de menu sélectionnée
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             ListTile(
//               tileColor: Colors.cyan[50],
//               title: Text('Déconnexion'),
//               onTap: () {
//                 signOut();
//               },
//             ),
//           ],
//         ),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         padding: EdgeInsets.all(16.0),
//         childAspectRatio: 1.0,
//         mainAxisSpacing: 16.0,
//         crossAxisSpacing: 16.0,
//         children: <Widget>[
//           _buildCard('Gestion des comptes', Icons.account_circle, () {
//             // Code pour naviguer vers l'interface de gestion des comptes
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => AccountListPage()));
//           }),
//           _buildCard('Liste des membres', Icons.group, () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ListeMembre()),
//             );
//           }),
//           _buildCard('Gestion des notes', Icons.note, () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MainFormationScreen()),
//             );
//             // Code pour naviguer vers l'interface de gestion des notes
//           }),
//           _buildCard('Gestion des salles', Icons.location_city, () {
//              Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => RepertitionSalle()),
//             );
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => listeFormation()),
//             );
//             // Code pour naviguer vers l'interface de gestion des salles
//           }),
//           _buildCard('Gestion emploi de temps', Icons.schedule, () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ScheduleListScreen(
//                         universityId: widget.toString(),
//                         specialtyId: widget.toString(),
//                         classId: widget.toString(),
//                         groupId: widget.toString(),
//                         semesterId: widget.toString(),
//                         weekId: widget.toString())));
//             // Code pour naviguer vers l'interface de gestion de l'emploi du temps
//           }),
//           _buildCard('Gestion de paiement', Icons.payment, () {
//             // Code pour naviguer vers l'interface de gestion des paiements
//           }),
//           _buildCard('Gestion de spécialité', Icons.payment, () {
//             /*Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AddSpecialityScreen()),
//             );*/
//           }),
//           _buildCard('Gestion calendrier Examens', Icons.assignment, () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => listeGroupCalendrier()));
//             // Code pour naviguer vers l'interface de gestion des résultats
//           }),
//           _buildCard('Gestion des absence', Icons.assignment, () {
//             // Code pour naviguer vers l'interface de gestion des résultats
//           }),
//           _buildCard('Gestion des classes', Icons.assignment, () {
//             // Code pour naviguer vers l'interface de gestion des résultats
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildCard(String title, IconData icon, VoidCallback onTap) {
//     return Card(
//       color: Colors.cyan[700],
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               icon,
//               size: 48.0,
//               color: Colors.white,
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               title,
//               style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginPage()),
//     );
//   }
// }
