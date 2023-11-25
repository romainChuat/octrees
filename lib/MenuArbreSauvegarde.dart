import 'package:flutter/material.dart';
import 'package:octrees/MenuArbreGeneration.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'Visualisation.dart';
import 'Main.dart';

class MenuArbreSauvegarde extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var prov = context.watch<ModelProvider>();
    prov.getAllTrees();
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
              "Vous avez choisis de visualiser un arbre, voici l’ensemble de vos arbres :",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
            Visibility(
              visible: prov.trees.isNotEmpty,
              child: Container(
                  height: 500,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: prov.trees.length,
                    itemBuilder: (BuildContext context, int index) {
                      final treeName = prov.trees.keys.elementAt(index);  //TODO remplacer par un getters
                      final treeData = prov.trees[treeName];
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyWorkingArea(
                                                octree: prov.getOctree(treeName),
                                                namePage: "visualizePage")));
                                  },
                                  child: Center(child: Text(treeName)),
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
                                        content:  Text(
                                            'Etes-vous sûr de vouloir supprimer l\'arbre : $treeName ?',
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
                                            onPressed: () async {
                                              prov.removeTree(treeName);
                                              await prov.getAllTrees();
                                              Navigator.of(context).pop();
                                              //TODO show toast
                                              //prov.showToastDelete();
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
                const Text(
                  "Malheureusement aucun arbre n’a encore été sauvegardé …",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MenuArbreGeneration()));
                    },
                    child: const Text("Générer un nouvel arbre"))
              ]),
            )
          ])),
      floatingActionButton: Visibility(
        visible: prov.trees.isNotEmpty,
        child: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MenuArbreGeneration()));
          },
          tooltip: 'ajouter un arbre',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
