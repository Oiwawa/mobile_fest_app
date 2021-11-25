import 'package:mobile_fest_app/bo/artiste.dart';
import 'package:mobile_fest_app/bo/scene.dart';

class Event {
  final String id;
  final String datetime_debut;
  final String datetime_fin;
  final Artiste artiste;
  final Scene scene;

  Event({
    required this.id,
    required this.datetime_debut,
    required this.datetime_fin,
    required this.artiste,
    required this.scene
});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        datetime_debut: json['datetime_debut'],
        datetime_fin: json['datetime_fin'],
        artiste: Artiste.fromJson(json['artiste']),
        scene: Scene.fromJson(json['scene'])
    );
  }
}