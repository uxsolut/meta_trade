import 'package:flutter/material.dart';

/// Enum para representar cada ação ou área que o usuário pode navegar
enum EstadoHome {
  hero,
  estatisticas,
  funcionalidades,
  comoFunciona,
  vantagens,
  preco,
  depoimentos,
  blog,
  contato,
  acessar,
  equipe,
  contratar,
  contatoMenu,
}

/// Controller para gerenciar os estados internos da MobileHomePage
class HomeController extends ChangeNotifier {
  bool _menuAberto = false;
  EstadoHome _estadoAtual = EstadoHome.hero;

  bool get menuAberto => _menuAberto;
  EstadoHome get estadoAtual => _estadoAtual;

  void alternarMenu() {
    _menuAberto = !_menuAberto;
    notifyListeners();
  }

  void fecharMenu() {
    if (_menuAberto) {
      _menuAberto = false;
      notifyListeners();
    }
  }

  void navegarPara(EstadoHome novoEstado) {
    _estadoAtual = novoEstado;
    fecharMenu(); // Fecha menu ao navegar
    notifyListeners();
  }

  // Ações diretas para facilitar o uso
  void acessar() => navegarPara(EstadoHome.acessar);
  void equipe() => navegarPara(EstadoHome.equipe);
  void contratar() => navegarPara(EstadoHome.contratar);
  void contatoMenu() => navegarPara(EstadoHome.contatoMenu);
  void verHero() => navegarPara(EstadoHome.hero);
  void verEstatisticas() => navegarPara(EstadoHome.estatisticas);
  void verFuncionalidades() => navegarPara(EstadoHome.funcionalidades);
  void verComoFunciona() => navegarPara(EstadoHome.comoFunciona);
  void verVantagens() => navegarPara(EstadoHome.vantagens);
  void verPreco() => navegarPara(EstadoHome.preco);
  void verDepoimentos() => navegarPara(EstadoHome.depoimentos);
  void verBlog() => navegarPara(EstadoHome.blog);
  void verContato() => navegarPara(EstadoHome.contato);
}
