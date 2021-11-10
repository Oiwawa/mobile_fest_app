import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '/bo/festival.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Festival> festival;

  @override
  void initState() {
    super.initState();
    _fetchFestival();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Festival")),
      body: Center(
        child: FutureBuilder<Festival>(
          future: festival,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.nom);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<Festival> _fetchFestival() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/festival/5cd4e624-f803-3d2d-b854-b6a804a1363f'));

    if (response.statusCode == 200) {
      return Festival.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load festival');
    }
  }
}