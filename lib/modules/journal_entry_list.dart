import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:journal_app/screens/home_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'journal_entry.dart';

class JournalEntryList extends StatefulWidget {
  const JournalEntryList({super.key});
  @override
  State<JournalEntryList> createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final Database database = await openDatabase('../journal/sqlite3.db',
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);');
    });
    List<Map> journalRecords =
        await database.rawQuery('SELECT * FROM journal_entries;');
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          date: record['date']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(children: [
            JournalEntry(
                title: "List of people I need to meet",
                body: "John Cena, Billy Mays, Phil Swift",
                rating: 1,
                date: " Friday 12, May 2098"),
            JournalEntry(
                title: "List of food I need to eat",
                body: "Tacos, rice, salmon",
                rating: 1,
                date: " Friday 12, May 2098"),
          ]),
        ),
      ),
    );
  }
}
