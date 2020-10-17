import 'package:flutter/material.dart';
import 'package:note_app/providers/note.dart';
import 'package:note_app/screens/note_screen.dart';
import 'package:provider/provider.dart';

class NoteItemView extends StatelessWidget {
  final int index;

  const NoteItemView(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, NoteScreen.route, arguments: index),
        child: Consumer<Note>(
          builder: (context, note, child) => ListTile(
            title: Text(note.title),
            subtitle: Text(
              note.details,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
