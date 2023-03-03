import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:journal_app/screens/home_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'journal_entry.dart';

class JournalEntryList extends StatelessWidget {
  const JournalEntryList({super.key});

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
                body: "John Cena, your mom, deez nuts",
                rating: 1,
                date: "Friday 12, May 2098"),
            JournalEntry(
                title: "List of food I need to eat",
                body: "John Cena, your mom, deez nuts",
                rating: 1,
                date: "adiadhuadiauid"),
          ]),
        ),
      ),
    );
  }
}
