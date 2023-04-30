import 'package:flutter/material.dart';

import 'CalendrierExamen/Semesters/Semester1/listeGroupCalendrier.dart';
import 'GestionSalle/RepartitionSalle.dart';

import 'buttonsF/add_calendrier.dart';
import 'buttonsF/awelpageBleshAdd.dart';
import 'buttonsF/awlpage.dart';
import 'essais/absence.dart';
import 'essais/test.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('Accueil Administrateur'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminExamCalendarPage1()));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.timeline),
                            const SizedBox(height: 10.0),
                            Text(
                              'test',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.cyan[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormationPage()));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.school),
                            const SizedBox(height: 10.0),
                            Text(
                              'Gérer les formations',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.cyan[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.school_outlined),
                            const SizedBox(height: 10.0),
                            Text(
                              'Gérer les notes des étudiants',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.cyan[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Naviguer vers la page de gestion des employés
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.access_time),
                            const SizedBox(height: 10.0),
                            Text(
                              'Gérer les emplois du temps',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.cyan[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendPage()));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.class_outlined),
                            SizedBox(height: 10.0),
                            Text(
                              'Calendrier de examens',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 22, 136, 149)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendancePage(studentId: '',)));
                        
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.access_time),
                            SizedBox(height: 10.0),
                            Text(
                              'Gérer les absences',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 18, 153, 170)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RepertitionSalle()));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.class_outlined),
                            const SizedBox(height: 10.0),
                            Text(
                              'Gérer les réparations de salles',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.cyan[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.access_time),
                            SizedBox(height: 10.0),
                            Text(
                              'Gérer les paiements',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 24, 125, 138)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
