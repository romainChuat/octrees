import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:octrees/Database_helper.dart';
import 'package:octrees/Octree.dart';
import 'DessinArbre.dart';


class ModelProvider extends ChangeNotifier {

  Map<String,Octree> _trees = new Map<String,Octree>(); //= {'name_1 ' : Octree.fromChaine('DPPPVPVDVVVVVVPVV',16 ), 'name_2' : Octree.fromChaine('DVVVVVVDVVVVVVPVV',16)};
  Map<String,Octree> get trees => _trees;
  late Database_helper _database_helper;

  /// update de trees en récupérant les valeurs de la base de données
   getAllTrees() async{
    _database_helper = await Database_helper.dbhelper;
    try {
      Future<List<Map<String, dynamic>>> futureTrees = _database_helper.getAllTree();
      List<Map<String, dynamic>> dbTrees= await futureTrees;
      trees.clear();
      for(var tree in dbTrees){
        String treeName = tree['tree_name'];
        String treeString = tree['tree_string'];
        _trees[treeName] = Octree.fromChaine(treeString,16);  ///TODO LONGUEUR
        //print('tree_name : $treeName, treeString : $treeString \n');
      }
    }catch(e) {
      print(e);
    }
    notifyListeners();
  }

  void addTree(String name, Octree tree) async{
    //_trees[name] = tree;
    _database_helper = await Database_helper.dbhelper;
    _database_helper.insertTree({'tree_name' : name, 'tree_string' : (tree.decompile(tree.univers)).trim() });
    notifyListeners();
  }

  void removeTreeByOctree(Octree tree) async{
    /*String? keyToRemove;
    _trees.forEach((key, value) {
      if (identical(value, tree)) {
        keyToRemove = key;
      }
    });
    if (keyToRemove != null) {
      _trees.remove(keyToRemove);
      notifyListeners();
    }*/
    _database_helper = await Database_helper.dbhelper;
    _database_helper.deleteTreeByName(tree.decompile(tree.univers));
  }

  ///  Supprime dans trees l'arbre identifié par la string name
  void removeTree(String name) async{
    //_trees.removeWhere((key, value) => key == name);
    _database_helper = await Database_helper.dbhelper;
    _database_helper.deleteTreeByName(name);
    notifyListeners();
  }

  ///Retourne l'element de trees identifié par la string name
  getOctree(String name) async{
    /*_database_helper = await Database_helper.dbhelper;
    Future<String?> octree = _database_helper.getByName(name);
    if(octree != null){
      return Octree.fromChaine(octree as String, 16);
    }*/
    if(_trees.containsKey(name)){
      return _trees[name];
    }
    return null;
  }

//fonction de retrait à la list

  int _rho = 50;
  int get rho => _rho;
  set rho(int value) {
    _rho = value;
    notifyListeners();
  }

  int _phi = 45;
  int get phi => _phi;
  set phi(int value) {
    _phi = value;
    notifyListeners();
  }

  void zoomIn(DessinArbre da) {
    _rho = rho.toInt() + 5;
    da.rho = _rho;
    notifyListeners();
  }

  void zoomOut(DessinArbre da) {
    if (rho >= 5) {
      _rho = rho.toInt() - 5;
      da.rho = _rho;
      notifyListeners();
    }
  }

  int _theta = 45;
  int get theta => _theta;
  set theta(int value) {
    _theta = value;
    notifyListeners();
  }

  int getTreeSize() {
    return _trees.length;
  }

  /*void showToastDelete() {
    Fluttertoast.showToast(
      msg: "Supprimer!",
      timeInSecForIosWeb: 2,
      fontSize: 16.0,
      backgroundColor: Colors.white,
    );
    notifyListeners();
  }*/
}