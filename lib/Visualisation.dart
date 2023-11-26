import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:octrees/DessinArbre.dart';
import 'package:octrees/Octree.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'Library.dart';
import 'MenuPrincipal.dart';
import 'Themes.dart';


class MyWorkingArea extends StatefulWidget {
  final Octree octree;
  final String namePage;

  const MyWorkingArea({Key? key, required this.octree, required this.namePage})
      : super(key: key);

  @override
  _MyWorkingAreaState createState() =>
      _MyWorkingAreaState(octree: octree, namePage: namePage);
}

class _MyWorkingAreaState extends State<MyWorkingArea> {
  double initialTheta = 0.0;
  double initialPhi = 0.0;
  final Octree octree;
  final String namePage;

  TextEditingController _textNameController = TextEditingController();

  _MyWorkingAreaState({required this.octree, required this.namePage});

  late Octree octree1, octree2, octreeResultant;
  late DessinArbre da;

  late TextEditingController thetaController;
  late TextEditingController phiController;
  late TextEditingController rhoController;
  Widget currentContent = Container();
  bool octree3D = true;

  /// 2D VIEW
  Map<TextEditingController, int> _controllers = {}; /// list de controller associe a l'int id du noeud
  bool edit = false;
  final Graph graph = Graph()..isTree = true;
  Map<Node, String> nodes = {};   /// represente la list de node et la valeur associe ('D','V','P')
  var prov;

  /// initialisation = initState
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modelProv = Provider.of<ModelProvider>(context, listen: false);
    thetaController = TextEditingController(text: '${modelProv.theta}');
    phiController = TextEditingController(text: '${modelProv.phi}');
    rhoController = TextEditingController(text: '${modelProv.rho}');

