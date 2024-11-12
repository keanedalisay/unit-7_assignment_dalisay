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
  final response =
      await http.get(Uri.parse('https://the-rosary-api.vercel.app/v1/monday'));

  if (response.statusCode == 200) {
    return Rosary.fromJson(convert.jsonDecode(response.body)[0]);
  } else {
    throw Exception(
        'Failed to fetch rosary. Error Code: ${response.statusCode}.');
  }
}

class Rosary {
  final String date;
  final String group_by;
  final String i_believe;
  final String announce_1;
  final String announce_2;
  final String announce_3;
  final String announce_4;
  final String announce_5;

  Rosary({
    required this.date,
    required this.group_by,
    required this.i_believe,
    required this.announce_1,
    required this.announce_2,
    required this.announce_3,
    required this.announce_4,
    required this.announce_5,
  });

  factory Rosary.fromJson(Map<String, dynamic> json) {
    debugPrint('${json}');
    return switch (json) {
      {
        'date': String date,
        'group_by': String group_by,
        'i_believe': String i_believe,
        'announce_1': String announce_1,
        'announce_2': String announce_2,
        'announce_3': String announce_3,
        'announce_4': String announce_4,
        'announce_5': String announce_5
      } =>
        Rosary(
            date: date,
            group_by: group_by,
            i_believe: i_believe,
            announce_1: announce_1,
            announce_2: announce_2,
            announce_3: announce_3,
            announce_4: announce_4,
            announce_5: announce_5),
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
    ExpandedTileController con1 = ExpandedTileController();
    ExpandedTileController con2 = ExpandedTileController();
    ExpandedTileController con3 = ExpandedTileController();
    ExpandedTileController con4 = ExpandedTileController();
    ExpandedTileController con5 = ExpandedTileController();

    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        title: Text("The Holy Rosary",
            softWrap: true,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 50,
                fontWeight: FontWeight.w700)),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      ),
      body: FutureBuilder(
        future: fetchRosary(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.front_hand_rounded,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              size: 50),
                          SizedBox(height: 10),
                          Text('The Lord welcomes you to a',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic)),
                          Text(
                              '${snapshot.data!.group_by} ${snapshot.data!.date}',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 50),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                              '${snapshot.data!.i_believe.replaceAll('\\n', '\n').replaceAll('\\r', '\r')}',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 16,
                              ))
                        ],
                      )),
                  Center(
                      child: Column(children: [
                    Text('The Five ${snapshot.data!.group_by} Mysteries',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    SizedBox(
                        width: 500,
                        child: ExpandedTile(
                            trailing: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            theme: ExpandedTileThemeData(
                              headerColor: Color.fromRGBO(33, 33, 33, 1),
                              contentBackgroundColor:
                                  Color.fromRGBO(255, 255, 255, 1),
                            ),
                            title: Text('${snapshot.data!.announce_1}',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            content: Text(
                                'In the sixth month the angel Gabriel was sent from God to a city of Galilee named Nazareth, to a virgin betrothed to a man whose name was Joseph, of the house of David; and the virgin\'s name was Mary.',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 33, 33, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            controller: con1)),
                    SizedBox(
                        width: 500,
                        child: ExpandedTile(
                            trailing: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            theme: ExpandedTileThemeData(
                              headerColor: Color.fromRGBO(33, 33, 33, 1),
                              contentBackgroundColor:
                                  Color.fromRGBO(255, 255, 255, 1),
                            ),
                            title: Text('${snapshot.data!.announce_2}',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            content: Text(
                                'In those days Mary arose and went with haste into the hill country, to a city of Judah, and she entered the house of Zechariah and greeted Elizabeth. And when Elizabeth heard the greeting of Mary, the babe leaped in her womb; and Elizabeth was filled with the Holy Spirit and she exclaimed with a loud cry, "Blessed are you among women, and blessed is the fruit of your womb!"',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 33, 33, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            controller: con2)),
                    SizedBox(
                        width: 500,
                        child: ExpandedTile(
                            trailing: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            theme: ExpandedTileThemeData(
                              headerColor: Color.fromRGBO(33, 33, 33, 1),
                              contentBackgroundColor:
                                  Color.fromRGBO(255, 255, 255, 1),
                            ),
                            title: Text('${snapshot.data!.announce_3}',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            content: Text(
                                'In those days a decree went out from Caesar Augustus that all the world should be enrolled. This was the first enrolment, when Quirinius was governor of Syria. And all went to be enrolled, each to his own city. And Joseph also went up from Galilee, from the city of Nazareth, to Judea, to the city of David, which is called Bethlehem, because he was of the house and lineage of David, to be enrolled with Mary, his betrothed, who was with child. And while they were there, the time came for her to be delivered. And she gave birth to her first-born son and wrapped him in swaddling cloths, and laid him in a manger, because there was no place for them in the inn',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 33, 33, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            controller: con3)),
                    SizedBox(
                        width: 500,
                        child: ExpandedTile(
                            trailing: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            theme: ExpandedTileThemeData(
                              headerColor: Color.fromRGBO(33, 33, 33, 1),
                              contentBackgroundColor:
                                  Color.fromRGBO(255, 255, 255, 1),
                            ),
                            title: Text('${snapshot.data!.announce_4}',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            content: Text(
                                'And at the end of eight days, when he was circumcised, he was called Jesus, the name given by the angel before he was conceived in the womb. And when the time came for their purification according to the law of Moses, they brought him up to Jerusalem to present him to the Lord (as it is written in the law of the Lord, "Every male that opens the womb shall be called holy to the Lord") and to offer a sacrifice according to what is said in the law of the Lord, "a pair of turtledoves, or two young pigeons"',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 33, 33, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            controller: con4)),
                    SizedBox(
                        width: 500,
                        child: ExpandedTile(
                            trailing: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            theme: ExpandedTileThemeData(
                              headerColor: Color.fromRGBO(33, 33, 33, 1),
                              contentBackgroundColor:
                                  Color.fromRGBO(255, 255, 255, 1),
                            ),
                            title: Text('${snapshot.data!.announce_5}',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                            content: Text(
                                'Now his parents went to Jerusalem every year at the feast of the Passover. And when he was twelve years old, they went up according to custom; and when the feast was ended, as they were returning, the boy Jesus stayed behind in Jerusalem. His parents did not know it ... After three days they found him in the temple, sitting among the teachers, listening to them and asking them questions; and all who heard him were amazed at his understanding and his answers',
                                style: TextStyle(
                                  color: Color.fromRGBO(33, 33, 33, 1),
                                  fontSize: 16,
                                )),
                            controller: con5)),
                  ])),
                  SizedBox(height: 50),
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("Crafted in the Lord's name by Keane Emanuel Dalisay.",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12,
                              fontStyle: FontStyle.italic)))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
