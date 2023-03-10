import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'new_entry_screen.dart';
import '../main.dart';
import '../modules/journal_entry_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
        ),
        body: Container(
          child: const JournalEntryList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const NewEntry();
                },
              ),
            );
          },
        ),
        endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const ListTile(
                title: Text('Settings'),
              ),
              const Divider(
                color: Color.fromARGB(255, 0, 0, 0), //color of divider
                height: 5, //height spacing of divider
                thickness: 1, //thickness of divier line
                indent: 0, //spacing at the start of divider
                endIndent: 0, //spacing at the end of divider
              ),
              ListTile(
                title: const Text('Dark Mode'),
                onTap: () {
                  MyApp.of(context).changeTheme(ThemeMode.dark);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
