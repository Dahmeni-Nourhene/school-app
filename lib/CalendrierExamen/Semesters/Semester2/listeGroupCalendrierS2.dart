import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Licence/licencesCalendrierS2.dart';
import 'Mastere/MastereCalendrierS2.dart';



class listeGroupCalendrierS2 extends StatefulWidget {
   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
   
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  @override
  _listeGroupCalendrierS2State createState() => _listeGroupCalendrierS2State();
}

class _listeGroupCalendrierS2State extends State<listeGroupCalendrierS2> {
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
                              builder: (context) => LicencesCalendrierS2()));
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
                          "Licences",
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.cyan[700]),
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
                              builder: (context) => MastereCalendrierS2()));
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
                          "Mastéres",
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.cyan[700]),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
