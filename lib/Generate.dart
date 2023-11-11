import 'dart:math';

import 'package:flutter/material.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:octrees/Octree.dart';
import 'package:octrees/main.dart';
import 'package:provider/provider.dart';

class Generate extends StatefulWidget {
  const Generate({super.key});

  @override
  State<Generate> createState() => GenerateState();
}

class GenerateState extends State<Generate> {
  var _treeStringController = TextEditingController();
  var _randomTreeStringController = TextEditingController();
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

  Widget buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      onChanged: _handleInputChangeTree,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 30, 30, 30),
          border: OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var modelProvider = context.watch<ModelProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "Vous avez choisis de généré un nouvel arbre, choisissez la manière :",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
        buildTextField('Saisir votre arbre', _treeStringController),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
        SizedBox(
            height: 40,
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                if (verifyTreeString() == true) {
                  String treeString = _treeStringController.text.trim();
                  /**
                   * TODO vérification longueur valide
                   * +TODO  calculer le nombre de coté
                   **/
                  print(treeString);
                  Octree tree = new Octree.fromChaine(treeString, 16);
                  modelProvider.addTree(
                      "name_" + Random().nextInt(100000).toString(), tree);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyWorkingArea(octree: tree)));
                }
              },
              child: const Text("Générer l'arbre"),
            )),
        if (_showEmptyStringErrorMessage)
          const Text(
            "Veuillez saisir un arbre",
            style: TextStyle(color: Colors.red),
          ),
        if (_showInvalidStringErrorMessage)
          const Text(
            "Veuillez saisir un arbre valide",
            style: TextStyle(color: Colors.red),
          ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
        const Text(
          "ou",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
        buildTextField(
            "Longueur d'arbre aléatoire", _randomTreeStringController),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
        SizedBox(
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  if (verifyLengthString() == true) {
                    /**
                     *TODO vérification longueur valide doit être un puissance de 2
                     **/
                    Octree tree = new Octree.aleatoire(
                        int.parse(_randomTreeStringController.text));
                    String name = "name_" + Random().nextInt(100000).toString();
                    modelProvider.addTree(name, tree);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MyWorkingArea(octree: tree)));
                    print(modelProvider.getOctree(name).toString());
                  }
                },
                child: const Text("Génerer un arbre aléatoire"))),
        if (_showInvalidLengthStringError)
          const Text(
            "Veuillez saisir une longueur valide",
            style: TextStyle(color: Colors.red),
          ),
      ])),
    );
  }

  bool verifyLengthString() {
    String treeLength = _randomTreeStringController.text;
    final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(treeLength)) {
      setState(() {
        _showInvalidLengthStringError = true;
      });
      return false;
    }
    return true;
  }

  bool verifyTreeString() {
    String tree = _treeStringController.text;
    if (tree == "") {
      setState(() {
        _showEmptyStringErrorMessage = true;
      });
      return false;
    }
    bool valid = true;
    for (int i = 0; i < tree.length; i++) {
      if (tree[i] != 'P' && tree[i] != 'V' && tree[i] != 'D') {
        valid = false;
      }
    }
    if (!valid) {
      setState(() {
        _showInvalidStringErrorMessage = true;
      });
      return false;
    }
    return true;
  }
}
