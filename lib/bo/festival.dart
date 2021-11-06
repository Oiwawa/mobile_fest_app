class Festival {
  final String id;
  final String nom;
  final String nomOrga;
  final String date_debut;
  final String date_fin;

  Festival({
    required this.id,
    required this.nom,
    required this.nomOrga,
    required this.date_debut,
    required this.date_fin
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['id'],
      nom: json['nom'],
      nomOrga: json['nom_orga'],
      date_debut: json['date_debut'],
      date_fin: json['date_fin'],
    );
  }
}