import 'package:mobile_fest_app/bo/artiste.dart';

class Event {
  final String id;
  final String scene;
  final String datetime_debut;
  final String datetime_fin;
  final Artiste artiste;

  Event({
    required this.id,
    required this.scene,
    required this.datetime_debut,
    required this.datetime_fin,
    required this.artiste
});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        scene: json['scene_id'],
        datetime_debut: json['datetime_debut'],
        datetime_fin: json['datetime_fin'],
        artiste: json['artiste'],
    );
  }
}