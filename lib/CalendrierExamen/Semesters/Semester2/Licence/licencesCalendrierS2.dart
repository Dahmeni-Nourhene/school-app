import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'finaal3S2.dart';

class LicencesCalendrierS2 extends StatefulWidget {
  @override
  _LicencesCalendrierS2State createState() => _LicencesCalendrierS2State();
}

class _LicencesCalendrierS2State extends State<LicencesCalendrierS2> {
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
                          builder: (context) =>
                              licenceS2IdExamSchedulePageFinal3S2(
                                  licenceS2Id: 'licence11'),
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
                          "Licence  en Informatique \nGénie Logiciel",
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
                          builder: (context) =>
                              licenceS2IdExamSchedulePageFinal3S2(
                                  licenceS2Id: 'licence22'),
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
                          "Licence en Management",
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
                          builder: (context) =>
                              licenceS2IdExamSchedulePageFinal3S2(
                                  licenceS2Id: 'licence33'),
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
                          "Licence en Finance",
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
                          builder: (context) =>
                              licenceS2IdExamSchedulePageFinal3S2(
                                  licenceS2Id: 'licence44'),
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
                          " Licence en Marketing",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
