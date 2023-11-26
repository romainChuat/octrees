import 'package:flutter/material.dart';
import 'package:octrees/Database_helper.dart';
import 'package:octrees/Octree.dart';
import 'DessinArbre.dart';
import 'package:octrees/Library.dart';


class ModelProvider extends ChangeNotifier {

  Map<String,Octree> _trees = Map<String,Octree>();
  Map<String,Octree> get trees => _trees;
  late DatabaseHelper _database_helper;

  int _phi = 45;
  int get phi => _phi;

  int _rho = 50;
  int get rho => _rho;

  int _theta = 45;
  int get theta => _theta;

  /// recuperation des octree stockes en base de données
  /// et mise a jour de trees avec les dernieres valeur stocke en BD
   getAllTrees() async{
    _database_helper = await DatabaseHelper.dbhelper;
    try {
      Future<List<Map<String, dynamic>>> futureTrees = _database_helper.getAllTree();
      List<Map<String, dynamic>> dbTrees= await futureTrees;
      trees.clear();
      for(var tree in dbTrees){
        String treeName = tree['tree_name'];
        String treeString = tree['tree_string'];
        int levelNumber = treeLevel(treeString);
        int treeLength = treeSide(levelNumber);
        _trees[treeName] = Octree.fromChaine(treeString,treeLength);
      }
    }catch(e) {
      //print(e);
    }
    notifyListeners();
  }
  /// retourne le nom de octree
  String getIndexByOctree(Octree octree) {
    for (var entry in _trees.entries) {
      if (entry.value.decompile(entry.value.univers) == octree.decompile(octree.univers)) {
        return entry.key;
      }
    }
    return "";
  }

  /// insert dans la base de donnees le nouvel octree
  void addTree(String name, Octree tree) async{
    _database_helper = await DatabaseHelper.dbhelper;
    _database_helper.insertTree({'tree_name' : name, 'tree_string' : (tree.decompile(tree.univers)).trim() });
    notifyListeners();
  }

  ///  Supprime dans la base de donnees le tree identifie par la string name
  void removeTree(String name) async{
    _database_helper = await DatabaseHelper.dbhelper;
    _database_helper.deleteTreeByName(name);
    notifyListeners();
  }

  ///retourne l'element identifie par la chaine name dans trees
  getOctree(String name){
    if(_trees.containsKey(name)){
      return _trees[name];
    }
    return null;
  }
  /// retourne l'octree à l'index index
  Octree getByIndex(int index){
     return _trees.values.elementAt(index);
  }

  /// setter de rho
  set rho(int value) {
    _rho = value;
    notifyListeners();
  }

  /// setter de phi
  set phi(int value) {
    _phi = value;
    notifyListeners();
  }

  /// modifie la valeur de rho pour effectuer le zoom
  void zoomIn(DessinArbre da) {
    _rho = rho.toInt() + 5;
    da.rho = _rho;
    notifyListeners();
  }

  /// modifie la valeur de rho pour effectuer un dezoom
  void zoomOut(DessinArbre da) {
    if (rho >= 5) {
      _rho = rho.toInt() - 5;
      da.rho = _rho;
      notifyListeners();
    }
  }

  /// setter de theta
  set theta(int value) {
    _theta = value;
    notifyListeners();
  }

  /// modifie la valeur de phi et theta pour effectuer une rotation
  /// en fonction des mouvements de l'utilisateur
  void gestureDetectorMethods(DragUpdateDetails details) {
    phi += details.delta.dy.toInt();
    theta += details.delta.dx.toInt();
    notifyListeners();
  }

}