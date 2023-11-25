import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:octrees/DessinArbre.dart';
import 'package:octrees/Octree.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'MenuPrincipal.dart';
import 'Main.dart';
import 'Themesprovider.dart';


class MyWorkingArea extends StatefulWidget {
  final Octree octree;
  final String namePage;

  MyWorkingArea({Key? key, required this.octree, required this.namePage})
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
  Map<TextEditingController, int> _controllers = {};
  bool edit = false;
  final Graph graph = Graph()..isTree = true;
  Map<Node, String> nodes = {};
  var prov;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modelProv = Provider.of<ModelProvider>(context, listen: false);
    thetaController = TextEditingController(text: '${modelProv.theta}');
    phiController = TextEditingController(text: '${modelProv.phi}');
    rhoController = TextEditingController(text: '${modelProv.rho}');
    octree1 = Octree.fromChaine(arbre1, 16);
    octree2 = Octree.fromChaine(arbre2, 16);
    // octreeResultant = octree1.intersection(octree2) ;
    octreeResultant = octree1.clone();
    // octreeResultant = octree1.complementaire() ;
    // octree = Octree.aleatoire(16) ;
    //da = DessinArbre(octreeResultant, modelProv.theta, modelProv.phi, modelProv.rho) ;

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

  @override
  Widget build(BuildContext context) {
    prov = context.watch<ModelProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            prov.phi = 45;
            prov.theta = 45;
            prov.rho = 50;
            if (namePage == "visualizePage") {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage(),
              ));
            } else if (namePage == "generatePage") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sauvegarde'),
                    content: Text('Voulez-vous sauvegarder avant de quitter ?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Annuler'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Sauvegarder'),
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
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content:
                      Text('Voulez-vous vraiment supprimer cet arbre ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            prov.removeTreeByOctree(octree);
                            Navigator.of(context).pop();
                          },
                          child: Text('Supprimer'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
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
                    PopupMenuItem(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: ListTile(
                          tileColor: Colors.black,
                          leading: Text("theta : ",
                              style: TextStyle(color: Colors.white)),
                          title: TextField(
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                            controller: thetaController,
                            onChanged: (value) {
                              var newTheta = int.tryParse(value);
                              if (newTheta != null) {
                                prov.theta = newTheta;
                                da.theta = newTheta;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: ListTile(
                          leading: Text("phi : "),
                          title: TextField(
                            keyboardType: TextInputType.number,
                            controller: phiController,
                            onChanged: (value) {
                              var newPhi = int.tryParse(value);
                              if (newPhi != null) {
                                prov.phi = newPhi;
                                da.phi = newPhi;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: ListTile(
                          leading: Text("rho : "),
                          title: TextField(
                            keyboardType: TextInputType.number,
                            controller: rhoController,
                            onChanged: (value) {
                              var newRho = int.tryParse(value);
                              if (newRho != null) {
                                prov.rho = newRho;
                                da.rho = newRho;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
          Tooltip(
            message: 'Paramètre',
            child: IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const ChangeThemeButtonWidget(),
                            Text(
                              "Mode sombre",
                            ),
                          ]

                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              prov.phi += details.delta.dy.toInt();
              prov.theta += details.delta.dx.toInt();
            });
          },
          child: Container(
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
                  /// création de l'arbre en 2D
                  String univers_string = octree.decompile(octree.univers);

                  ///ajout des noeuds au graph
                  for (int i = 0; i < univers_string.length; i++) {
                    nodes[Node.Id(i)] = univers_string[i];
                    print(nodes[Node.Id(i)]);
                  }
                  createGraphe(0, 1);
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
                  /// creéation de l'arbre en 3D
                  currentContent = CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: Painter(da),
                  );
                  octree3D = true;
                }
              });
            },
            tooltip: 'Autre vue',
            backgroundColor: Colors.green,
            child: const Icon(Icons.autorenew),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          if(!edit && octree3D == true)
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                prov.zoomOut(da);
              },
              tooltip: 'Zoomer',
              backgroundColor: Colors.green,
              child: const Icon(Icons.zoom_in),
            ),
          if(!edit && octree3D == true)
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          if(!edit && octree3D == true)
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                prov.zoomIn(da);
              },
              tooltip: 'Dézoomer',
              backgroundColor: Colors.green,
              child: const Icon(Icons.zoom_out),
            ),
        ],
      ),
    );
  }

  void createGraphe(/*Graph g, Map<Node, String> nodes,*/ int father, int childIndex) {
    //int i  = childIndex;
    int countD = 0;
    for (int k = childIndex; k < childIndex + 8; k++) {
      graph.addEdge(Node.Id(father), Node.Id(k));
      if (nodes[Node.Id(k)] == 'D') {
        countD++;
        createGraphe(k, childIndex + (8 * countD));
      }
    }
  }

  saveMethod(BuildContext context, ModelProvider prov) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nom de l\'arbre'),
          content: TextField(
            controller: _textNameController,
            decoration: InputDecoration(hintText: 'Nom de l\'arbre'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Valider'),
              onPressed: () {
                Navigator.of(context).pop();

                prov.addTree(_textNameController.text, octree);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(),
                ));
              },
            ),
            TextButton(
              child: Text('Annuler'),
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
  void paint(Canvas canvas, Size size) {
    da.maxX = size.width;
    da.maxY = size.height;
    da.dessineArbre(canvas);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => true;
}
