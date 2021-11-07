class Event {
  final String id;
  final String artiste;
  final String scene;
  final String datetime_debut;
  final String datetime_fin;

  Event({
    required this.id,
    required this.artiste,
    required this.scene,
    required this.datetime_debut,
    required this.datetime_fin
});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        artiste: json['artiste_id'],
        scene: json['scene_id'],
        datetime_debut: json['datetime_debut'],
        datetime_fin: json['datetime_fin']
    );
  }
}