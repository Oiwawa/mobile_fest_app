import 'dart:convert';

import 'package:mobile_fest_app/bo/artiste.dart';
import 'package:http/http.dart' as http;

_fetchArtiste() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/artiste'));

  if (response.statusCode == 200) {

    var mapArtistes = jsonDecode(response.body);
    List<Artiste> festivals = List<Artiste>.from(
      mapArtistes.map((festivals) => Artiste.fromJson(festivals))
    );
  } else {
    throw Exception('Erreur de chargement des données.');
  }
}
