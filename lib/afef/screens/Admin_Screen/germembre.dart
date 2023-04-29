import 'package:essai2/afef/screens/Admin_Screen/listeenseingant.dart';
import 'package:essai2/afef/screens/Admin_Screen/listeetudiant.dart';
import 'package:essai2/afef/screens/Admin_Screen/listemploye.dart';
import 'package:flutter/material.dart';

class ListeMembre extends StatefulWidget {
  @override
  _ListeMembreState createState() => _ListeMembreState();
}

class _ListeMembreState extends State<ListeMembre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text(
            'Liste des membres',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: 400,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        minimumSize: const Size(60.0, 60.0),
                        backgroundColor: Colors.cyan[50],
                        elevation: 10.0,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TeacherListPage()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.cyan[700],
                        ),
                        SizedBox(width: 30),
                        Text(
                          "Liste des enseignants",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 80,
                width: 400,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        minimumSize: const Size(60.0, 60.0),
                        backgroundColor: Colors.cyan[50],
                        elevation: 10.0,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudentListPage()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.school,
                          color: Colors.cyan[700],
                        ),
                        SizedBox(width: 30),
                        Text(
                          "Liste des étudiants",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 80,
                width: 400,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        minimumSize: const Size(60.0, 60.0),
                        backgroundColor: Colors.cyan[50],
                        elevation: 10.0,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmployeListPage()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.work,
                          color: Colors.cyan[700],
                        ),
                        SizedBox(width: 30),
                        Text(
                          "Liste des employés",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
