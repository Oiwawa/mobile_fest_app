class Festival {
  final int id;
  final String nom;
  final String nomOrga;

  Festival({
    required this.id,
    required this.nom,
    required this.nomOrga,
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['id'],
      nom: json['nom'],
      nomOrga: json['nom_orga'],
    );
  }
}