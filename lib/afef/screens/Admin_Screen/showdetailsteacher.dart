import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeachersDetailsPage extends StatelessWidget {
  final Map<String, dynamic> teacher;

  TeachersDetailsPage({required this.teacher});

  @override
  Widget build(BuildContext context) {
    Timestamp datenaissanceens = teacher['date de naissance'];
    DateTime datenaissanceensTime = datenaissanceens.toDate();
    String datenaissanceensString =
        DateFormat('yyyy-MM-dd').format(datenaissanceensTime);
    Timestamp dateembauche = teacher['date d\'embauche'];
    DateTime dateembaucheTime = dateembauche.toDate();
    String dateembaucheString =
        DateFormat('yyyy-MM-dd').format(dateembaucheTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Détailles de l\'enseigant'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan.shade700,
                      Color.fromARGB(255, 39, 167, 176),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${teacher['nom']} ${teacher['prenom']}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Téléphone :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${teacher['telephone']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date de naissance :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            datenaissanceensString,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${teacher['email']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grade :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${teacher['grade']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Departement:',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${teacher['departement']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adresse :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${teacher['adresse']}, ${teacher['ville']}, ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'date d\'embauche :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            dateembaucheString,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
