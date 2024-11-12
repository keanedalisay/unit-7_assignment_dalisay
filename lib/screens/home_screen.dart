import 'dart:convert' as convert;
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<Rosary> fetchRosary() async {
  final response = await http.get(Uri.parse('https://the-rosary-api.vercel.app/v1/monday'));

  if (response.statusCode == 200) {
    return Rosary.fromJson(convert.jsonDecode(response.body)[0]);

  } else {
    throw Exception('Failed to fetch rosary. Error Code: ${response.statusCode}.');
  }
}

class Rosary {
  final String date;
  final String group_by;

  Rosary({required this.date, required this.group_by});

  factory Rosary.fromJson(Map<String, dynamic> json) {
    debugPrint('${json}');
    return switch (json) {
      { 'date': String date, 'group_by': String group_by } => Rosary(date: date, group_by: group_by),
          _ => throw const FormatException('Failed to load roasry.')
    };
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExpandedTileController con = ExpandedTileController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 7 - API Calls"),
      ),
      body: FutureBuilder(
        future: fetchRosary(),
        builder: (context, snapshot) {
          
          if (snapshot.hasData) {
            return Column(
              children: [
                ExpandedTile(
                    title: Text('This is the title'),
                    content: Text('${snapshot.data!.date} ${snapshot.data!.group_by}'),
                    controller: con)
              ],
            );
          }

          else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
