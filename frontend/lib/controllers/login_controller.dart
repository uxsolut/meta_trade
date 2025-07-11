import 'package:flutter/material.dart';

/// Enum para possíveis ações dentro da tela de login
enum EstadoLogin {
  preenchendoDados,
  esqueciaSenha,
  cadastro,
  logado,
}

/// Controller interno para LoginPage
class LoginController extends ChangeNotifier {
  EstadoLogin _estado = EstadoLogin.preenchendoDados;

  EstadoLogin get estado => _estado;

  void mudarPara(EstadoLogin novo) {
    if (_estado != novo) {
      _estado = novo;
      notifyListeners();
    }
  }

  void acionarEsqueciSenha() {
    _estado = EstadoLogin.esqueciaSenha;
    notifyListeners();
  }

  void acionarCadastro() {
    _estado = EstadoLogin.cadastro;
    notifyListeners();
  }

  void finalizarLogin() {
    _estado = EstadoLogin.logado;
    notifyListeners();
  }
}
