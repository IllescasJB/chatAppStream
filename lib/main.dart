import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'home_chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Client _client;

  @override
  void initState() {
    _client = Client(
      'ee7kbu3sx7rg',
      logLevel: Level.INFO,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      builder: (context, child) {
        return StreamChat(client: _client, child: child);
      },
      home: HomeChat(),
    );
  }
}
