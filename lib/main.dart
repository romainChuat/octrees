import 'package:flutter/material.dart';
import 'package:octrees/DessinArbre.dart';
import 'package:octrees/Octree.dart' ;
import 'package:octrees/ModelProvider.dart' ;
import 'package:octrees/Visualize.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'Generate.dart';

// String arbre = "DPVVPVVVP" ;
String arbre2 = "DPPPPVVVV" ;
String arbre1 = "DPPPVPVDVVVVVVPVV" ;
String arbre3 = "P" ;
String arbre4 = "V" ;
// String arbre2 = "DVVVVVVDVVVVVVPVV" ;

int theta = 45 ;
int phi = 45 ;
int rho = 50 ;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ModelProvider(),
      child: MyApp(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [


              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 400)),
              SizedBox(
                  height: 50,
                  width: 200,
                  child : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Colors.white)
                      )
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => Generate() )
                      );
                    },
                    child: Text('Générer')
              )),
              Padding(padding: EdgeInsets.fromLTRB(60, 0, 0, 0)),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.white)
                        )
                    ),
                    child: Text('Visualiser')
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
  MyWorkingArea({Key? key}) : super(key: key);

  @override
  State<MyWorkingArea> createState() => _MyWorkingAreaState();
}
class _MyWorkingAreaState extends State<MyWorkingArea> {

  late Octree octree1, octree2, octreeResultant ;
  late DessinArbre da ;

  void initState() {
    octree1 = Octree.fromChaine(arbre1, 16) ;
    octree2 = Octree.fromChaine(arbre2, 16) ;
    // octreeResultant = octree1.intersection(octree2) ;
    octreeResultant = octree1.clone() ;
    // octreeResultant = octree1.complementaire() ;
    // octree = Octree.aleatoire(16) ;
    da = DessinArbre(octreeResultant, theta, phi, rho) ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<ModelProvider>();

    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
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
           Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),

           Tooltip(
             message: 'Editer',
             child: IconButton(
               icon: const Icon(Icons.edit),
               color: Colors.white,
               onPressed: () {
                 //make something
               },
             ),
           ),
           Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),


         ],

    ),

    body: Center(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: Painter(da),

      )
    ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
            },
            tooltip: 'Autre vue',
            backgroundColor: Colors.green,
            child: const Icon(Icons.autorenew),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),

          FloatingActionButton(
            onPressed: () {
              prov.zoomOut(da);
            },
            tooltip: 'Zoomer',
            backgroundColor: Colors.green,
            child: const Icon(Icons.zoom_in),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
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