import 'package:example_sqlite/add.dart';
import 'package:example_sqlite/dbhelper.dart';
import 'package:example_sqlite/listview.dart';
import 'package:example_sqlite/details.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

import 'entry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foxy Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Foxy Dictionary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper dbHelper = DbHelper();
  List<Entry> entries;
  int count = 0;
  int _counter = 1;
  String test = "0";
  String word = "";
  String definition = "";

  void _incrementCounter() {
    if (_counter < entries.length) {
      _counter++;
    } else
      _counter = 10;
    updateList();
  }

  void _decrementCounter() {
    if (_counter > 1) {
      _counter--;
    } else
      _counter = 1;
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    addWords();
    updateList();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddScreen()),
              ),
            ),
            IconButton(
                icon: new Icon(Icons.format_list_bulleted_rounded),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListViewScreen()))),
            IconButton(
              icon: new Icon(Icons.info),
              onPressed: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(entry: entries[_counter]))),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            entries[_counter].word,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      )),
                  Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          word = entries[_counter].definition;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$word',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Text(entries[_counter].language),
              SwipeDetector(
                child: Image.asset(
                    'assets/images/' +
                        entries[_counter].imageId.toString() +
                        ".jpg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    fit: BoxFit.fitWidth),
                onSwipeLeft: _decrementCounter,
                onSwipeRight: () {
                  _incrementCounter();
                },
              )
            ],
          ),
        ));
  }

  void addWords() {
    dbHelper.insertEntry(new Entry(
        id: 0,
        word: "fox",
        definition: "lis",
        imageId: 1,
        language: "angielski"));

    dbHelper.insertEntry(new Entry(
        id: 1,
        word: "kettu",
        definition: "lis",
        imageId: 2,
        language: "fiński"));

    dbHelper.insertEntry(new Entry(
        id: 2,
        word: "lisica",
        definition: "lis",
        imageId: 3,
        language: "chorwacki  "));

    dbHelper.insertEntry(new Entry(
        id: 3,
        word: "Fuchs",
        definition: "lis",
        imageId: 4,
        language: "niemiecki"));

    dbHelper.insertEntry(new Entry(
        id: 4,
        word: "Volpe",
        definition: "lis",
        imageId: 5,
        language: "włoski"));

    dbHelper.insertEntry(new Entry(
        id: 5, word: "狐", definition: "lis", imageId: 6, language: "japoński"));

    dbHelper.insertEntry(new Entry(
        id: 6,
        word: "zorro",
        definition: "lis",
        imageId: 7,
        language: "hiszpański"));

    dbHelper.insertEntry(new Entry(
        id: 7,
        word: "Renard",
        definition: "lis",
        imageId: 8,
        language: "francuski"));

    dbHelper.insertEntry(new Entry(
        id: 8,
        word: "guineu",
        definition: "lis",
        imageId: 9,
        language: "kataloński"));

    dbHelper.insertEntry(new Entry(
        id: 9,
        word: "лиса",
        definition: "lis",
        imageId: 1,
        language: "rosyjski"));
  }

  void updateList() {
    dbHelper.open().then((_) => dbHelper.getEntries().then((value) => {
          setState(() {
            entries = value;
            count = entries.length;
          })
        }));
  }
}
