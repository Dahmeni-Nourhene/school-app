import 'package:essai2/Model/calendriers_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/calendriers_model.dart';
import '../buttonsF/calender_firebase.dart';

class CalendriersController {
  Stream<List<Calendriers>> readCalendriers() => FirebaseFirestore.instance
      .collection('calendriers')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => Calendriers.fromJson(doc.data()))
          .toList());

  Future createCalendriersSchedule(Calendriers calendriers) async {
    final docCalendriers =
        FirebaseFirestore.instance.collection('calendriers').doc();
    calendriers.id = docCalendriers.id;
    final json = calendriers.toJson();
    await docCalendriers.set(json);
  }

  Future<Calendriers?> getOneCalendriersSchedule(String id) async {
    
    final docCalendriers =
        FirebaseFirestore.instance.collection('calendriers').doc(id.trim());
    final snapshot = await docCalendriers.get();

    if (snapshot.exists) {
      return Calendriers.fromJson(snapshot.data()!);
    } else if (!snapshot.exists) {
      print("there is no Calendriers");
    }
  }

  Future updateCalendriersSchedule(String id, Calendriers calendriers) async {
    final docCalendriers =
        FirebaseFirestore.instance.collection('calendriers').doc(id);
    final json = calendriers.toJson();
    await docCalendriers.update(json);
  }

  Future deleteCalendriersSchedule(String id) async {
    final docCalendriers =
        FirebaseFirestore.instance.collection('calendriers').doc(id);
    docCalendriers.delete();
  }
}
