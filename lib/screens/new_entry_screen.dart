import 'package:flutter/material.dart';
import 'package:journal_app/screens/home_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const MaterialApp(
      home: NewEntry(),
    ),
  );
}

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});
  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final ratingController = TextEditingController();
  String title = "";
  String body = "";
  int rating = 0;
  String date = "";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    bodyController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'New Journal Entry';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Body',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: ratingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rating (1-4)',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const HomeScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () async {
                    setState(() {
                      title = titleController.text;
                      body = bodyController.text;
                      rating = int.parse(ratingController.text);
                      date =
                          DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
                    });
                    await deleteDatabase('../data/journal/sqlite3.db');
                    final Database database = await openDatabase(
                        '../data/journal/sqlite3.db',
                        version: 1, onCreate: (Database db, int version) async {
                      await db.execute(
                          'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);');
                    });
                    await database.transaction((txn) async {
                      await txn.rawInsert(
                          'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)',
                          [title, body, rating, date]);
                    });
                    await database.close();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const HomeScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
