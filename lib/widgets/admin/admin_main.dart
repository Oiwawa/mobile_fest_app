import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();

}

class _AdminMainState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DASHBOARD ADMIN")),
      body: Center(
        child: _buildColumnFields(),
      ),
    );
  }

  Widget _buildColumnFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
              onPressed: _goToArtiste,
              child: const Text('ARTISTES')),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
              onPressed: _goToUsers,
              child: const Text('UTILISATEURS')),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _goToScene,
              child: const Text('SCENES')),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _goToEvent,
              child: const Text('EVENEMENTS')),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _home,
              child: const Text('ACCUEIL')),
        ),
        const Spacer()
      ],
    );
  }

  _goToArtiste() async {
    Navigator.of(context).pushNamed('/admin/artistes');
  }
  _goToUsers() async {
    Navigator.of(context).pushNamed('/admin/users');
  }
  _goToScene() async {
    Navigator.of(context).pushNamed('/admin/scenes');
  }
  _goToEvent() async {
    Navigator.of(context).pushNamed('/admin/events');
  }
  _home() async {
    Navigator.of(context).pushNamed('/');
  }

}
