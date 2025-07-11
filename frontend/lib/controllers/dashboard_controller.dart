import 'package:flutter/material.dart';

enum ViewDashboard {
  dashboard,
  carteiras,
  corretoras,
  contas,
  estrategias,
  ordens,
  noticias,
  perfil,
  notasFiscais,
}

class DashboardController extends ChangeNotifier {
  bool isDarkMode = false;
  bool showNotifications = false;
  bool showSettings = false;
  bool isEditing = false;
  bool showAddWallet = false;
  bool showAddAccount = false;

  ViewDashboard _currentView = ViewDashboard.dashboard;
  List<String> _breadcrumb = ['Dashboard'];

  ViewDashboard get currentView => _currentView;
  List<String> get breadcrumb => List.unmodifiable(_breadcrumb);

  void alternarTema() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void toggleNotifications() {
    showNotifications = !showNotifications;
    notifyListeners();
  }

  void toggleSettings() {
    showSettings = !showSettings;
    notifyListeners();
  }

  void toggleEditar() {
    isEditing = !isEditing;
    notifyListeners();
  }

  void toggleAddWallet() {
    showAddWallet = !showAddWallet;
    notifyListeners();
  }

  void toggleAddAccount() {
    showAddAccount = !showAddAccount;
    notifyListeners();
  }

  void navegarPara(ViewDashboard novaView, {String? labelExtra}) {
    _currentView = novaView;
    _breadcrumb = ['Dashboard'];

    switch (novaView) {
      case ViewDashboard.dashboard:
        break;
      case ViewDashboard.carteiras:
        _breadcrumb.add('Carteiras');
        break;
      case ViewDashboard.corretoras:
        _breadcrumb.add('Corretoras');
        break;
      case ViewDashboard.contas:
        _breadcrumb.add('Contas');
        break;
      case ViewDashboard.estrategias:
        _breadcrumb.add('Estratégias');
        break;
      case ViewDashboard.ordens:
        _breadcrumb.add('Ordens');
        break;
      case ViewDashboard.noticias:
        _breadcrumb.add('Notícias');
        break;
      case ViewDashboard.perfil:
        _breadcrumb.add('Perfil');
        break;
      case ViewDashboard.notasFiscais:
        _breadcrumb.add('Notas Fiscais');
        break;
    }

    if (labelExtra != null) {
      _breadcrumb.add(labelExtra);
    }

    notifyListeners();
  }

  void resetarEstado() {
    showNotifications = false;
    showSettings = false;
    isEditing = false;
    showAddWallet = false;
    showAddAccount = false;
    notifyListeners();
  }
}
