import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecScene = TextEditingController();
  TextEditingController tecDebut = TextEditingController();
  TextEditingController tecFin = TextEditingController();


  TimeOfDay _debut = TimeOfDay(hour: 19, minute: 00);
  TimeOfDay _fin = TimeOfDay(hour: 21, minute: 00);

  void _selectTimeDebut() async {
    final TimeOfDay? debut = await showTimePicker(
      context: context,
      initialTime: _debut,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (debut != null) {
      setState(() {
        _debut = debut;
      });
    }
  }
  void _selectTimeFin() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _fin,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (newTime != null) {
      setState(() {
        _fin = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un événement à la prog")),
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
        const Spacer(flex: 1,),
        TextField(
          controller: tecScene,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              label: Text('Scene'),
              prefixIcon: Icon(Icons.apartment)),
        ),
        const Spacer(flex: 1,),
        ElevatedButton(
          onPressed: _selectTimeDebut,
          child: const Text('DEBUT'),
        ),
        const SizedBox(height: 2),
        Text(
          'Horaire début: ${_debut.format(context)}',
        ),
        const Spacer(flex: 1,),
        ElevatedButton(
          onPressed: _selectTimeFin,
          child: const Text('FIN'),
        ),
        const SizedBox(height: 8),
        Text(
          'Horaire fin: ${_fin.format(context)}',
        ),
        const Spacer(flex: 1,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: _onAddEvent,
              child: const Text('CREER UN EVENEMENT')),
        ),
        const Spacer(flex: 1,),
      ],
    );
  }

  _onAddEvent() async {
    String name = tecName.text;
    String scene = tecScene.text;
    String debut = _debut.format(context);
    String fin = _fin.format(context);

    var responseRegister = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/event'),
        body: {
          "nomArtiste": name,
          "scene": scene,
          "time_debut": debut,
          "time_fin": fin,
        });
    try {
      if (responseRegister.statusCode == 200) {
        SnackBar snackBarSuccess =
        const SnackBar(content: Text("Ajout de l'évenement réussi"));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);

        tecName.clear();
        tecScene.clear();
        _onAdd();
      } else {
        SnackBar snackBarSuccess = SnackBar(
            content:
            Text(responseRegister.body[0]));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
      }
    } on SocketException catch (socketException) {
      SnackBar snackBarSuccess = const SnackBar(
          content: Text("Nous avons des difficultés à joindre le serveur"));
      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
    }
  }

  _onAdd() async {
    Navigator.of(context).pushNamed('/admin/events');
  }
}
