import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_fest_app/bo/user.dart';

class AdminUser extends StatefulWidget {
  const AdminUser({Key? key}) : super(key: key);

  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  late List<User> listeUsers = [];

  TextEditingController tecUser = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Utilisateurs")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeUsers[index].name.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text("Contact : "+ listeUsers[index].festivalPass.toString(),
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

  _fetchUsers() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/user'));

    if (response.statusCode == 200) {

      var mapUsers = jsonDecode(response.body);
      List<User> users = List<User>.from(
          mapUsers.map((users) => User.fromJson(users))
      );
      _onReloadListView(users);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<User> users) {
    setState(() {
      listeUsers = users;
      tecUser.clear();
    });
  }
}
