import 'package:flutter/material.dart';
import 'package:octrees/MenuArbreSauvegarde.dart';
import 'package:octrees/MenuArbreSauvegarde.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'MenuArbreGeneration.dart';
import 'Operation.dart';
import 'Themesprovider.dart';
import 'Themes.dart';
import 'package:stroke_text/stroke_text.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

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
          Tooltip(
            message: 'Paramètre',
            child: IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        const ChangeThemeButtonWidget(),
                      Text(
                        "Mode sombre",
                      ),
                ]

                      ),
                    ),
                  ],
                );
                //   prov.removeTree(index);
              },
            ),
          ),
        ],
      ),
      //appBar: AppBar(title: Text('Des cubes !!! Rien que des cubes !!')),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Bienvenue',
                    textStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      color: Colors.black),
                    speed: const Duration(milliseconds: 400),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 500),
                // TODO ajouter un texte plus explicatif en dessous de bienvenue
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 200)),
                  SizedBox(
                      height: 50,
                      width: 200,
                      // TODO factoriser le désign des boutons de l'ensemble des classes
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => MenuArbreGeneration()));
                          },
                          child: Text('Générer',  style: TextStyle(color: themeProvider.isDarkMode ? Colors.black : Colors.white,fontSize: 18)))),

                  const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => MenuArbreSauvegarde()));
                        },
                        style: ElevatedButton.styleFrom(
                            //backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white))),
                        child: const Text('Visualiser')),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Operation()));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white))),
                        child: const Text('Opération')),
                  )
                ],
              )
              /*Expanded(
                  child: MyWorkingArea()
              ),*/
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.picture_as_pdf),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}