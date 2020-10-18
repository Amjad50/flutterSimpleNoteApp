import 'package:flutter/material.dart';
import 'package:note_app/providers/note_list.dart';
import 'package:note_app/providers/note.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  static const String route = "/note";

  final int noteId;

  const NoteScreen(this.noteId, {Key key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Note _note;
  TextEditingController _detailsController;
  TextEditingController _titleController;

  void _updateNote() {
    _note.title = _titleController.text;
    _note.details = _detailsController.text;

    context.read<NoteListProvider>().updateNotesFile();
  }

  @override
  void initState() {
    super.initState();
    _note = context.read<NoteListProvider>().notes[widget.noteId];
    _detailsController = TextEditingController(text: _note.details);
    _titleController = TextEditingController(text: _note.title);

    _detailsController.addListener(_updateNote);
    _titleController.addListener(_updateNote);
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _note,
      child: Consumer<Note>(
        builder: (context, note, _) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                  ),
                  maxLines: 1,
                  controller: _titleController,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note",
                  ),
                  maxLines: null,
                  controller: _detailsController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
