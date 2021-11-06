import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_fest_app/bo/festival.dart';
import 'package:http/http.dart' as http;

class AdminFestival extends StatefulWidget {
  const AdminFestival({Key? key}) : super(key: key);

  @override
  _AdminFestivalState createState() => _AdminFestivalState();
}

class _AdminFestivalState extends State<AdminFestival> {
  late List<Festival> listeFestivals = [];

  TextEditingController tecFestival = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFestival();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Festival")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeFestivals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeFestivals[index].nom),
                        const Spacer(flex: 1,),
                        Text("Du : "+ listeFestivals[index].date_debut.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        Text(" au : " +listeFestivals[index].date_fin.toString(),
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


  _fetchFestival() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/festival'));

    if (response.statusCode == 200) {
      var mapFestivals = jsonDecode(response.body);
      List<Festival> festivals = List<Festival>.from(
          mapFestivals.map((festivals) => Festival.fromJson(festivals)));
      _onReloadListView(festivals);

    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Festival> festivals) {
    setState(() {
      listeFestivals = festivals;
      tecFestival.clear();
    });
  }
}
