import 'dart:convert';

import 'package:mobile_fest_app/bo/festival.dart';
import 'package:http/http.dart' as http;

Future<Festival> fetchFestival() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/festival'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Festival.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}