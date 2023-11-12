import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:octrees/Octree.dart';
import 'DessinArbre.dart';


class ModelProvider extends ChangeNotifier{

  Map<String,Octree> _trees = {'name_1' : Octree.fromChaine('DPPPVPVDVVVVVVPVV',16 ), 'name_2' : Octree.fromChaine('DVVVVVVDVVVVVVPVV',16)};

  Map<String,Octree> get trees => _trees;

  void addTree(String name, Octree tree){
    _trees[name] = tree;
    notifyListeners();
  }

  void removeTreeByOctree(Octree tree) {
    String? keyToRemove;
    _trees.forEach((key, value) {
      if (identical(value, tree)) {
        keyToRemove = key;
      }
    });
    if (keyToRemove != null) {
      _trees.remove(keyToRemove);
      notifyListeners();
    }
  }


  ///  Supprime dans trees l'arbre identifié par la string name
  void removeTree(String name) {
    _trees.removeWhere((key, value) => key == name);
    notifyListeners();
  }

  ///Retourne l'element de trees identifié par la string name
  getOctree(String name){
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