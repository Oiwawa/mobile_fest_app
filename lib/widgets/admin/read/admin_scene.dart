import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            flex: 10,
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeScenes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeScenes[index].nom),
                        const Spacer(flex: 8),
                        IconButton(
                            onPressed: () =>
                                _editScene(listeScenes[index].id.toString()),
                            icon: const Icon(Icons.edit)
                        ),
                        const Spacer(flex: 1),
                        IconButton(
                            onPressed: () =>
                                _deleteScene(listeScenes[index].id.toString()),
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
                onPressed: _addScene,
                child: const Text('CRÉER UNE SCENE')),
          ),
          const Spacer(flex: 1),
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
      listeScenes = scenes;
      tecScene.clear();
    });
  }

  _addScene() {
    Navigator.of(context).pushNamed('/admin/scenes/create');
  }

  _editScene(String id) {
    Navigator.of(context).pushNamed('/admin/scenes/update');
  }

  _deleteScene(String id) async {
    final response = await http
        .delete(Uri.parse('http://127.0.0.1:8000/api/scene/' + id));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Scène supprimée.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4
      );
      _fetchScene();
    }
  }
}
