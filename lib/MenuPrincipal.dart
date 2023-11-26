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
                text(
                  themeProvider,
                  "Veuillez choisir ce que vous voulez faire :",
                ),

                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 75)),
                /// Bouton redirigeant vers la page de generation d'un nouvel octree
                SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white))),
                        onPressed: () {
                          /// redirection vers la page MenuArbreGeneration
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const MenuArbreGeneration()));
                        },
                        child: Center(child: Text("Générer",  style: TextStyle(color: themeProvider.isDarkMode ? Colors.black : Colors.white,fontSize: 18))))
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                /// bouton redirigeant vers la page de selection des octrees crées
                SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white))),
                        onPressed: () {
                          /// redirection vers la page MenuArbreSauvegarde
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const MenuArbreSauvegarde()));
                        },
                        child: Center(child: Text("Visualiser",  style: TextStyle(color: themeProvider.isDarkMode ? Colors.black : Colors.white,fontSize: 18))))
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                /// bouton redirigeant vers la page permettant des operations entre arbre
                SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white))),
                        onPressed: () {
                          /// redirection vers la page Operation
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => const Operation()));
                        },
                        child: Center(child: Text("Opération",  style: TextStyle(color: themeProvider.isDarkMode ? Colors.black : Colors.white,fontSize: 18))))
                )

              ],
            )
          ],
        )),
      ),
    );
  }
}
