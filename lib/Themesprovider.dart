import 'package:flutter/material.dart';
import 'package:octrees/Themes.dart';

import 'package:provider/provider.dart';

// Cette classe étend la classe "StatelessWidget".
// Cette dernièree est responsable de l'affichage d'un bouton de changement de thème.
class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // On recupere une instance de 'ThemeProvider'
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Le Widget Switch permet à l'utilisateur de basculer entre un mode clair et un mode sombre.
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      // A chaque Switch appeler 'onChanged' et appelé, et suite à la recuperation du 'ToggleTheme'
      // La mise à jour du thème est faite
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
