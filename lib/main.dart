import 'package:flutter/material.dart';
import 'package:note_app/providers/note_list.dart';
import 'package:note_app/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NoteListProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Super Note',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
