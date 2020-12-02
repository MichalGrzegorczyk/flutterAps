import 'package:flutter/material.dart';
import 'package:example_sqlite/details.dart';
import 'dbhelper.dart';
import 'entry.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  DbHelper dbHelper = DbHelper();
  List<Entry> entries;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("lista słów")), body: buildListView());
  }

  ListView buildListView() {
    updateList();
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, i) => ListTile(
              title: Text(entries[i].word),
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DetailsScreen(entry: entries[i]))),
            ));
  }

  void updateList() {
    dbHelper.open().then((_) => dbHelper.getEntries().then((value) => {
          if (this.mounted)
            {
              setState(() {
                entries = value;
                count = entries.length;
              })
            }
        }));
  }
}
