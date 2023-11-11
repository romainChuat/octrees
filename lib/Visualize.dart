import 'package:flutter/material.dart';
import 'package:octrees/Generate.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Visualize extends StatelessWidget {
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
      backgroundColor: Colors.black,

      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Vous avez choisis de visualiser un arbre, voici l’ensemble de vos arbres :",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
            Visibility(
              visible: prov.trees.isNotEmpty,
              child: Container(
                  height: 500,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: prov.trees.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyWorkingArea(index: index)));
                                  },
                                  child: Center(child: Text(prov.trees[index])),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          side: BorderSide(color: Colors.white)))),
                            ),
                            Tooltip(
                              message: 'Supprimer',
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.white,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Confirmation',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        content: const Text(
                                            'Souhaitez-vous vraiment supprimer cet élément ?',
                                            style: TextStyle(color: Colors.white)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Annuler',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              prov.removeTree(index);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Confirmer',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                  )),
            ),
            Visibility(
              visible: prov.trees.isEmpty,
              child: Column(children: [
                Text(
                  "Malheureusement aucun arbre n’a encore été sauvegardé …",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Generate()));
                    },
                    child: Text("Générer un nouvel arbre"))
              ]),
            )
          ])),
      floatingActionButton: Visibility(
        visible: prov.trees.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Generate()));
          },
          tooltip: 'ajouter un arbre',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}