import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_fest_app/bo/event.dart';

class AdminEvent extends StatefulWidget {
  const AdminEvent({Key? key}) : super(key: key);

  @override
  _AdminEventState createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  late List<Event> listeEvents = [];

  TextEditingController tecEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Evénements")),
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
                        Text(listeEvents[index].time_debut.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 1,),
                        Text(listeEvents[index].time_fin.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 1,),
                        Text(listeEvents[index].artiste.nom.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        IconButton(
                            onPressed: () => _deleteEvent(listeEvents[index].id.toString()),
                            icon: const Icon(Icons.delete)
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: _addEvent,
                child: const Text('AJOUTER UN EVENEMENT')),
          ),
        ],
      ),
    );
  }

  _fetchEvents() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/event'));

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

  _addEvent() {
    Navigator.of(context).pushNamed('/admin/events/create');
  }

  _deleteEvent(String id) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:8000/api/event/'+ id));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Evénement supprimé de la programmation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4
      );
      _fetchEvents();
    }

  }
}
