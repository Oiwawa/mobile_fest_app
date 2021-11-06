import 'package:mobile_fest_app/bo/festival.dart';

class Scene {
  final String id;
  final String nom;
  // final Festival festival;

  Scene({
    required this.id,
    required this.nom,
    // required this.festival
  });

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      id: json['id'],
      nom: json['nom'],
      // festival: json['festival']
    );
  }
}