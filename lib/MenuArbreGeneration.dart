import 'package:flutter/material.dart';
import 'package:octrees/Octree.dart';
import 'package:provider/provider.dart';
import 'package:octrees/Library.dart';
import 'Themes.dart';
import 'Visualisation.dart';

class MenuArbreGeneration extends StatefulWidget {
  const MenuArbreGeneration({super.key});

  @override
  State<MenuArbreGeneration> createState() => _MenuArbreGenerationState();
}

class _MenuArbreGenerationState extends State<MenuArbreGeneration> {
  final _treeStringController = TextEditingController();
  final _randomTreeStringController = TextEditingController();
  bool _showEmptyStringErrorMessage = false;
  bool _showInvalidStringErrorMessage = false;
  bool _showInvalidLengthStringError = false;

  void _handleInputChangeTree(String input) {
    setState(() {
      _showEmptyStringErrorMessage = false;
      _showInvalidStringErrorMessage = false;
      _showInvalidLengthStringError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: retourEnArriere(context),
        actions: [
          settingIcon(context),
        ],
      ),
      body: SingleChildScrollView(

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),

            text(
              themeProvider,
              "Vous avez choisi de générer un nouvel arbre, choisissez la manière :",
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
            textField('Saisir votre arbre', _treeStringController,
                _handleInputChangeTree),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
            buttonWithVerification(
                text: "Générer l'arbre",
                onPressed: () {
                  if (verifyTreeString()) {
                    String treeString = _treeStringController.text.trim();
                    int levelNumber = treeLevel(treeString);
                    int treeLength = treeSide(levelNumber);
                    Octree tree = Octree.fromChaine(treeString, treeLength);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyWorkingArea(
                          octree: tree,
                          namePage: "generatePage",
                        ),
                      ),
                    );
                  }
                },
                themeProvider: themeProvider),
            if (_showEmptyStringErrorMessage)
              textError("Veuillez saisir un arbre"),
            if (_showInvalidStringErrorMessage)
              textError("Veuillez saisir un arbre valide"),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
            text(
              themeProvider,
              "Vous avez choisi de générer un nouvel arbre, choisissez la manière :",
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
            textField("Longueur d'arbre aléatoire", _randomTreeStringController,
                _handleInputChangeTree),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
            buttonWithVerification(
                text: "Générer un arbre aléatoire",
                onPressed: () {
                  if (verifyLengthString()) {
                    Octree tree = Octree.aleatoire(
                        int.parse(_randomTreeStringController.text));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyWorkingArea(
                          octree: tree,
                          namePage: "generatePage",
                        ),
                      ),
                    );
                  }
                },
                themeProvider: themeProvider),
            if (_showInvalidLengthStringError)
              textError("La longueur saisie doit être une puissance de 2"),
          ],
        ),
      ),
    ),
    );
  }

  int countD(String tree) {
    int countNbD = 0;
    for (int i = 0; i < tree.length; i++) {
      if (tree[i] == 'D') {
        countNbD++;
      }
    }
    return countNbD;
  }

  bool verifyLengthString() {
    String treeLength = _randomTreeStringController.text;
    bool valid = true;
    try {
      int treeLengthInt = int.parse(treeLength);
      if (((treeLengthInt & (treeLengthInt - 1)) != 0) ||
          treeLengthInt == 0 ||
          treeLengthInt == 1) {
        valid = false;
      }
    } catch (e) {
      valid = false;
    }
    if (!valid) {
      setState(() {
        _showInvalidLengthStringError = true;
      });
    }
    return valid;
  }

  bool verifyTreeString() {
    String tree = _treeStringController.text;
    int countNbD = countD(tree);
    int correctLength = countNbD * 8 + 1;
    if (tree == "") {
      setState(() {
        _showEmptyStringErrorMessage = true;
      });
      return false;
    }
    if (tree.length != correctLength || (tree.length > 1 && tree[0] != 'D')) {
      setState(() {
        _showInvalidStringErrorMessage = true;
      });
      return false;
    }
    for (int i = 0; i < tree.length; i++) {
      if (tree[i] != 'P' && tree[i] != 'V' && tree[i] != 'D') {
        setState(() {
          _showInvalidStringErrorMessage = true;
        });
        return false;
      }
    }
    return true;
  }
}
