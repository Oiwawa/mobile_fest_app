class User {
  final int id;
  final String name;
  final String email;
  final String festivalPass;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.festivalPass,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      festivalPass: json['festival_pass'],
    );
  }
}