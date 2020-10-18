import 'package:flutter/material.dart';
import 'package:note_app/providers/note_list.dart';
import 'package:note_app/providers/note.dart';
import 'package:note_app/screens/note_screen.dart';
import 'package:note_app/screens/settings.dart';
import 'package:note_app/views/note_item.dart';
import 'package:provider/provider.dart';

const _actionsRoutes = {
  'Settings': SettingsScreen.route,
};

class StartScreen extends StatefulWidget {
  static const String route = "/";

  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void _createNewNote(BuildContext context) {
    var noteId = context.read<NoteListProvider>().createNewNote();

    Navigator.pushNamed(context, NoteScreen.route, arguments: noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Note"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              for (final item in _actionsRoutes.keys)
                PopupMenuItem(child: Text(item), value: item),
            ],
            onSelected: (value) {
              Navigator.pushNamed(context, _actionsRoutes[value]);
            },
          )
        ],
      ),
      body: Consumer<NoteListProvider>(
        builder: (context, notelist, _) {
          return ListView.separated(
            itemBuilder: (context, index) => ChangeNotifierProvider<Note>.value(
              value: notelist.notes[index],
              key: ValueKey(notelist.notes[index]),
              child: NoteItemView(index),
            ),
            itemCount: notelist.notes.length,
            separatorBuilder: (context, index) => Divider(
              height: 0,
              thickness: 1,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewNote(context),
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
