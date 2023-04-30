import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'final2.dart';

class MastereCalendrier extends StatefulWidget {
  @override
  _MastereCalendrierState createState() => _MastereCalendrierState();
}

class _MastereCalendrierState extends State<MastereCalendrier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text(
            'Calendrier de examens',
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
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 16, 105, 222))),
                    onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamSchedulePageFinal2(masterId: 'master1'),
      ),
    );
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
                          "Master en Ingénierie Financière",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
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
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 16, 105, 222))),
                   onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamSchedulePageFinal2(masterId: 'master2'),
      ),
    );
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
                          "Master en Management de Projets",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    )),
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
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 16, 105, 222))),
                    onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamSchedulePageFinal2(masterId: 'master3'),
      ),
    );
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
                          "Master en Marketing Digital",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    )),
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
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 16, 105, 222))),
                   onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamSchedulePageFinal2(masterId: 'master4'),
      ),
    );
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
                          " Master en Transformation \nDigital et CRM",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    )),
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
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 16, 105, 222))),
                    onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamSchedulePageFinal2(masterId: 'master5'),
      ),
    );
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
                          " MASTER  À l’EM NORMANDIE",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    )),
              )
              ////// //////////////////////////
            ],
          ),
        ));
  }
}
