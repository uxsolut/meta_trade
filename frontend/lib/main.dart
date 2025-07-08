import 'package:flutter/material.dart';
import 'pages/homepage.dart'; // Novo arquivo com o conteúdo que saiu do main

void main() {
  runApp(const GestorCapitaisApp());
}

class GestorCapitaisApp extends StatelessWidget {
  const GestorCapitaisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Capitais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: const MobileHomePage(), // Agora importado de homepage.dart
      debugShowCheckedModeBanner: false,
    );
  }
}
