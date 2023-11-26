import 'package:flutter/material.dart';
import 'package:octrees/MenuArbreGeneration.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'Library.dart';
import 'Themes.dart';
import 'Visualisation.dart';

/// Classe permettant de selectionner un octree parmis les octrees crée précédement
class MenuArbreSauvegarde extends StatelessWidget {
  const MenuArbreSauvegarde({super.key});

  /// supprime l'arbre octree identifié par treeName
  /// en utilisant le fonction removeTree du provider qui supprime l'arbre de la base de donnée
  /// on fait appel a getAllTrees pour récupérer la nouvelle liste après suppression
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
                    /// La liste d'octree est affichee uniquement si elle contient des elements
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
                                  /// L'affichage de la liste des octree se fait sous la forme d'une ListView
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: prov.trees.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      final treeName = prov.trees.keys.elementAt(index);
                                      return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: button(
                                                  themeProvider,
                                                  context,
                                                  treeName,
                                                  /// redirection vers la page de visualisation
                                                  MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) =>
                                                          MyWorkingArea(
                                                              octree:
                                                              prov.getOctree(
                                                                  treeName),
                                                              namePage: "visualizePage"))),
                                            ),
                                            /// bouton de suppression d'un arbre de la liste
                                            Tooltip(
                                              message: 'Supprimer',
                                              child: deleteButton(
                                                  themeProvider, context,
                                                  treeName, prov, deleteTree, false),
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
                    /// Afficher dans le cas ou la base de données ne contient aucun octree
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
