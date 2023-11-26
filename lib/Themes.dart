import 'package:flutter/material.dart';

/**
 *  ThemeProvider est une classe qui étend la classe ChangeNotifier de Flutter.
 * Elle permet de notifier les widgets lorsqu'il y a un changement de thème.
 */
class ThemeProvider extends ChangeNotifier {
  /// Représente le mode du thème actuel
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  /// Cette méthode 'toggleTheme' permet de basculer entre le thème sombre et le thème claire, selon ce que l'on passe dans le paramètre 'isOn'
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

/**
 * Cette classe permet de définir les deux thèmes (claire, sombre) que l'application peut utiliser.
 * Plus particulièrement elle définit les différente couleurs que l'on utilise dans l'application.
 *
 */

const PrimaryColor = const Color(0x00000000);
const PrimaryColorLight = const Color(0xFFFFFFFF);
const PrimaryColorDark = const Color(0x00000000);

const SecondaryColor = const Color(0xFFFFFFFF);
const SecondaryColorLight = const Color(0x00000000);
const SecondaryColorDark = const Color(0xFFFFFFFF);


class MyThemes {
  /// 'darkTheme' est une propriété static représentant le thèmes sombre.
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 58, 57, 57),
    colorScheme: const ColorScheme.light(
        brightness: Brightness.dark,
        primary: Colors.black
    ),
  );

  /// 'lightheme' est une propriété static représentant le thèmes clair.
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
        brightness: Brightness.dark,
        primary: Colors.white
    ),
  );
}
