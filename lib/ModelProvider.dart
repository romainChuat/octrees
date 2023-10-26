
import 'package:flutter/foundation.dart';

import 'DessinArbre.dart';
import 'main.dart';

class ModelProvider extends ChangeNotifier{

  List<String> _trees = ["arbre 1", "arbre 2"];

  List<String> get trees => _trees;
  //une liste d'arbre

  //fonction de génération

  //fonction de création après saisie

  //fonction d'ajout à la list
  void addTree(String tree){
    _trees.add(tree);
  }
// supprime un élements à l'index donner
  void removeTree(int index) {
    _trees.removeAt(index);
    notifyListeners();
  }

  int getTreeSize() {
    return _trees.length;
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



}