
import 'package:flutter/material.dart';
import 'package:octrees/library.dart';
import 'package:octrees/main.dart';
import 'Octree.dart';

class Operation extends StatefulWidget {
  _OperationState createState() => _OperationState();
}
class _OperationState extends State<Operation>{

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

  var textField1;
  var textField2;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textField1 = buildTextField(dropDownValueTreeType1,_treeStringController1);
    textField2 = buildTextField(dropDownValueTreeType2,_treeLengthController2);
  }

  Widget buildTextField(String dropDownValueTreeType, var controller){
    return TextField(
      decoration: InputDecoration(hintText: dropDownValueTreeType),
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: createAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child:Center(

        child: Column(
          children: [

            Text('Vous avez choisi de réaliser une opération sur des arbres'),
            Text('arbre 1'),
            DropdownButton<String>(
                value: dropDownValueTreeType1,
                items: optionsTreeType.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem(
                    value : value,
                    child: Text(value),
                  );
                },
                ).toList(),
                onChanged: (String? value){
                  setState(() {
                    dropDownValueTreeType1 = value!;
                    if(dropDownValueTreeType1 == optionsTreeType[0]){
                      textField1 = buildTextField(dropDownValueTreeType1, _treeStringController1);
                    }else{
                      textField1 = buildTextField(dropDownValueTreeType1, _treeLengthController1);
                    }
                  });
                }
            ),
            /*TextField(
              decoration: InputDecoration(hintText: 'Saisir votre arbre'),
              controller: _treeStringController1,
            ),*/
            textField1,
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
            SizedBox(height: 20,),
            Divider(color: Colors.white, thickness: 2,),
            SizedBox(height: 20,),
            Text('arbre 2'),
            DropdownButton<String>(
                value: dropDownValueTreeType2,
                items: optionsTreeType.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem(
                    value : value,
                    child: Text(value),
                  );
                },
                ).toList(),
                onChanged: (String? value){
                  setState(() {
                    dropDownValueTreeType2 = value!;
                    if(dropDownValueTreeType2 == optionsTreeType[0]){
                      textField1 = buildTextField(dropDownValueTreeType2, _treeStringController2);
                    }else{
                      textField1 = buildTextField(dropDownValueTreeType2, _treeLengthController2);
                    }
                  });
                }
            ),
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
            Divider(),
            DropdownButton<String>(
                value: dropDownValueOperation,
                items: optionsOperation.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem(
                      value : value,
                      child: Text(value),
                  );
                },
                ).toList(),
                onChanged: (String? value){
                  setState(() {
                    dropDownValueOperation = value!;
                  });
                }
            ),
            ElevatedButton(
                onPressed: (){
                  switch(dropDownValueOperation){
                    case 'intersection' :
                      octree1.intersection(octree2);
                      break;
                    case 'union' :
                      octree1.union(octree2);
                      break;
                    case 'différence' :
                      octree1.difference(octree2);
                      break;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyWorkingArea(octree: octree1, namePage: "")));
                } ,
                child: Text('Executer'))

          ],
        ),
      ),)
    );
  }


}