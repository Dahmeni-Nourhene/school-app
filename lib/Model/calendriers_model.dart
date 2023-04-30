import 'package:cloud_firestore/cloud_firestore.dart';


class Calendriers {
    String calendriersClass;
    String formation;
    String groupe;
    String id;
    String niveau;
    String nom;
    String specialit;

    Calendriers({
        required this.calendriersClass,
        required this.formation,
        required this.groupe,
        required this.id,
        required this.niveau,
        required this.nom,
        required this.specialit,
    });

    factory Calendriers.fromJson(Map<String, dynamic> json) => 
    Calendriers(
        calendriersClass: json["class"],
        formation: json["formation"],
        groupe: json["groupe"],
        id: json["id"],
        niveau: json["niveau"],
        nom: json["nom"],
        specialit: json["specialité"],
    );

    Map<String, dynamic> toJson() => {
        "class": calendriersClass,
        "formation": formation,
        "groupe": groupe,
        "id": id,
        "niveau": niveau,
        "nom": nom,
        "specialité": specialit,
    };
}
