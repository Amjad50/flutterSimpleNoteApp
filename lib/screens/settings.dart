import 'package:flutter/material.dart';
import 'package:note_app/providers/theme.dart';
import 'package:provider/provider.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final bool head;

  const HeaderText(
    this.text, {
    Key key,
    this.head = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(
        top: head ? 16 : 0,
        left: 16,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  static const String route = '/settings';

  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeIndex;

  @override
  void initState() {
    super.initState();
    _themeIndex = context.read<ThemeProvider>().themeMode;
  }

  void _changeTheme(ThemeMode theme) {
    if (theme != _themeIndex) {
      setState(() {
        _themeIndex = theme;
      });
      context.read<ThemeProvider>().themeMode = theme;
    }

    Navigator.of(context).pop();
  }

  String _getCurrentThemeName() {
    switch (_themeIndex) {
      case ThemeMode.dark:
        return "Dark";
      case ThemeMode.system:
        return "System";
      case ThemeMode.light:
        return "Light";
    }
    return "??";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          HeaderText("DISPLAY"),
          ListTile(
            title: Text("Theme"),
            trailing: Text(_getCurrentThemeName()),
            onTap: () => showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: Text("Choose Theme"),
                children: [
                  RadioListTile(
                    title: Text("Light"),
                    value: ThemeMode.light,
                    groupValue: _themeIndex,
                    onChanged: (value) => _changeTheme(value),
                  ),
                  RadioListTile(
                    title: Text("Dark"),
                    value: ThemeMode.dark,
                    groupValue: _themeIndex,
                    onChanged: (value) => _changeTheme(value),
                  ),
                  RadioListTile(
                    title: Text("System"),
                    value: ThemeMode.system,
                    groupValue: _themeIndex,
                    onChanged: (value) => _changeTheme(value),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
