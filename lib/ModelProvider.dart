
import 'package:flutter/foundation.dart';

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

  //fonction de retrait à la list





}