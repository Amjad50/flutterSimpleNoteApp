import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/screens/note_screen.dart';
import 'package:note_app/screens/settings.dart';
import 'package:note_app/screens/start.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case StartScreen.route:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => StartScreen(),
        );
      case NoteScreen.route:
        if (routeSettings.arguments is int) {
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => NoteScreen(routeSettings.arguments),
          );
        }
        break;
      case SettingsScreen.route:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SettingsScreen(),
        );
      default:
        return getErrorRoute(routeSettings);
    }
    return getErrorRoute(routeSettings);
  }

  static Route<dynamic> getErrorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('An error ocurred',
                  style: Theme.of(context).textTheme.headline2),
              FlatButton(
                child: Text('GO BACK'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
