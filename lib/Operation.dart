import 'package:flutter/material.dart';
import 'package:octrees/library.dart';
import 'package:octrees/main.dart';
import 'Octree.dart';

class Operation extends StatefulWidget {
  const Operation({super.key});
  @override
  _OperationState createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  String dropDownValueOperation = 'Intersection';
  List<String> optionsOperation = ['Intersection', 'Union', 'Différence'];

  String dropDownValueTreeType1 = 'saisir mon arbre';
  String dropDownValueTreeType2 = 'saisir mon arbre';

  List<String> optionsTreeType = ['saisir mon arbre', 'arbre aléatoire'];

  Octree octree1 = Octree();
  Octree octree2 = Octree();

  TextEditingController _treeStringController1 = new TextEditingController();
  TextEditingController _treeStringController2 = new TextEditingController();
  TextEditingController _treeLengthController1 = new TextEditingController();
  TextEditingController _treeLengthController2 = new TextEditingController();

  bool _showEmptyStringErrorMessage = false;
  bool _showInvalidStringErrorMessage = false;
  bool _showInvalidLengthStringError = false;

  bool _showEmptyStringErrorMessage2 = false;
  bool _showInvalidStringErrorMessage2 = false;
  bool _showInvalidLengthStringError2 = false;

  var textField1;
  var textField2;

  @override
  void initState() {
    super.initState();
    textField1 =buildTextField(dropDownValueTreeType1, _treeStringController1, 1);
    textField2 =buildTextField(dropDownValueTreeType2, _treeLengthController2, 2);
  }

  _handleInputChangeTree(String input, String type, int id) {
    setState(() {
      _showEmptyStringErrorMessage = false;
      _showInvalidStringErrorMessage = false;
      _showInvalidLengthStringError = false;
      _showEmptyStringErrorMessage2 = false;
      _showInvalidStringErrorMessage2 = false;
      _showInvalidLengthStringError2 = false;
      verifyString(input, type, id);
    });
  }

  Widget buildTextField(String dropDownValueTreeType, var controller,int id) {
    return TextField(
      decoration: InputDecoration(hintText: dropDownValueTreeType),
      controller: controller,
      onChanged: (text) {
        setState(() {
          _handleInputChangeTree(text, dropDownValueTreeType, id);
        });
      },
    );
  }

