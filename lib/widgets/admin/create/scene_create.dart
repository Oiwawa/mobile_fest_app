import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CreateScenePage extends StatefulWidget {
  const CreateScenePage({Key? key}) : super(key: key);

  @override
  _CreateScenePageState createState() => _CreateScenePageState();
}

class _CreateScenePageState extends State<CreateScenePage> {
  TextEditingController tecName = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer une nouvelle scène")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: _buildColumnFields(),
      ),
    );
  }

  Widget _buildColumnFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        TextField(
          controller: tecName,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              label: Text('Nom de la scène'), prefixIcon: Icon(Icons.person)),
        ),
        const Spacer(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _onAddScene,
              child: const Text('AJOUTER LA SCÈNE')),
        ),
        const Spacer()
      ],
    );
  }

  _onAddScene() async {
    print('nom scene : ${tecName.text}');
    String name = tecName.text;

    var responseRegister = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/scene'),
        body: {
          "nom": name,
        });
    print(responseRegister.body.toString());
    try {
      if (responseRegister.statusCode == 200) {
        SnackBar snackBarSuccess =
        const SnackBar(content: Text("Ajout réussi"));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);

        tecName.clear();
        _onAdd();
      } else if (responseRegister.statusCode != null) {
        SnackBar snackBarSuccess = SnackBar(
            content:
            Text("Erreur : " + responseRegister.reasonPhrase.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
      }
    } on SocketException catch (socketException) {
      SnackBar snackBarSuccess = const SnackBar(
          content: Text("Nous avons des difficultés à joindre le serveur"));
      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
    }
  }

  _onAdd() async {
    Navigator.of(context).pushNamed('/admin/scenes');
  }
}
