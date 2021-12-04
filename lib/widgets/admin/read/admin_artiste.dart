import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_fest_app/bo/artiste.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_fest_app/widgets/admin/update/update_artiste.dart';

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
                              fontSize: 15.0,
                        )),
                        const Spacer(flex: 1,),
                        Text(listeArtistes[index].contact.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 8),
                        IconButton(
                            onPressed: () => _editArtiste(listeArtistes[index]),
                            icon: const Icon(Icons.edit)
                        ),
                        const Spacer(flex: 1),
                        IconButton(
                            onPressed: () => _deleteArtiste(listeArtistes[index].id.toString()),
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
                onPressed: _addArtiste,
                child: const Text('AJOUTER UN ARTISTE')),
          ),
          ElevatedButton(
          onPressed: _home,
          child: const Text('DASHBOARD')),
        ],
      ),
    );
  }

  _home(){
    Navigator.of(context).pushNamed('/admin');
  }

  _fetchArtiste() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/artiste'));

    if (response.statusCode == 200) {

      var mapArtistes = jsonDecode(response.body);
      List<Artiste> artistes = List<Artiste>.from(
          mapArtistes.map((artistes) => Artiste.fromJson(artistes))
      );
      print(artistes);
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

  _addArtiste() {
    Navigator.of(context).pushNamed('/admin/artistes/create');
  }

  _editArtiste(Artiste artiste) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateArtistePage(),
        ));
  }

  _deleteArtiste(String id) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:8000/api/artiste/'+ id));

    if (response.statusCode == 200) {
      SnackBar snackBarSuccess =
      const SnackBar(content: Text("Artiste supprimé du festival."));
      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
      _fetchArtiste();
    }

  }
}
