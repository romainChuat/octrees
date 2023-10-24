
import 'package:flutter/material.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';

class Generate extends StatelessWidget{

  var _textFieldController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
                 Text(
                  "Vous avez choisis de généré un nouvel arbre, choisissez la manière :",
                  style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0,50)),

              TextField(
                onChanged: (value) {},
                controller: _textFieldController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 30, 30, 30),
                  border: OutlineInputBorder(),
                  hintText: 'Saisir votre arbre',
                  hintStyle: TextStyle(color: Colors.white)
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              SizedBox(
                  height: 40,
                  width: 150,
                child : ElevatedButton(
                  onPressed: (){
                    if(_textFieldController.text != ""){
                      modelProvider.addTree(_textFieldController.text);
                    }
                  },
                  child: Text("Générer l'arbre"),
                )
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
              const Text(
                "ou",
                style: TextStyle(color: Colors.white, fontSize: 18),

              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),

              SizedBox(
                  height: 40,
                  child : ElevatedButton(
                      onPressed: (){

                      },
                      child: Text("Génerer un arbre aléatoire")
                  )
              )

            ]
          )
        ),
    );
  }
  
  

}