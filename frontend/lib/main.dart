import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'pages/homepage.dart'; // Sua Home
import 'package:google_sign_in/google_sign_in.dart';

// Importa apenas se rodando no Web
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui' as ui;
import 'dart:html' as html;

void main() {
  // Registrar botão Google Sign-In para Web
  if (kIsWeb) {
    ui.platformViewRegistry.registerViewFactory(
      'google-signin-button',
      (int viewId) {
        final elem = html.DivElement()
          ..innerHtml = '''
            <div id="g_id_onload"
              data-client_id="934154868065-2jvmd30b1lcn948nj3u2im6q6726nuq7.apps.googleusercontent.com"
              data-auto_prompt="false"
              data-callback="onGoogleSignIn">
            </div>
            <div class="g_id_signin"
              data-type="standard"
              data-size="large"
              data-theme="outline"
              data-text="sign_in_with"
              data-shape="rectangular"
              data-logo_alignment="left">
            </div>
          ''';
        return elem;
      },
    );
  }

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
      home: const MobileHomePage(), // Sua homepage.dart
      debugShowCheckedModeBanner: false,
    );
  }
}

// Instância do GoogleSignIn (usa em Mobile/Native, NÃO Web)
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);
