import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecFestivalPass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un utilisateur")),
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
              label: Text('Nom :'),
              prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: tecEmail,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              label: Text('Email :'),
              prefixIcon: Icon(Icons.mail)),
        ),
        TextField(
          controller: tecEmail,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              label: Text('N° pass festival :'),
              prefixIcon: Icon(Icons.confirmation_number)),
        ),
        const Spacer(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _onAddUser(),
              child: const Text('AJOUTER L\'UTILISATEUR')),
        ),
        const Spacer()
      ],
    );
  }

  _onAddUser() async {
    String name = tecName.text;
    String email = tecEmail.text;
    String festivalPass = tecFestivalPass.text;

    var responseRegister = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/user'),
        body: {
          "nom": name,
          "email": email,
          "festivalPass": festivalPass,
        });
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
    Navigator.of(context).pushNamed('/admin/users');
  }
}
