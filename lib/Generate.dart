

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

class GenerateState extends State<Generate>{

  var _textFieldController = TextEditingController();
  bool _showEmptyStringErrorMessage = false;
  bool _showInvalidStringErrorMessage = false;


  void _handleInputChangeTree(String input) {
    setState(() {
      _showEmptyStringErrorMessage = false;
      _showInvalidStringErrorMessage = false;
    });
  }
  Widget buildTextField(){
    return TextField(
      onChanged: _handleInputChangeTree,
      controller: _textFieldController,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 30, 30, 30),
          border: OutlineInputBorder(),
          hintText: 'Saisir votre arbre',
          hintStyle: TextStyle(color: Colors.white)
      ),
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                const Text(
                  "Vous avez choisis de généré un nouvel arbre, choisissez la manière :",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0,50)),
                buildTextField(),

                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                SizedBox(
                    height: 40,
                    width: 150,
                    child : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(color: Colors.white)
                          )
                      ),
                      onPressed: (){
                        if(verifyTreeString() == true){
                          String treeString = _textFieldController.text.trim();
                          modelProvider.addTree(treeString);
                          int sizeTree = modelProvider.getTreeSize();

                          Octree tree = new Octree.fromChaine(treeString,treeString.length);
                          print(tree.toString());
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) => MyWorkingArea(index: sizeTree) )
                          );
                        }
                      },
                      child: const Text("Générer l'arbre"),
                    )
                ),
                if (_showEmptyStringErrorMessage)
                  const Text("Veuillez saisir un arbre", style: TextStyle(color: Colors.red),),
                if(_showInvalidStringErrorMessage)
                  const Text("Veuillez saisir un arbre valide", style: TextStyle(color: Colors.red),),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                const Text(
                  "ou",
                  style: TextStyle(color: Colors.white, fontSize: 18),

                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),

                SizedBox(
                    height: 40,
                    child : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Colors.white)
                            )
                        ),
                        onPressed: (){
                          // TODO générer un arbre aléatoire
                        },
                        child: Text("Génerer un arbre aléatoire")
                    )
                )

              ]
          )
      ),
    );


  }
  bool verifyTreeString() {
    String tree = _textFieldController.text;
    if (tree == "") {
      setState(() {
        _showEmptyStringErrorMessage = true;
      });
      return false;
    }
    bool valid = true;
    for(int i = 0; i< tree.length; i++){
      if(tree[i] != 'P'&& tree[i] != 'V' && tree[i] !='D'){
        valid = false;
      }
    }
    if(!valid) {
      setState(() {
        _showInvalidStringErrorMessage = true;
      });
      return false;
    }
    return true;
  }



}