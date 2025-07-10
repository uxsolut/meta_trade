import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Sua Home
import 'pages/dashboard_page.dart'; // Página do dashboard
import 'package:google_sign_in/google_sign_in.dart';

// Importações específicas para Web
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web; // Para registrar o botão Google na web

void main() {
  if (kIsWeb) {
    ui_web.platformViewRegistry.registerViewFactory(
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
      home: const MobileHomePage(), // Tela inicial
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const MobileHomePage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}

// Instância do GoogleSignIn (usa em Mobile/Native, NÃO Web)
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);
