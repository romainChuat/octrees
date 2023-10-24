import 'package:flutter/material.dart';
import 'package:octrees/Generate.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Visualize extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var prov = context.watch<ModelProvider>();
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
                  "Vous avez choisis de visualiser un arbre, voici l’ensemble de vos arbres :",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0,50)),
                Visibility(
                    visible: prov.trees.isNotEmpty,
                    child :Container(
                      height: 500,
                      child :ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: prov.trees.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) => MyWorkingArea() )
                              );


                            },
                            child: Center(child: Text(prov.trees[index])),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green
                            )

                        ),),
                              Tooltip(
                                message: 'Supprimer',
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {
                                    prov.removeTree(index);
                                  },
                                ),
                              ),]);
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    )),),
                Visibility(
                  visible: prov.trees.isEmpty,
                    child: Column (
                        children : [
                          Text(
                            "Malheureusement aucun arbre n’a encore été sauvegardé …",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 25,),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) => Generate() )
                                );
                              },
                              child: Text("Générer un nouvel arbre")
                          )
                        ]
                    ),
                )


              ]
          )
      ),
      floatingActionButton: Visibility(
      visible: prov.trees.isNotEmpty,
    child: FloatingActionButton(
        onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Generate() )
            );
        },
        tooltip: 'ajouter un arbre',
        child: const Icon(Icons.add),
      ),
                        ),
    );

  }

}