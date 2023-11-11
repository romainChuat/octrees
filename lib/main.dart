import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:octrees/DessinArbre.dart';
import 'package:octrees/Octree.dart' ;
import 'package:octrees/ModelProvider.dart' ;
import 'package:octrees/Visualize.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'Cube.dart';
import 'Generate.dart';

// String arbre = "DPVVPVVVP" ;
String arbre2 = "DPPPPVVVV" ;
String arbre1 = "DPPPVPVDVVVVVVPVV" ;
String arbre3 = "P" ;
String arbre4 = "V" ;
// String arbre2 = "DVVVVVVDVVVVVVPVV" ;
//int theta = 45 ;
//int phi = 45 ;
//int rho = 50 ;
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ModelProvider(),
      child: const MyApp(),
    ),
  );
}
// on récupère la taille de la fenêtre pour dimensionner le dessin dans le canvas
// final size = window.physicalSize / window.devicePixelRatio;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            Tooltip(
              message: 'Paramètre',
              child: IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.white,
                onPressed: () {
                  //   prov.removeTree(index);
                },
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        //appBar: AppBar(title: Text('Des cubes !!! Rien que des cubes !!')),
        body: Center (
            child :Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Bienvenue',
                      textStyle: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                      speed: const Duration(milliseconds: 400),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 500),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 400)),
                    SizedBox(
                        height: 50,
                        width: 200,
                        child : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(color: Colors.white)
                                )
                            ),
                            onPressed: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) => Generate() )
                              );
                            },
                            child: const Text('Générer')
                        )),
                    const Padding(padding: EdgeInsets.fromLTRB(60, 0, 0, 0)),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child : ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) => Visualize() )
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(color: Colors.white)
                              )
                          ),
                          child: const Text('Visualiser')
                      ),
                    )
                  ],
                )
                /*Expanded(
                  child: MyWorkingArea()
              ),*/
              ],
            )));
  }
}
class MyWorkingArea extends StatefulWidget {
  MyWorkingArea({Key? key, required this.octree}) : super(key: key);
  final Octree octree;
  @override
  _MyWorkingAreaState createState() => _MyWorkingAreaState(octree: octree);
}
class _MyWorkingAreaState extends State<MyWorkingArea> {
  final Octree octree;
  _MyWorkingAreaState({required this.octree});
  late Octree octree1, octree2, octreeResultant ;
  late DessinArbre da ;
  late TextEditingController thetaController;
  late TextEditingController phiController;
  late TextEditingController rhoController;
  Widget currentContent = Container();
  bool octree3D = true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modelProv = Provider.of<ModelProvider>(context, listen: false);
    thetaController = TextEditingController(text: '${modelProv.theta}');
    phiController = TextEditingController(text: '${modelProv.phi}');
    rhoController = TextEditingController(text: '${modelProv.rho}');
    octree1 = Octree.fromChaine(arbre1, 16) ;
    octree2 = Octree.fromChaine(arbre2, 16) ;
    // octreeResultant = octree1.intersection(octree2) ;
    octreeResultant = octree1.clone() ;
    // octreeResultant = octree1.complementaire() ;
    // octree = Octree.aleatoire(16) ;
    //da = DessinArbre(octreeResultant, modelProv.theta, modelProv.phi, modelProv.rho) ;

    da = DessinArbre(octree, modelProv.theta, modelProv.phi, modelProv.rho);
    currentContent = CustomPaint( size: MediaQuery.of(context).size, painter: Painter(da),);

  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var prov = context.watch<ModelProvider>();
    //initState();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Tooltip(
            message: 'Supprimer',
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                //   prov.removeTree(index);
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
                  position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width, 80.0, 0.0, 0.0),
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      child: ListTile(
                        leading: Text("theta : "),
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
                    PopupMenuItem(
                      child: ListTile(
                        leading: Text("phi : "),
                        title: TextField(
                          keyboardType: TextInputType.number,
                          controller: phiController,
                          onChanged: (value) {
                            var newPhi = int.tryParse(value);
                            if (newPhi != null) {
                              prov.phi = newPhi;
                              da.phi = newPhi;}
                          },
                        ),
                      ),
                    ),
                    PopupMenuItem(
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
                  ],
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
        ],
      ),

      body: Center(
        child: currentContent,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if(octree3D == true){
                  /// création de l'arbre en 2D
                  String univers_string = octree.decompile(octree.univers);
                  double tree_height = 0;
                  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
                  builder.orientation = 3;
                  builder.siblingSeparation = 10;
                  builder.levelSeparation = 15;

                  final Graph graph = Graph()..isTree = true;
                  Map<Node,String> nodes = {};

                  ///ajout des noeuds au graph
                  for(int i =0; i< 8 ; i++){
                    nodes[Node.Id(i)] = univers_string[i];
                  }
                  Node root = nodes.entries.first.key;
                  for (Node n in nodes.keys) {
                    if (n != root) {
                      graph.addEdge(root, n);
                    }

                  }
                  /*for(int i =0; i< univers_string.length; i+=8){
                    for(int j = i; j<i+8; j++ ){
                      if(univers_string[j] == 'D') {
                        graph.addEdge()
                      }
                    }
                  }*/

                  /*for(int i = 0; i< 8; i++){
                    graph.addEdge(nodes[0], nodes[i]);
                  }*/
                  graph.addEdge(Node.Id(0), Node.Id(1));
                  currentContent = Expanded(
                    //child: InteractiveViewer(
                    //  constrained: false,
                    //boundaryMargin: EdgeInsets.all(100),
                    //minScale: 0.01,
                    //maxScale: 5.6,
                    child: GraphView(
                      graph: graph,
                      algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                      paint: Paint()
                        ..color = Colors.green
                        ..strokeWidth = 1
                        ..style = PaintingStyle.stroke,
                      builder: (Node node) {
                        // I can decide what widget should be shown here based on the id
                        //var a = node.key?.value as int;
                        String? a = nodes[node];
                        return rectangleWidget(a!);
                      },
                    ),
                  );
                  //currentContent = Container(color: Colors.blue,);
                  octree3D = false;
                }else{
                  /// création de l'arbre en 3D
                  currentContent = CustomPaint( size: MediaQuery.of(context).size, painter: Painter(da),);
                  octree3D = true;
                }
              });
            },
            tooltip: 'Autre vue',
            backgroundColor: Colors.green,
            child: const Icon(Icons.autorenew),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          FloatingActionButton(
            onPressed: () {
              prov.zoomOut(da);
            },
            tooltip: 'Zoomer',
            backgroundColor: Colors.green,
            child: const Icon(Icons.zoom_in),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          FloatingActionButton(
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
  Widget rectangleWidget(String a ){
    return SizedBox(
      height: 20,
      width: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: Text('${a}', style: TextStyle(fontSize: 20),),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final DessinArbre da;
  const Painter(this.da);
  @override
  void paint(Canvas canvas, Size size) {
    da.maxX = size.width ;
    da.maxY = size.height ;
    da.dessineArbre (canvas) ;
  }
  @override
  bool shouldRepaint(Painter oldDelegate) => true;
}