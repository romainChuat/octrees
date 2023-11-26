import 'package:flutter/material.dart';
import 'package:octrees/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'MenuPrincipal.dart';
import 'Themes.dart';


void main() {
  //databaseFactory = databaseFactoryFfi;
  runApp(
    ChangeNotifierProvider(
      create: (_) => ModelProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        title: 'Octree',
        themeMode: themeProvider.themeMode,
        theme: MyThemes.darkTheme,
        darkTheme: MyThemes.lightTheme,
        home: const MyHomePage(),
      );
    },
  );
}



