import 'package:date/Themes/dark-yellow.theme.dart';
import 'package:date/Themes/dark.theme.dart';
import 'package:date/Themes/light.theme.dart';
import 'package:date/Themes/pink-dark.theme.dart';
import 'package:date/Themes/pink.theme.dart';
import 'package:date/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends ChangeNotifier {
  var theme = lightTheme();

  ThemeBloc() {
    load();
  }

  change(String color) {
    switch (color) {
      case 'light':
        {
          alterarThema("light", lightTheme());
          break;
        }

      case 'dark':
        {
          alterarThema("dark", darkTheme());
          break;
        }

      case 'dark-yellow':
        {
          alterarThema("dark-yellow", darkYellowTheme());
          break;
        }
      case 'pink':
        {
          alterarThema("pink", pinkTheme());
          break;
        }
      case 'pink-dark':
        {
          alterarThema("pink-dark", pinkDarkTheme());
          break;
        }

      default:
        {
          alterarThema("light", lightTheme());
          break;
        }
    }
  }

  alterarThema(String nomeTema, ThemeData tema) {
    theme = tema;
    Settings.theme = nomeTema;
    save();
    notifyListeners();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', Settings.theme);
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('theme');
    Settings.theme = theme?.isEmpty ?? false ? 'light' : theme;
    change(Settings.theme);
  }
}
