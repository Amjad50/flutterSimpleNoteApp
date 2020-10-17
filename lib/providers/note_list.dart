import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:note_app/providers/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteListProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  Future<File> get notesFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/notes.json");
  }

  Future<void> _initNotes() async {
    File _notesFile = await notesFile;

    if (await _notesFile.exists()) {
      _notesFile.readAsString().then((notesJson) {
        try {
          _notes.addAll((jsonDecode(notesJson) as List<dynamic>)
              .map((e) => Note.fromJson(e)));
          notifyListeners();
        } on FormatException {
          // ignore, meaning that `_note` will be empty
        }
      });
    } else {
      _notesFile.create();
    }
  }

  NoteListProvider() {
    _initNotes();
  }

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  int createNewNote() {
    _notes.add(Note());

    notifyListeners();

    return notes.length - 1;
  }

  Future<void> updateNotesFile() async {
    String notesJson = jsonEncode(notes);
    (await notesFile).writeAsString(notesJson);
    print("writing to file $notesJson");
  }
}
