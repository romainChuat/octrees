import 'package:flutter/foundation.dart';
import 'package:octrees/Octree.dart';
import 'DessinArbre.dart';

class ModelProvider extends ChangeNotifier{

  Map<String,Octree> _trees = {'name_1' : Octree.fromChaine('DPPPVPVDVVVVVVPVV',16 ), 'name_2' : Octree.fromChaine('DVVVVVVDVVVVVVPVV',16)};

  Map<String,Octree> get trees => _trees;

  void addTree(String name, Octree tree){
    _trees[name] = tree;
    notifyListeners();
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
  double _zoomFactor = 1.0;
  double get zoomFactor => _zoomFactor;

  void zoomIn(DessinArbre da) {
    _zoomFactor += 0.1;
    da.rho = (rho * zoomFactor).toInt();
    notifyListeners();
  }
  void zoomOut(DessinArbre da) {
    if (zoomFactor > 0.2) {
      _zoomFactor -= 0.1;
      da.rho = (rho * zoomFactor).toInt();
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
}