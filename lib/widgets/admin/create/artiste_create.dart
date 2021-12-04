import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CreateArtistePage extends StatefulWidget {
  const CreateArtistePage({Key? key}) : super(key: key);

  @override
  _CreateArtistePageState createState() => _CreateArtistePageState();
}

class _CreateArtistePageState extends State<CreateArtistePage> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecContact = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un artiste")),
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
              label: Text('Nom de l\'artiste'),
              prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: tecContact,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              label: Text('Contact de l\'artiste'),
              prefixIcon: Icon(Icons.mail)),
        ),
        const Spacer(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _onAddArtiste,
              child: const Text('AJOUTER L\'ARTISTE')),
        ),
        const Spacer()
      ],
    );
  }

  _onAddArtiste() async {
    print('nom artiste : ${tecName.text}');
    print('nom artiste : ${tecContact.text}');
    String name = tecName.text;
    String contact = tecContact.text;

    var responseRegister = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/artiste'),
        body: {
          "nom": name,
          "contact": contact,
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
    Navigator.of(context).pushNamed('/admin/artistes');
  }
}
