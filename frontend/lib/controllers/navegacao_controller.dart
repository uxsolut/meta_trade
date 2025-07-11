import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/dashboard_page.dart';
// Importar as demais telas quando forem criadas
// import '../pages/equipe_page.dart';
// import '../pages/contratar_page.dart';
// import '../pages/contato_page.dart';

/// Enum que representa os estados principais de navegação do app
enum EstadoNavegacao {
  home,
  login,
  dashboard,
  equipe,
  contratar,
  contato,
}

/// ChangeNotifier que controla a navegação baseada em estado
class NavegacaoController extends ChangeNotifier {
  EstadoNavegacao _estadoAtual = EstadoNavegacao.home;

  EstadoNavegacao get estado => _estadoAtual;

  /// Altera o estado de navegação
  void mudarPara(EstadoNavegacao novoEstado) {
    if (_estadoAtual != novoEstado) {
      _estadoAtual = novoEstado;
      notifyListeners();
    }
  }

  /// Retorna a tela correspondente ao estado atual
  Widget get telaAtual {
    switch (_estadoAtual) {
      case EstadoNavegacao.login:
        return const LoginPage();
      case EstadoNavegacao.dashboard:
        return DashboardPage(); // ou const se for Stateless
      case EstadoNavegacao.equipe:
        return const Placeholder(child: Text('Tela Equipe'));
      case EstadoNavegacao.contratar:
        return const Placeholder(child: Text('Tela Contratar'));
      case EstadoNavegacao.contato:
        return const Placeholder(child: Text('Tela Contato'));
      case EstadoNavegacao.home:
      default:
        return const MobileHomePage();
    }
  }
}
