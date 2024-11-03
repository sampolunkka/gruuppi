import 'package:flutter/material.dart';
import 'package:gruuppi/player.dart';
import 'package:gruuppi/profile_view.dart';
import 'package:gruuppi/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor('#000000'),
          titleTextStyle: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.normal,
            fontFamily: 'Cookie',
            color: HexColor('#FFFFFF'),
          ),
        ),
      ),
      title: 'Flutter Demo',
      home: MyHomePage(title: 'gruuppi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TestProfile
    Player player = Player('TestPlayer');
    player.games = [
      Game('Magic The Gathering', 100, [
        Format('Commander', Level.casual),
        Format('Modern', Level.competitive),
      ]),
      Game('Star Wars Unlimited', 200, [
        Format('Format3', Level.any),
      ]),
    ];
    player.bio = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title,
              style: Theme.of(context).appBarTheme.titleTextStyle),
        ),
        body: ProfileView(player),
      ),
    );
  }
}
