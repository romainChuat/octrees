import 'package:flutter/material.dart';
import 'package:octrees/MenuArbreGeneration.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'Library.dart';
import 'Themes.dart';
import 'Visualisation.dart';

class MenuArbreSauvegarde extends StatelessWidget {
  const MenuArbreSauvegarde({super.key});

  void deleteTree(ModelProvider prov, String treeName, BuildContext context) {
    prov.removeTree(treeName);
    prov.getAllTrees();
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var prov = context.watch<ModelProvider>();
    prov.getAllTrees();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: retourEnArriere(context),
        actions: [
          settingIcon(context),
        ],
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 75)),
                    Visibility(
                      visible: prov.trees.isNotEmpty,
                      child: SizedBox(
                          child: Column(
                            children: [
                              text(
                                themeProvider,
                                "Vous avez choisis de visualiser un arbre, voici l’ensemble de vos arbres :",
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
                              SizedBox(
                                  height: 500,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: prov.trees.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final treeName = prov.trees.keys
                                          .elementAt(
                                          index); //TODO remplacer par un getters
                                      return Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              child: button(
                                                  themeProvider,
                                                  context,
                                                  treeName,
                                                  MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) =>
                                                          MyWorkingArea(
                                                              octree:
                                                              prov.getOctree(
                                                                  treeName),
                                                              namePage: "visualizePage"))),
                                            ),
                                            Tooltip(
                                              message: 'Supprimer',
                                              child: deleteButton(
                                                  themeProvider, context,
                                                  treeName, prov, deleteTree),
                                            ),
                                          ]);
                                    },
                                    separatorBuilder: (BuildContext context,
                                        int index) =>
                                    const Divider(),
                                  ))
                            ],
                          )),
                    ),
                    Visibility(
                      visible: prov.trees.isEmpty,
                      child: Column(children: [
                        text(
                          themeProvider,
                          "Malheureusement aucun arbre n’a encore été sauvegardé …",
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
                        button(
                            themeProvider,
                            context,
                            "Générer un nouvel arbre",
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                const MenuArbreGeneration())),
                      ]),
                    )
                  ]))),
      floatingActionButton: Visibility(
        visible: prov.trees.isNotEmpty,
        child: floatingActionButton(
            context, "ajouter un arbre", const Icon(Icons.add), () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const MenuArbreGeneration(),
            ),
          );
        }, themeProvider),
      ),
    );
  }

}
