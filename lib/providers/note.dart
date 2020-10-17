import 'package:flutter/widgets.dart';

class Note with ChangeNotifier {
  String _title;
  String _details;

  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get details => _details;
  set details(String value) {
    _details = value;
    notifyListeners();
  }

  Note({title = "", details = ""})
      : _title = title,
        _details = details;

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(title: json['title'], details: json['details']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'details': details,
    };
  }
}
