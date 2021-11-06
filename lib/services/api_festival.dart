import 'dart:convert';

import 'package:mobile_fest_app/bo/festival.dart';
import 'package:http/http.dart' as http;

_fetchFestival() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/festival'));

  if (response.statusCode == 200) {

    var mapFestivals = jsonDecode(response.body);
    List<Festival> festivals = List<Festival>.from(
      mapFestivals.map((festivals) => Festival.fromJson(festivals))
    );
  } else {
    throw Exception('Erreur de chargement des données.');
  }
}