    da = DessinArbre(octree, modelProv.theta, modelProv.phi, modelProv.rho);
    if (!edit) {
      currentContent = CustomPaint(
        size: MediaQuery.of(context).size,
        painter: Painter(da),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// suppression de l'arbre visualiser
  void deleteTree(ModelProvider prov, BuildContext context) {
    Navigator.of(context).pop();
    prov.removeTree(prov.getIndexByOctree(octree));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color backgroundColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
    prov = context.watch<ModelProvider>();
    return Theme(
      data: ThemeData(
        brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
      ),
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            prov.phi = 45;
            prov.theta = 45;
            prov.rho = 50;
            if (namePage == "visualizePage") {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const MyHomePage(),
              ));
            } else if (namePage == "generatePage") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: text(
                      themeProvider,
                      'Sauvegarde',
                    ),
                    content:  text(
                      themeProvider,
                      'Voulez-vous sauvegarder avant de quitter ?',
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: text(
                    themeProvider,
                    'Quitter',
                  ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: text(
                  themeProvider,
                  'Sauvegarder',
                  ),
                        onPressed: () {
                          saveMethod(context, prov);
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        actions: [
          Tooltip(
            message: 'Sauvegarder',
            child: Visibility(
              visible: namePage == "generatePage",
              child: IconButton(
                icon: const Icon(Icons.save_alt),
                color: Colors.white,
                onPressed: () {
                  saveMethod(context, prov);
                },
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
          Tooltip(
            message: 'Supprimer',
            child: Visibility(
              visible: namePage == "visualizePage",
              child: deleteButton(themeProvider, context, prov.getIndexByOctree(octree), prov, deleteTree, true),
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
          if(!edit && octree3D == true)
            Tooltip(
              message: 'Editer',
              child: IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width, 80.0, 0.0, 0.0),
                    items: <PopupMenuEntry>[
                      popupMenuItem(
                        label: "theta",
                        controller: thetaController,
                        onChanged: (value) {
                          var newTheta = int.tryParse(value);
                          if (newTheta != null) {
                            prov.theta = newTheta;
                            da.theta = newTheta;
                          }
                        },
                        isTop: true,
                      ),
                      popupMenuItem(
                        label: "phi",
                        controller: phiController,
                        onChanged: (value) {
                          var newPhi = int.tryParse(value);
                          if (newPhi != null) {
                            prov.phi = newPhi;
                            da.phi = newPhi;
                          }
                        },
                      ),
                      popupMenuItem(
                        label: "rho",
                        controller: rhoController,
                        onChanged: (value) {
                          var newRho = int.tryParse(value);
                          if (newRho != null) {
                            prov.rho = newRho;
                            da.rho = newRho;
                          }
                        },
                        isBottom: true,
                      ),
                    ],
                  );
                },
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
          settingIcon(context),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
              prov.gestureDetectorMethods(details);
          },
          child: Container(
            color: backgroundColor,
            child: currentContent,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              setState(() {
                if (octree3D == true) {
                  /// creation de l'arbre en 2D

                  String univers_string = octree.decompile(octree.univers);
                  ///ajout des noeuds au graph
                  for (int i = 0; i < univers_string.length; i++) {
                    nodes[Node.Id(i)] = univers_string[i];
                    print(nodes[Node.Id(i)]);
                  }

                  createGraphe(0, 1);
                  /// affichage du graph cree grace au plugin GraphView
                  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
                  builder.orientation = 3;
                  builder.siblingSeparation = 10;
                  builder.levelSeparation = 50;
                  currentContent = InteractiveViewer(
                      constrained: false,
                      boundaryMargin: EdgeInsets.all(20),
                      minScale: 0.01,
                      maxScale: 5.6,
                      child: GraphView(
                        graph: graph,
                        algorithm: BuchheimWalkerAlgorithm(
                            builder, TreeEdgeRenderer(builder)),
                        paint: Paint()
                          ..color = Colors.white
                          ..strokeWidth = 3
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) {
                          String? a = nodes[node];
                          print("a");
                          return rectangleWidget(a!, node.key?.value as int,
                              graph.getOutEdges(node));
                        },
                      ));

                  octree3D = false;
                } else {
                  /// creation de l'arbre en 3D
                  currentContent = CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: Painter(da),
                  );
                  octree3D = true;
                }
              });
            },
            tooltip: 'Autre vue',
            backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
            foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
            child: const Icon(Icons.autorenew),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          /// creation des bouton zoom et dezoom si on est en vue 3D
          if (!edit && octree3D == true) zoomButton("Zoomer", prov.zoomOut, themeProvider, da),
          if (!edit && octree3D == true) const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          if (!edit && octree3D == true) zoomButton("Dézoomer", prov.zoomIn, themeProvider, da),
        ],
      ),
    ),
    );
  }


  /// création d'un graphe ,
  /// graph est le graph modifie
  /// nodes represente la list de node et la valeur associe ('D','V','P')
  /// father est le noeud pere auquel on se place pour effectue la modification
  /// childIndex est la position dans la chaine nodes
  void createGraphe(int father, int childIndex) {
    int countD = 0;
    for (int k = childIndex; k < childIndex + 8; k++) {
      graph.addEdge(Node.Id(father), Node.Id(k));
      if (nodes[Node.Id(k)] == 'D') {
        countD++;
        createGraphe(k, childIndex + (8 * countD));
      }
    }
  }

  /// Enregistrement de l'arbre visualiser(si il vient d'etre genere)
  /// on affiche une AlertDialog permettant de saisir le nom de l'arbre
  saveMethod(BuildContext context, ModelProvider prov) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nom de l\'arbre'),
          content: TextField(
            controller: _textNameController,
            decoration: const InputDecoration(hintText: 'Nom de l\'arbre'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Valider'),
              onPressed: () {
                Navigator.of(context).pop();

                prov.addTree(_textNameController.text, octree);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const MyHomePage(),
                ));
              },
            ),
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  Widget rectangleWidget(String a, int id, List<Edge> e) {
    TextEditingController controller = TextEditingController(text: a);
    _controllers[controller] = id;
    return SizedBox(
        height: 26,
        width: 26,
        child: TextField(
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          enabled: e.isEmpty,
          controller: controller,
          onChanged: (newValue) => _handleNodeChange(controller),
          onTap: _handleTextFieldTap,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: a,
              contentPadding: EdgeInsets.fromLTRB(3, 30, 0, 0),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none),
        ));
  }
  _handleNodeChange(TextEditingController controller) {
    setState(() {
      print(controller.text);
      print("change");
      int? id = _controllers[controller];
      if (controller.text == 'V' || controller.text == 'P') {
        nodes[Node.Id(id)] = controller.text;
      }
      if (controller.text == 'D') {
        if (_controllers.containsKey(controller)) {
          print(id);
          nodes[Node.Id(id)] = 'D';
          // creé 8 Noeud en partant du noeud last;
          nodes[Node.Id(35)] = 'V';
          graph.addEdge(Node.Id(id), Node.Id(35));
        }
      }
      octree3D = true;
    });
  }

  _handleTextFieldTap() {
    setState(() {
      edit = true;
      octree3D = true;
    });
  }





}

class Painter extends CustomPainter {
  final DessinArbre da;

  const Painter(this.da);

  @override
  void paint(Canvas canvas, Size size,) {
    da.maxX = size.width;
    da.maxY = size.height;
    da.dessineArbre(canvas);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => true;
}
