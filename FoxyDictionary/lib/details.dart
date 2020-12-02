import 'package:flutter/material.dart';

import 'dbhelper.dart';
import 'entry.dart';

class DetailsScreen extends StatelessWidget {
  final Entry entry;

  DetailsScreen({this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(entry.word)),
        body: Column(children: [
          Text(
            entry.word,
            textScaleFactor: 2,
          ),
          Text(entry.definition),
          MaterialButton(
            onPressed: () {
              var helper = DbHelper();
              helper.deleteEntry(entry);

              Navigator.pop(context);
            },
            child: Text("Usuń"),
          )
        ]));
  }
}
