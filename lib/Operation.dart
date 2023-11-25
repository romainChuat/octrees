import 'package:flutter/material.dart';
import 'package:octrees/Library.dart';
import 'package:octrees/Main.dart';
import 'package:provider/provider.dart';
import 'ModelProvider.dart';
import 'Octree.dart';
import 'Visualisation.dart';

class Operation extends StatefulWidget {
  const Operation({super.key});
  @override
  _OperationState createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  String dropDownValueOperation = 'Intersection';
  List<String> optionsOperation = ['Intersection', 'Union', 'Différence'];

  String dropDownValueTreeType = 'saisir mon arbre';
  List<String> optionsTreeType = ['saisir mon arbre', 'arbre aléatoire'];

  String title = "arbre 1";

  Octree octree1 = Octree();
  Octree octree2 = Octree();

  var modelProvider;

  TextEditingController _treeStringController1 = new TextEditingController();

  bool _showEmptyStringErrorMessage = false;
  bool _showInvalidStringErrorMessage = false;
  bool _showInvalidLengthStringError = false;

  bool showExecutButton = false;

  var textField1;

  @override
  void initState() {
    super.initState();
    textField1 = buildTextField(dropDownValueTreeType, _treeStringController1);
  }

  _handleInputChangeTree(String input, String type) {
    setState(() {
      _showEmptyStringErrorMessage = false;
      _showInvalidStringErrorMessage = false;
      _showInvalidLengthStringError = false;
      verifyString(input, type);
    });
  }

  Widget buildTextField(String dropDownValueTreeType, var controller) {
    if(dropDownValueTreeType == 'arbre aléatoire') {
      dropDownValueTreeType = 'saisir une longueur';
    }
    return TextField(
      decoration: InputDecoration(hintText: dropDownValueTreeType),
      controller: controller,
      onChanged: (text) {
        setState(() {
          _handleInputChangeTree(text, dropDownValueTreeType);
        });
      },
    );
  }

  bool verifyString(String text, String type) {
    String treeValue;
    treeValue = _treeStringController1.text;
    if (type != "saisir mon arbre") {
      bool valid = true;
      try {
        int treeLengthInt = int.parse(treeValue);
        if (((treeLengthInt & (treeLengthInt - 1)) != 0) ||
            treeLengthInt == 0) {
          valid = false;
        }
      } catch (e) {
        valid = false;
      }
      if (!valid || treeValue == "") {
        setState(() {
          _showInvalidLengthStringError = true;
        });
      }
      return valid;
    } else {
      if (treeValue == "") {
        setState(() {
          _showEmptyStringErrorMessage = true;
        });
        return false;
      }
      int countNbD = 0;
      for (int i = 0; i < treeValue.length; i++) {
        if (treeValue[i] == 'D') {
          countNbD++;
        }
      }
      int correctLength = countNbD * 8 + 1;
      if (treeValue.length == correctLength && (treeValue[0] == 'D' || correctLength == 1)) {
        bool valid = true;
        for (int i = 0; i < treeValue.length; i++) {
          if (treeValue[i] != 'P' &&
              treeValue[i] != 'V' &&
              treeValue[i] != 'D') {
            valid = false;
          }
        }
        if (!valid) {
          setState(() {
            _showInvalidStringErrorMessage = true;
          });
          return false;
        }
      } else {
        setState(() {
          _showInvalidStringErrorMessage = true;
        });
      }
      return true;
    }
  }

  Widget createBody(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Center(
        child: Column(
          children: [
            const Text('Vous avez choisi de réaliser une opération sur des arbres', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20,),
            Text(title, style: TextStyle(fontSize: 20),),
            const SizedBox(height: 20,),
            DropdownButton<String>(
                value: dropDownValueTreeType,
                items: optionsTreeType.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _showEmptyStringErrorMessage = false;
                    _showInvalidStringErrorMessage = false;
                    _showInvalidLengthStringError = false;
                    _treeStringController1.text = "";
                    dropDownValueTreeType = value!;
                    textField1 = buildTextField(
                        dropDownValueTreeType, _treeStringController1);
                  });
                }),
            textField1,
            if (_showEmptyStringErrorMessage)
              const Text("Veuillez saisir un arbre",style: TextStyle(color: Colors.red),),
            if (_showInvalidStringErrorMessage)
              const Text("Veuillez saisir un arbre valide",style: TextStyle(color: Colors.red),),
            if (_showInvalidLengthStringError)
              const Text("La longueur saisie doit être une puissance de 2",style: TextStyle(color: Colors.red),),
            const SizedBox(height: 20,),
            const Divider(color: Colors.white,thickness: 2, indent: 100 ,endIndent: 100,),
            const SizedBox(height: 20,),
            if (title == 'arbre 1') buildButton('Suivant'),
            if (title == 'arbre 2') buildButton('Précédent'),
            Visibility(
                visible: showExecutButton,
                child: Column(
                  children: [
                    DropdownButton<String>(
                        value: dropDownValueOperation,
                        items: optionsOperation.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropDownValueOperation = value!;
                          });
                        }),
                    buildButton('Executer'),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        String tree = _treeStringController1.text;
        _handleInputChangeTree(tree, dropDownValueTreeType);
        if ((_showInvalidStringErrorMessage || _showInvalidLengthStringError || _showEmptyStringErrorMessage) && buttonText != 'Précédent') {
          return;
        }
        if (title == 'arbre 1') {
          if (dropDownValueTreeType == 'saisir mon arbre') {
            int levelNumber = treeLevel(tree);
            int treeLength = treeSide(levelNumber);
            octree1 = Octree.fromChaine(tree, treeLength);
          } else {
            octree1 = Octree.aleatoire(int.parse(tree));
          }
          title = "arbre 2";
          showExecutButton = true;
          setState(() {});
        } else {
          if (buttonText == 'Précédent') {
            title = "arbre 1";
            showExecutButton = false;
            setState(() {});
          } else {
            switch (dropDownValueOperation) {
              case 'intersection':
                octree1 = octree1.intersection(octree2);
                break;
              case 'union':
                octree1 = octree1.union(octree2);
                break;
              case 'différence':
                octree1 = octree1.difference(octree2);
                break;
            }
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (
                      BuildContext context) => MyWorkingArea(octree: octree1, namePage: "generatePage")
                )
            );
          }
        }
        _treeStringController1.text = "";
      },
      child: Text(buttonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    modelProvider = context.watch<ModelProvider>();
    return Scaffold(appBar: createAppBar(), body: createBody(title));
  }
}
