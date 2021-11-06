import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecFestivalPass = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Se créer un compte")),
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
          controller: tecEmail,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              label: Text('Nom'), prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: tecEmail,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              label: Text('Adresse-mail'), prefixIcon: Icon(Icons.email)),
        ), TextField(
          controller: tecFestivalPass,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              label: Text('N° pass festival'),
              prefixIcon: Icon(Icons.confirmation_number)),
        ),
        TextField(
          controller: tecPassword,
          textInputAction: TextInputAction.done,
          obscureText: true,
          decoration: const InputDecoration(
              label: Text('Mot de passe'), prefixIcon: Icon(Icons.password)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _onRegister, child: const Text('S\'ENREGISTER')),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _onLogin,
              child: const Text('DÉJA UN COMPTE ? S\'IDENTIFIER')),
        ),
        const Spacer()
      ],
    );
  }

  _onRegister() async {
    print('username : ${tecName.text}');
    print('email : ${tecEmail.text}');
    print('password : ${tecPassword.text}');
    String name = tecName.text;
    String festivalPass = tecFestivalPass.text;
    String email = tecEmail.text;
    String password = tecPassword.text;

    //flutter pub add http

    var responseRegister = await http.post(
        Uri.parse('http://http://127.0.0.1:8000/auth/api/register'),
        body: {
          "name": name,
          "email": email,
          "festival_pass": tecFestivalPass,
          "password": password,
        });
    try {
      if (responseRegister.statusCode == 200) {
        SnackBar snackBarSuccess =
        const SnackBar(content: Text("Inscription réussie"));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);

        tecPassword.clear();
        tecName.clear();
        tecEmail.clear();
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

  _onLogin() async {
    Navigator.of(context).pushNamed('/login');
  }
}
