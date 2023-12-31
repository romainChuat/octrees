import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:octrees/Database_helper.dart';
import 'package:octrees/Octree.dart';
import 'DessinArbre.dart';
import 'package:octrees/Library.dart';


class ModelProvider extends ChangeNotifier {

  Map<String,Octree> _trees = new Map<String,Octree>();
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
        int levelNumber = treeLevel(treeString);
        int treeLength = treeSide(levelNumber);
        _trees[treeName] = Octree.fromChaine(treeString,treeLength);
      }
    }catch(e) {
      print(e);
    }
    notifyListeners();
  }

  String getIndexByOctree(Octree octree) {
    int index = 0;
    for (var entry in _trees.entries) {
      if (entry.value.decompile(entry.value.univers) == octree.decompile(octree.univers)) {
        return entry.key;
      }
      index++;
    }
    return "AAAAAAAAAAa";
  }

  void addTree(String name, Octree tree) async{
    _database_helper = await Database_helper.dbhelper;
    _database_helper.insertTree({'tree_name' : name, 'tree_string' : (tree.decompile(tree.univers)).trim() });
    notifyListeners();
  }

  //TODO : pas censé faire ça il peut y avoir plusieurs tree avec la même chaine
  void removeTreeByOctree(Octree tree) async{
    _database_helper = await Database_helper.dbhelper;
    _database_helper.deleteTreeByName(tree.decompile(tree.univers));
    notifyListeners();
  }

  ///  Supprime dans trees l'arbre identifié par la string name
  void removeTree(String name) async{
    _database_helper = await Database_helper.dbhelper;
    _database_helper.deleteTreeByName(name);
    notifyListeners();
  }

  ///Retourne l'element de trees identifié par la string name
  getOctree(String name){
    if(_trees.containsKey(name)){
      return _trees[name];
    }
    return null;
  }
  Octree getByIndex(int index){
    notifyListeners();
     return _trees.values.elementAt(index);
  }


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
  void gestureDetectorMethods(DragUpdateDetails details) {
    phi += details.delta.dy.toInt();
    theta += details.delta.dx.toInt();
    notifyListeners();

  }


  void createGraphe(Graph graph, Map<Node, String> nodes, int father, int childIndex) {
    //int i  = childIndex;
    int countD = 0;
    for (int k = childIndex; k < childIndex + 8; k++) {
      graph.addEdge(Node.Id(father), Node.Id(k));
      if (nodes[Node.Id(k)] == 'D') {
        countD++;
        createGraphe(graph,nodes, k, childIndex + (8 * countD));
      }
    }
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

  /// GRAPH
  /*Graph _graph = Graph()..isTree = true;
  Map<Node, String> _nodes = {};

  Graph get graph => _graph;
  Map<Node, String> get nodes => _nodes;


  void createNodes(String univers_string){
    for (int i = 0; i < univers_string.length; i++) {
      nodes[Node.Id(i)] = univers_string[i];
      print(nodes[Node.Id(i)]);
    }
    notifyListeners();
  }

  void modifyToDivisble(int id ){
    nodes[Node.Id(35)] = 'V';
    graph.addEdge(Node.Id(id), Node.Id(35));
    notifyListeners();
  }

  void createGraphe( int father, int childIndex) {
    //int i  = childIndex;
    int countD = 0;
    for (int k = childIndex; k < childIndex + 8; k++) {
      graph.addEdge(Node.Id(father), Node.Id(k));
      if (nodes[Node.Id(k)] == 'D') {
        countD++;
        createGraphe(k, childIndex + (8 * countD));
      }
    }
    notifyListeners();
  }*/

}