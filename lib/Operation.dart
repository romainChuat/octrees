import 'package:flutter/material.dart';
import 'package:octrees/Library.dart';
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

  int clicked = -1;

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
    if (dropDownValueTreeType == 'arbre aléatoire') {
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
            treeLengthInt == 0 || treeLengthInt == 1) {
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
      if (treeValue.length == correctLength &&
          (treeValue[0] == 'D' || correctLength == 1)) {
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
            const Text(
                'Vous avez choisi de réaliser une opération sur des arbres',
                style: TextStyle(fontSize: 15)),
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
              const Text("Veuillez saisir un arbre",
                style: TextStyle(color: Colors.red),),
            if (_showInvalidStringErrorMessage)
              const Text("Veuillez saisir un arbre valide",
                style: TextStyle(color: Colors.red),),
            if (_showInvalidLengthStringError)
              const Text("La longueur saisie doit être une puissance de 2",
                style: TextStyle(color: Colors.red),),
            const SizedBox(height: 20,),
            const Text("ou"),
            const SizedBox(height: 20,),
            const Text("Selectionné parmis vos arbre enregistrés : "),
            const SizedBox(height: 20,),
            Container(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: modelProvider.trees.length,
                itemBuilder: (BuildContext context, int index) {
                  final treeName = modelProvider.trees.keys.elementAt(index);
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                if(clicked != index){
                                  _treeStringController1.text = "";
                                  if(title == 'arbre 1'){
                                    octree1 = modelProvider.getByIndex(index);
                                  }else{
                                    octree2 = modelProvider.getByIndex(index);
                                  }
                                  clicked = index;
                                }else{
                                  clicked = -1;
                                  octree1 = Octree();
                                }

                              },
                              child: Center(child: Text(treeName)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: clicked == index ? Colors.green : Colors.black ,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      side: BorderSide(color: Colors.white)))),
                        ),

                      ]
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
              ),
            ),
            const Divider(color: Colors.white, thickness: 2, indent: 100, endIndent: 100,),
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
        /// Si il y a une erreur ou qu'aucun arbre n'est selectionné
        if(clicked == -1){
          if (((_showInvalidStringErrorMessage || _showInvalidLengthStringError ||
              _showEmptyStringErrorMessage )) && buttonText != 'Précédent' ) {
            return;
          }
        }
        if (title == 'arbre 1') {
          if(clicked == -1 ){
            if (dropDownValueTreeType == 'saisir mon arbre') {
              int levelNumber = treeLevel(tree);
              int treeLength = treeSide(levelNumber);
              octree1 = Octree.fromChaine(tree, treeLength);
              print("octree1 $tree" );
            } else {
              octree1 = Octree.aleatoire(int.parse(tree));
            }
          }
          title = "arbre 2";
          showExecutButton = true;
          setState(() {});
          clicked = -1;
        } else {
          if (buttonText == 'Précédent') {
            title = "arbre 1";
            showExecutButton = false;
            clicked = -1;
            setState(() {});

          } else {
            if(clicked == -1){
              if(dropDownValueTreeType == 'saisir mon arbre'){
                int levelNumber = treeLevel(tree);
                int treeLength = treeSide(levelNumber);
                octree2 = Octree.fromChaine(tree, treeLength);

              }else{
                octree2 = Octree.aleatoire(int.parse(tree));
              }
              clicked = -1;
            }
            switch (dropDownValueOperation) {
              case 'Intersection':
                octree1 = octree1.intersection(octree2);
                break;
              case 'Union':
                octree1 = octree1.union(octree2);
                break;
              case 'Différence':
                octree1 = octree1.difference(octree2);
                break;
            }
            print(octree1.decompile(octree1.univers));

            int levelNumber = treeLevel(octree1.decompile(octree1.univers));
            int treeLength = treeSide(levelNumber);
            Octree res = Octree.fromChaine(octree1.decompile(octree1.univers), treeLength);
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MyWorkingArea(octree: res, namePage: "generatePage")
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
    modelProvider.getAllTrees();

    return Scaffold(appBar: createAppBar(), body: createBody(title));
  }
}
