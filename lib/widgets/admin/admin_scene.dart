import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_fest_app/bo/scene.dart';
import 'package:http/http.dart' as http;

class AdminScene extends StatefulWidget {
  const AdminScene({Key? key}) : super(key: key);

  @override
  _AdminSceneState createState() => _AdminSceneState();
}

class _AdminSceneState extends State<AdminScene> {
  late List<Scene> listeScenes = [];

  TextEditingController tecScene = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchScene();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des scenes")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeScenes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeScenes[index].nom),
                        // const Spacer(),
                        // Text(listeScenes[index].festival.nom.toString(),
                        //     style: const TextStyle(
                        //       fontSize: 15.0,
                        //     )),
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


  _fetchScene() async {
    final response =
    await http.get(Uri.parse('http://127.0.0.1:8000/api/scene'));

    if (response.statusCode == 200) {
      var mapScenes = jsonDecode(response.body);
      List<Scene> scenes = List<Scene>.from(
          mapScenes.map((scenes) => Scene.fromJson(scenes)));
      _onReloadListView(scenes);

    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Scene> scenes) {
    setState(() {
      listeScenes= scenes;
      tecScene.clear();
    });
  }
}
