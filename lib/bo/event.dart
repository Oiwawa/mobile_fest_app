import 'package:mobile_fest_app/bo/artiste.dart';
import 'package:mobile_fest_app/bo/scene.dart';

class Event {
  final String id;
  final String time_debut;
  final String time_fin;
  final Artiste artiste;
  final Scene scene;

  Event({
    required this.id,
    required this.time_debut,
    required this.time_fin,
    required this.artiste,
    required this.scene
});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        time_debut: json['time_debut'],
        time_fin: json['time_fin'],
        artiste: Artiste.fromJson(json['artiste']),
        scene: Scene.fromJson(json['scene'])
    );
  }
}