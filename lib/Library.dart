import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:octrees/DessinArbre.dart';
import 'ModelProvider.dart';
import 'Themes.dart';
import 'Themesprovider.dart';

/// Calcul de la hauteur de l'arbre à partir de la chaine représentant son univers
int treeLevel(String treeString){
  int levelNumber = 0;
  int i = 1;
  while(i<treeString.length){
    int countCurrentD = 0;
    int j = i;
    levelNumber ++;
    while(j < i+8 && j<treeString.length){
      if(treeString[j] == 'D'){
        countCurrentD ++;
      }
      j++;
    }
    if(countCurrentD > 1 ){
      i += ((countCurrentD-1) * 8) + 8;
    }else{
      i = j;
    }
  }
  return levelNumber;
}

/// Calcul de la longueur de coté minimal d'un arbre grâce à sa hauteur
int treeSide (int level){
  return pow(2 , level) as int;
}

/// retourne un l'elevatedButton crée grace à son titre et sa route passé en paramètres
SizedBox button(ThemeProvider themeProvider, BuildContext context, String texte, MaterialPageRoute route ) {
  return SizedBox(
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
            Navigator.of(context).push(route);
          },
          child: Center(child: Text(texte,  style: TextStyle(color: themeProvider.isDarkMode ? Colors.black : Colors.white,fontSize: 18))))
  );
}

/// retourne l'ElevatedButton crée grace au text et la fonction onPressedCallback
Widget buttonWithVerification({
  required String text,
  required VoidCallback onPressed,
  required ThemeProvider themeProvider,
}) {
  return SizedBox(
    height: 50,
    width: 170,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: themeProvider.isDarkMode ? Colors.black : Colors.white),
        ),
      ),
      onPressed: onPressed,
        child: Center(child: Text(text,  style: TextStyle(color: themeProvider.isDarkMode ? Colors.black : Colors.white,fontSize: 18)))
    ),
  );
}
/// retourne le FloatingActionButton crée grace au text et la fonction onPressedCallback
FloatingActionButton floatingActionButton(
    BuildContext context,
    String text,
    Icon icon,
    void Function() onPressedCallback,
 ThemeProvider themeProvider,
    ) {
  return FloatingActionButton(
    heroTag: UniqueKey(),
    onPressed: onPressedCallback,
    backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
    foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
    tooltip: text,
    child: icon,
  );
}

/// retourne le TextButton crée grace au text et la fonction onPressedCallback
Widget textButton(
    BuildContext context,
    String buttonText,
    VoidCallback onPressedCallback,
    ThemeProvider themeProvider,
    ) {
  return TextButton(
    onPressed: onPressedCallback,
    child: text(
      themeProvider,
      buttonText,
    ),
  );
}

///retourne le menu Tooltip contenant le bouton de passage au darkmode
Tooltip settingIcon(BuildContext context) {
  return Tooltip(
    message: 'Paramètre',
    child: IconButton(
      icon: const Icon(Icons.settings),
      color: Colors.white,
      onPressed: () {
        showMenu(
          context: context,
          position: const RelativeRect.fromLTRB(100, 100, 0, 0),
          items: [
             const PopupMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChangeThemeButtonWidget(),
                    Text(
                      "Mode claire"
                    ),
                  ]

              ),
            ),
          ],
        );
        //   prov.removeTree(index);
      },
    ),
  );
}

///
AnimatedTextKit texteAnime(String text) {
  return AnimatedTextKit(
    animatedTexts: [
      TypewriterAnimatedText(
        text,
        textStyle: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        speed: const Duration(milliseconds: 400),
      ),
    ],
    totalRepeatCount: 4,
    pause: const Duration(milliseconds: 500),
  );
}

IconButton retourEnArriere(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back),
    color: Colors.white,
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}

Text text(ThemeProvider themeProvider, String text) {
  return Text(
    text,
    style: TextStyle(
        color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        fontSize: 20),
  );
}

Text textError(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.red),
  );
}


Widget textField(
    String hintText,
    TextEditingController controller,
    void Function(String) onChanged,
    ) {
  return TextField(
    onChanged: onChanged,
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 30, 30, 30),
      border: const OutlineInputBorder(),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white),
    ),
  );
}
Widget zoomButton(String tooltip, Function onPressed, ThemeProvider themeProvider, DessinArbre da) {
  return FloatingActionButton(
    heroTag: tooltip,
    onPressed: () {
      onPressed(da);
    },
    tooltip: tooltip,
    backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
    foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
    child: Icon(tooltip == "Zoomer" ? Icons.zoom_in : Icons.zoom_out),
  );
}

PopupMenuItem popupMenuItem({
  required String label,
  required TextEditingController controller,
  required Function(String) onChanged,
  bool isTop = false,
  bool isBottom = false,
}) {
  return PopupMenuItem(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.only(
          topLeft: isTop ? Radius.circular(10.0) : Radius.zero,
          topRight: isTop ? Radius.circular(10.0) : Radius.zero,
          bottomLeft: isBottom ? Radius.circular(10.0) : Radius.zero,
          bottomRight: isBottom ? Radius.circular(10.0) : Radius.zero,
        ),
      ),
      child: ListTile(
        tileColor: Colors.black,
        leading: Text("$label : ", style: TextStyle(color: Colors.white)),
        title: TextField(
          keyboardType: TextInputType.numberWithOptions(
            decimal: false,
            signed: true,
          ),
          controller: controller,
          onChanged: onChanged,
        ),
      ),
    ),
  );
}

IconButton deleteButton(ThemeProvider themeProvider, BuildContext context, String treeName, ModelProvider prov, Function deleteTree, bool isAppBar) {
  return IconButton(
    icon: const Icon(Icons.delete),
    color: (!themeProvider.isDarkMode || isAppBar) ?  Colors.white : Colors.black ,
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: text(
              themeProvider,
              "Confirmation",
            ),
            backgroundColor:
            themeProvider.isDarkMode
                ? Colors.white
                : Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color:
                  themeProvider.isDarkMode
                      ? Colors.black
                      : Colors.white),
              borderRadius:
              BorderRadius.circular(10.0),
            ),
            content: text(
              themeProvider,
              "Etes-vous sûr de vouloir supprimer l'arbre : $treeName ?",
            ),
            actions: <Widget>[
              textButton(
                context,
                "Annuler",
                    () {
                  Navigator.of(context).pop();
                },
                themeProvider,
              ),
              textButton(
                context,
                "Confirmer",
                    () {
                  deleteTree(prov, treeName, context);
                },
                themeProvider,
              ),
            ],
          );
        },
      );
    },
  );
}




