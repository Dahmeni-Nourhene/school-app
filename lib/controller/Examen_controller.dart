import 'package:essai2/Model/exam_schedule_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../buttonsF/calender_firebase.dart';

class ExamenController {
  Stream<List<ExamSchedule>> readExamSchedule() => FirebaseFirestore.instance
      .collection('exam_schedule')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => ExamSchedule.fromJson(doc.data()))
          .toList());

  Future createExamenSchedule(ExamSchedule examen) async {
    final docExamen =
        FirebaseFirestore.instance.collection('exam_schedule').doc();
    examen.id = docExamen.id;
    final json = examen.toJson();
    await docExamen.set(json);
  }
  
 

  Future<ExamSchedule?> getOneExamenSchedule(String id) async {
    final docExamen =
        FirebaseFirestore.instance.collection('exam_schedule').doc(id);
    final snapshot = await docExamen.get();
    if (snapshot.exists) {
      return ExamSchedule.fromJson(snapshot.data()!);
    }
     
  }
  Future updateExamenSchedule(String id,ExamSchedule examen) async {
    final docExamen =
        FirebaseFirestore.instance.collection('exam_schedule').doc(id);
    final json = examen.toJson();
    await docExamen.update(json);
    }
    Future deleteExamenSchedule(String id) async {
    final docExamen =
        FirebaseFirestore.instance.collection('exam_schedule').doc(id);
     docExamen.delete();
    }

}
