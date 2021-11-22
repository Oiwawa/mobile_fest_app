import 'dart:convert';
import 'package:mobile_fest_app/bo/artiste.dart';
import 'package:mobile_fest_app/bo/event.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_fest_app/bo/festival.dart';
import 'package:mobile_fest_app/bo/scene.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Event> listeEvents = [];
  late List<Artiste> listeArtistes = [];
  late List<Scene> listeScenes = [];
  late List<Festival> festival = [];

  TextEditingController tecEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Programmation")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeEvents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeEvents[index].artiste.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text(listeEvents[index].scene.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _fetchEvents() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/event'));

    if (response.statusCode == 200) {

      var mapEvents = jsonDecode(response.body);
      List<Event> events = List<Event>.from(
          mapEvents.map((events) => Event.fromJson(events))
      );
      _onReloadListView(events);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Event> events) {
    setState(() {
      listeEvents = events;
      tecEvent.clear();
    });
  }
}