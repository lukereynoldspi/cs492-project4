import 'package:flutter/material.dart';

class JournalEntry extends StatelessWidget {
  String title;
  String body;
  int rating;
  String date;

  JournalEntry({
    super.key,
    required this.title,
    required this.body,
    required this.rating,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          direction: Axis.vertical,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                body,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                date,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ]),
          ],
        ));
  }
}
