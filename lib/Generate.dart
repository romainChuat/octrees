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
        actions: [
          Tooltip(
            message: 'Paramètre',
            child: IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                // TODO ajouter des parametres dans l'icon settings
              },
            ),
          ),
        ],
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Colors.white)
                      )
                  ),
                  onPressed: () {
                    if (verifyTreeString() == true) {
                      String treeString = _treeStringController.text.trim();
                      /**
                       * TODO  calculer le nombre de coté !!!!!
                       **/
                      Octree tree = new Octree.fromChaine(treeString, 16); /// TODO  calculer le nombre de coté !!!!! Pas toujours égale à 16
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MyWorkingArea(octree: tree, namePage: "generatePage",)));
                    }
                  },
                  child: const Text("Générer l'arbre "),
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
                        Octree tree = Octree.aleatoire(int.parse(_randomTreeStringController.text));
                        String name = "";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MyWorkingArea(octree: tree, namePage: "generatePage")));
                        print(modelProvider.getOctree(name).toString());
                      }
                    },
                    child: const Text("Génerer un arbre aléatoire"))),
            if (_showInvalidLengthStringError)
              const Text(
                "La longueur saisie doit être une puissance de 2",
                style: TextStyle(color: Colors.red),
              ),
          ])),
    );
  }
  bool verifyLengthString() {
    String treeLength = _randomTreeStringController.text;
    bool valid = true;
    try{
      int treeLengthInt = int.parse(treeLength);
      if( ((treeLengthInt & (treeLengthInt - 1)) != 0 ) || treeLengthInt == 0 ){
        valid = false;
      }
    } catch (e){
        valid = false;
    }
    if(!valid){
      setState(() {
        _showInvalidLengthStringError = true;
      });
    }
    return valid;
  }
  bool verifyTreeString() {
    String tree = _treeStringController.text;
    int countNbD = 0;
    for(int i = 0; i < tree.length; i++ ){
      if(tree[i] == 'D'){
        countNbD++;
      }
    }
    int correctLength = countNbD * 8 +1;
    if (tree == "" || tree.length != correctLength  || tree[0] != 'D') {
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