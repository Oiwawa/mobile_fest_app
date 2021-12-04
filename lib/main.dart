import 'package:flutter/material.dart';
import 'package:mobile_fest_app/widgets/admin/create/user_create.dart';
import 'package:mobile_fest_app/widgets/admin/read/admin_event.dart';
import 'package:mobile_fest_app/widgets/admin/read/admin_festival.dart';
import 'package:mobile_fest_app/widgets/admin/read/admin_artiste.dart';
import 'package:mobile_fest_app/widgets/admin/admin_main.dart';
import 'package:mobile_fest_app/widgets/admin/read/admin_scene.dart';
import 'package:mobile_fest_app/widgets/admin/read/admin_user.dart';
import 'package:mobile_fest_app/widgets/admin/create/artiste_create.dart';
import 'package:mobile_fest_app/widgets/admin/create/event_create.dart';
import 'package:mobile_fest_app/widgets/admin/create/scene_create.dart';
import 'package:mobile_fest_app/widgets/admin/update/update_artiste.dart';

import 'widgets/home_page.dart';
import 'widgets/login_page.dart';
import 'widgets/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobileFest',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyBottomNavigationBar(),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => RegisterPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        '/admin': (BuildContext context) => AdminMainPage(),
        '/admin/artistes': (BuildContext context) => AdminArtiste(),
        '/admin/artistes/create': (BuildContext context) => CreateArtistePage(),
        '/admin/artistes/update/': (BuildContext context) =>
            UpdateArtistePage(),
        '/admin/scenes': (BuildContext context) => AdminScene(),
        '/admin/scenes/create': (BuildContext context) => CreateScenePage(),
        '/admin/scenes/update': (BuildContext context) => CreateScenePage(),
        '/admin/events': (BuildContext context) => AdminEvent(),
        '/admin/events/create': (BuildContext context) => CreateEventPage(),
        '/admin/festival': (BuildContext context) => AdminFestival(),
        '/admin/users': (BuildContext context) => AdminUser(),
        '/admin/users/create': (BuildContext context) => CreateUserPage(),
      },
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const LoginPage(),
    const AdminMainPage()
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ("Home")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ("Connexion")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: ("Admin")
          ),
        ],
      ),
    );
  }
}
