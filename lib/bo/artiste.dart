class Artiste {
  final String id;
  final String nom;
  final String contact;

  Artiste({
    required this.id,
    required this.nom,
    required this.contact
});
  factory Artiste.fromJson(Map<String, dynamic> json) {
    return Artiste(
        id: json['id'],
        nom: json['nom'],
        contact: json['contact']
    );
  }
}