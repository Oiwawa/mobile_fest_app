import 'package:flutter/material.dart';
import 'package:mobile_fest_app/widgets/admin/admin_event.dart';
import 'package:mobile_fest_app/widgets/admin/admin_festival.dart';
import 'package:mobile_fest_app/widgets/admin/admin_artiste.dart';
import 'package:mobile_fest_app/widgets/admin/admin_main.dart';
import 'package:mobile_fest_app/widgets/admin/admin_scene.dart';
import 'package:mobile_fest_app/widgets/admin/admin_user.dart';
import 'package:mobile_fest_app/widgets/admin/create/artiste_create.dart';
import 'package:mobile_fest_app/widgets/admin/create/event_create.dart';
import 'package:mobile_fest_app/widgets/admin/create/scene_create.dart';

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
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => RegisterPage(),
        '/login': (BuildContext context) => LoginPage(),

        '/home': (BuildContext context) => HomePage(),
        '/admin': (BuildContext context) => AdminMainPage(),

        '/admin/artistes': (BuildContext context) => AdminArtiste(),
        '/admin/artistes/create': (BuildContext context) => CreateArtistePage(),

        '/admin/scenes': (BuildContext context) => AdminScene(),
        '/admin/scenes/create': (BuildContext context) => CreateScenePage(),
        '/admin/scenes/update': (BuildContext context) => CreateScenePage(),

        '/admin/events': (BuildContext context) => AdminEvent(),
        '/admin/events/create': (BuildContext context) => CreateEventPage(),

        '/admin/festival': (BuildContext context) => AdminFestival(),
        '/admin/users': (BuildContext context) => AdminUser(),
      },
      initialRoute: '/admin/scenes',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
