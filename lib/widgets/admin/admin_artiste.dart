import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_fest_app/bo/artiste.dart';
import 'package:mobile_fest_app/bo/festival.dart';
import 'package:http/http.dart' as http;

class AdminArtiste extends StatefulWidget {
  const AdminArtiste({Key? key}) : super(key: key);

  @override
  _AdminArtisteState createState() => _AdminArtisteState();
}

class _AdminArtisteState extends State<AdminArtiste> {
  late List<Artiste> listeArtistes = [];

  TextEditingController tecArtiste = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchArtiste();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Artistes")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeArtistes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeArtistes[index].nom.toString(),
                        style: const TextStyle(

                        )),
                        const Spacer(flex: 1,),
                        Text("Contact : "+ listeArtistes[index].contact.toString(),
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

  _fetchArtiste() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/artiste'));

    if (response.statusCode == 200) {

      var mapArtistes = jsonDecode(response.body);
      List<Artiste> artistes = List<Artiste>.from(
          mapArtistes.map((artistes) => Artiste.fromJson(artistes))
      );
      _onReloadListView(artistes);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Artiste> artistes) {
    setState(() {
      listeArtistes = artistes;
      tecArtiste.clear();
    });
  }
}
