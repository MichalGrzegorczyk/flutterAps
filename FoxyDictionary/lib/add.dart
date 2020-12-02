import 'dart:math';

import 'package:example_sqlite/dbhelper.dart';
import 'package:example_sqlite/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController wordController = new TextEditingController();
  TextEditingController definitionController = new TextEditingController();
  TextEditingController languageController = new TextEditingController();
  int imageId = Random().nextInt(9) + 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dodaj nowe słowo"),
        ),
        body: Column(
          children: [
            Text("słowo"),
            TextField(controller: wordController),
            Text("definicja"),
            TextField(controller: definitionController),
            Text("język"),
            TextField(controller: languageController),
            MaterialButton(
              onPressed: () {
                var helper = DbHelper();
                //helper.open();
                helper.insertEntry(new Entry(
                    id: 0,
                    word: wordController.text,
                    definition: definitionController.text,
                    imageId: imageId,
                    language: languageController.text));
                Navigator.pop(context);
              },
              child: Text("Dodaj"),
            )
          ],
        ));
  }
}
