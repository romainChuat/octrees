
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


//fonction de retrait à la list


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



}