  bool verifyString(String text, String type, int id) {
    String treeValue;
    if(id == 1){
      treeValue = _treeLengthController1.text;
    }else{
      treeValue = _treeLengthController2.text;
    }

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
      if( treeValue == ""){
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
      if (treeValue.length == correctLength && (treeValue[0] == 'D' || correctLength == 1 )  ) {
        bool valid = true;
        for (int i = 0; i < treeValue.length; i++) {
          if (treeValue[i] != 'P' && treeValue[i] != 'V' && treeValue[i] != 'D') {
            valid = false;
          }
        }
        if (!valid) {
          setState(() {
            _showInvalidStringErrorMessage = true;
          });
          return false;
        }
      }else{
        setState(() {
          _showInvalidStringErrorMessage = true;
        });
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Center(
            child: Column(
              children: [
                const Text('Vous avez choisi de réaliser une opération sur des arbres'),
                const SizedBox(height: 20,),
                const Text('arbre 1'),
                const SizedBox(height: 20,),
                DropdownButton<String>(
                    value: dropDownValueTreeType1,
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
                        dropDownValueTreeType1 = value!;
                        if (dropDownValueTreeType1 == optionsTreeType[0]) {
                          textField1 = buildTextField(dropDownValueTreeType1,_treeStringController1, 1);
                        } else {
                          textField1 = buildTextField(dropDownValueTreeType1,_treeLengthController1, 1);
                        }
                      });
                    }),

                /*TextField(
              decoration: InputDecoration(hintText: 'Saisir votre arbre'),
              controller: _treeStringController1,
            ),*/

                textField1,
                if (_showEmptyStringErrorMessage)
                  const Text( "Veuillez saisir un arbre", style: TextStyle(color: Colors.red),),
                if (_showInvalidStringErrorMessage)
                  const Text( "Veuillez saisir un arbre valide", style: TextStyle(color: Colors.red),),
                if (_showInvalidLengthStringError)
                  const Text("La longueur saisie doit être une puissance de 2", style: TextStyle(color: Colors.red),),

                /*ElevatedButton(
                onPressed: (){
                  String treeString = _treeStringController1.text;
                  octree1 = new Octree.fromChaine(treeString, 16); /// TODO CALCUL DE LA LONGUEUR !!
                  print(octree1.univers);
                  print(treeString);
                },
                child: Text('générer un arbre')),*/
                /*TextField(
              decoration: InputDecoration(hintText: 'Saisir une longueur'),
              controller: _treeLengthController1,
            ),*/
                /*ElevatedButton(
                onPressed: (){
                  int treeLength = int.parse(_treeLengthController1.text);
                  octree1 = new Octree.aleatoire(treeLength);
                  print(treeLength);
                  print(octree2.univers);
                },
                child: Text('générer un arbre aléatoire')),*/
                const SizedBox(height: 20,),
                const Divider(color: Colors.white,thickness: 2,),
                const SizedBox(height: 20,),
                const Text('arbre 2'),
                const SizedBox(height: 20,),
                DropdownButton<String>(
                    value: dropDownValueTreeType2,
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
                        _showEmptyStringErrorMessage2 = false;
                        _showInvalidStringErrorMessage2 = false;
                        _showInvalidLengthStringError2 = false;
                        dropDownValueTreeType2 = value!;
                        if (dropDownValueTreeType2 == optionsTreeType[0]) {
                          textField2 = buildTextField(dropDownValueTreeType2,_treeStringController2, 2);
                        } else {
                          textField2 = buildTextField(dropDownValueTreeType2,_treeLengthController2, 2);
                        }
                      });
                    }),
                textField2,
                /*TextField(
              decoration: InputDecoration(hintText: 'Saisir votre arbre'),
              controller: _treeStringController2,
            ),*/
                /*ElevatedButton(
                onPressed: (){
                  String treeString = _treeStringController2.text;
                  octree2 = new Octree.fromChaine(treeString, 16); /// TODO CALCUL DE LA LONGUEUR !!
                  print(treeString);
                  print(octree2.univers);
                },
                child: Text('générer un arbre')),*/
                /*TextField(
              decoration: InputDecoration(hintText: 'Saisir une longueur'),
              controller: _treeLengthController2,
            ),*/
                /*ElevatedButton(
                onPressed: (){
                  int treeLength = int.parse(_treeLengthController2.text);
                  octree2 = new Octree.aleatoire(treeLength);
                  print(octree2.univers);
                  print(treeLength);
                },
                child: Text('générer un arbre aléatoire')),*/
                const Divider(),
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
                ElevatedButton(
                    onPressed: () {
                      //if(dropDownValueTreeType1 == 'saisir mon arbre'){
                          _handleInputChangeTree(_treeStringController1.text, dropDownValueTreeType1, 1);
                      //}else{
                        _handleInputChangeTree(_treeStringController2.text, dropDownValueTreeType2, 2);

                      //}
                      if(_showEmptyStringErrorMessage || _showInvalidStringErrorMessage || _showInvalidLengthStringError){
                        print("erreur 1");
                        return;
                      }
                      switch (dropDownValueOperation) {
                        case 'intersection':
                          octree1.intersection(octree2);
                          break;
                        case 'union':
                          octree1.union(octree2);
                          break;
                        case 'différence':
                          octree1.difference(octree2);
                          break;
                      }
                      /*Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MyWorkingArea(octree: octree1, namePage: "")));*/
                    },
                    child: Text('Executer'))
              ],
            ),
          ),
        ));
  }
}
