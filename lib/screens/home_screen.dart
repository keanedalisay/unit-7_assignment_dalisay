import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<dynamic> _data;
  late ExpandedTileController _controller;

  var uri  = Uri.https('the-rosary-api.vercel.app', '/v1/monday');

  @override
  void initState() {
    _data = http.get(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 7 - API Calls"),
      ),
      body: FutureBuilder(
        // setup the URL for your API here
        future: _data,
        builder: (context, snapshot) {
          // Consider 3 cases here
          // when the process is ongoing
          // return CircularProgressIndicator();
          if (snapshot.connectionState == 'waiting') {
            return CircularProgressIndicator();
          }
          // when the process is completed:

          // successful
          // Use the library here
          else {
            // var jsonResponse = convert.jsonDecode(snapshot.data) as Map<String, dynamic>;

            return ExpandedTileList.builder(
              itemCount: 3,
              maxOpened: 2,
              reverse: true,
              itemBuilder: (context, index, con) {
                return ExpandedTile(
                    title: Text('This is the title ${snapshot.data}'),
                    content: Text('This is the content!'),
                    controller: con);
              },
            );
          }

          // error


        },
      ),
    );
  }
}
