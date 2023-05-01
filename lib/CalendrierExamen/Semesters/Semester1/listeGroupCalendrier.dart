// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'Mastere/MastereCalendrier.dart';
// import 'Licence/licencesCalendrier.dart';

// class listeGroupCalendrier extends StatefulWidget {
//    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
   
//   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
//   @override
//   _listeGroupCalendrierState createState() => _listeGroupCalendrierState();
// }

// class _listeGroupCalendrierState extends State<listeGroupCalendrier> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.cyan[700],
//           title: Text(
//             'Calendrier de examens',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: Container(
//           margin: EdgeInsets.only(top: 35, left: 20, right: 20),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 80,
//                 width: 400,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(11.0),
//                         ),
//                         minimumSize: const Size(60.0, 60.0),
//                         backgroundColor: Colors.cyan[50],
//                         elevation: 10.0,
//                         textStyle: const TextStyle(
//                             color: Color.fromARGB(255, 16, 105, 222))),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LicencesCalendrier()));
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Icon(
//                           Icons.person,
//                           color: Colors.cyan[700],
//                         ),
//                         SizedBox(width: 30),
//                         Text(
//                           "Licences",
//                           style: TextStyle(
//                               fontSize: 20.0, color: Colors.cyan[700]),
//                         ),
//                       ],
//                     )),
//               ),
//               SizedBox(
//                 height: 35,
//               ),
//               SizedBox(
//                 height: 80,
//                 width: 400,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(11.0),
//                         ),
//                         minimumSize: const Size(60.0, 60.0),
//                         backgroundColor: Colors.cyan[50],
//                         elevation: 10.0,
//                         textStyle: const TextStyle(
//                             color: Color.fromARGB(255, 16, 105, 222))),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MastereCalendrier()));
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Icon(
//                           Icons.work,
//                           color: Colors.cyan[700],
//                         ),
//                         SizedBox(width: 30),
//                         Text(
//                           "Mastéres",
//                           style: TextStyle(
//                               fontSize: 20.0, color: Colors.cyan[700]),
//                         ),
//                       ],
//                     )),
//               )
//             ],
//           ),
//         ));
//   }
// }
