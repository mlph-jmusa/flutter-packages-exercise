import 'package:flutter/material.dart';
import 'dart:convert';
import 'website.dart';
import 'package:flutter/material.dart';
import './websiteView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter packages'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const WebsitesList(),
    );
  }
}

class WebsitesList extends StatefulWidget {
  const WebsitesList({Key? key}) : super(key: key);

  @override
  _WebsitesListState createState() => _WebsitesListState();
}

class _WebsitesListState extends State<WebsitesList> {
  List<Website> websites = [];

  getData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("lib/resources/websites.json");
    var jsonData = jsonDecode(data);

    websites = jsonData
        .map<Website>(
            (data) => Website(data["name"], data["url"], data["thumbnail_url"]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) => ListView.separated(
            itemBuilder: (context, row) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebsiteView(
                                website: websites[row],
                                dateTimeOpened: DateTime.now())));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.network(websites[row].thumbnailURL,
                                width: 80, height: 80),
                            Container(width: 15),
                            Text(websites[row].name)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, row) =>
                Container(height: 1, color: Colors.black),
            itemCount: websites.length));
  }
}
