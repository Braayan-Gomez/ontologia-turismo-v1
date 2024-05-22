import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/Screens/home_screen.dart';
import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:provider/provider.dart';

//mateApp + tabulacion
void main() => runApp(AppState());

class AppState extends StatelessWidget {
  // const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OntologyProvider(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ontology Turismo',
      home: const HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
