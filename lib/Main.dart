import 'package:flutter/material.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'MenuPrincipal.dart';

// String arbre = "DPVVPVVVP" ;
String arbre2 = "DPPPPVVVV";

String arbre1 = "DPPPVPVDVVVVVVPVV";

String arbre3 = "P";

String arbre4 = "V";
// String arbre2 = "DVVVVVVDVVVVVVPVV" ;
//int theta = 45 ;
//int phi = 45 ;
//int rho = 50 ;
void main() {
  //databaseFactory = databaseFactoryFfi;
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
      theme: ThemeData.dark().copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.black,
        ),
      ),
      home: MyHomePage(),
    );
  }
}



