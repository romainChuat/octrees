import 'package:flutter/material.dart';
import 'package:octrees/MenuArbreSauvegarde.dart';
import 'package:provider/provider.dart';
import 'Library.dart';
import 'MenuArbreGeneration.dart';
import 'Operation.dart';
import 'Themes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          settingIcon(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 75)),
            texteAnime("Bienvenue"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 75)),
                Text(
                  "Veuillez choisir ce que vous voulez faire :",
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      fontSize: 20),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 75)),
                button(
                    themeProvider,
                    context,
                    "Générer",
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MenuArbreGeneration())),
                const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                button(
                    themeProvider,
                    context,
                    "Visualiser",
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MenuArbreSauvegarde())),
                const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                button(
                    themeProvider,
                    context,
                    "Opération",
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Operation())),
              ],
            )
          ],
        )),
      ),
    );
  }
}
