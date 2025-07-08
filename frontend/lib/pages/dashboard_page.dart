import 'package:flutter/material.dart';
import 'dart:ui';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isDarkMode = false;
  int selectedIndex = 0;
  String currentView = 'dashboard';
  List<String> breadcrumb = ['Dashboard'];
  bool showNotifications = false;
  bool showSettings = false;
  bool isEditing = false;
  bool showAddWallet = false;
  bool showAddAccount = false;

  // Dados das carteiras
  List<Wallet> wallets = [
    Wallet(
      id: 1,
      name: 'Carteira Principal',
      balance: 'R\$ 187.450,20',
      change: '+2.34%',
      isPositive: true,
      color: Color(0xFF10B981),
      performance: 85,
      brokers: [
        Broker(
          id: 1,
          name: 'XP Investimentos',
          logo: 'XP',
          balance: 'R\$ 95.230,10',
          change: '+1.89%',
          isPositive: true,
          accounts: [
            Account(id: 1, number: '12345-6', agency: '0001', balance: 'R\$ 50.000,00'),
            Account(id: 2, number: '78910-1', agency: '0001', balance: 'R\$ 45.230,10'),
          ],
        ),
        Broker(
          id: 2,
          name: 'Rico Investimentos',
          logo: 'RICO',
          balance: 'R\$ 92.220,10',
          change: '+2.78%',
          isPositive: true,
          accounts: [
            Account(id: 3, number: '55555-5', agency: '0002', balance: 'R\$ 92.220,10'),
          ],
        ),
      ],
    ),
    Wallet(
      id: 2,
      name: 'Carteira Conservadora',
      balance: 'R\$ 125.890,15',
      change: '+1.12%',
      isPositive: true,
      color: Color(0xFF3B82F6),
      performance: 65,
      brokers: [
        Broker(
          id: 3,
          name: 'BTG Pactual',
          logo: 'BTG',
          balance: 'R\$ 125.890,15',
          change: '+1.12%',
          isPositive: true,
          accounts: [
            Account(id: 4, number: '99999-9', agency: '0003', balance: 'R\$ 125.890,15'),
          ],
        ),
      ],
    ),
    Wallet(
      id: 3,
      name: 'Carteira Agressiva',
      balance: 'R\$ 60.288,05',
      change: '-0.45%',
      isPositive: false,
      color: Color(0xFFF59E0B),
      performance: 45,
      brokers: [
        Broker(
          id: 4,
          name: 'Clear Corretora',
          logo: 'CLEAR',
          balance: 'R\$ 35.150,25',
          change: '-0.23%',
          isPositive: false,
          accounts: [
            Account(id: 5, number: '11111-1', agency: '0004', balance: 'R\$ 35.150,25'),
          ],
        ),
        Broker(
          id: 5,
          name: 'Modalmais',
          logo: 'MODAL',
          balance: 'R\$ 25.137,80',
          change: '-0.78%',
          isPositive: false,
          accounts: [
            Account(id: 6, number: '22222-2', agency: '0005', balance: 'R\$ 25.137,80'),
          ],
        ),
      ],
    ),
  ];

  // Dados do usuário
  UserProfile userProfile = UserProfile(
    name: 'João Silva Santos',
    phone: '(11) 99999-9999',
    cpf: '123.456.789-00',
    email: 'joao.silva@email.com',
    photo: null,
  );

  // Dados de notificações
  List<NotificationItem> notifications = [
    NotificationItem(
      id: 1,
      title: 'Nova estratégia disponível',
      message: 'Day Trade PETR4 está pronta para ativação',
      date: '2025-01-08 14:30',
      read: false,
      type: 'strategy',
    ),
    NotificationItem(
      id: 2,
      title: 'Saldo insuficiente',
      message: 'Conta XP Investimentos precisa de aporte',
      date: '2025-01-08 10:15',
      read: false,
      type: 'warning',
    ),
    NotificationItem(
      id: 3,
      title: 'Operação executada',
      message: 'Compra de VALE3 realizada com sucesso',
      date: '2025-01-07 16:45',
      read: true,
      type: 'success',
    ),
  ];

  // Dados das estratégias
  List<Strategy> strategies = [
    Strategy(
      name: 'Day Trade PETR4',
      status: 'Ativo',
      isActive: true,
      profit: '+R\$ 2.450,30',
      profitPercent: '+12.5%',
      isPositive: true,
      orders: 45,
      broker: 'XP Investimentos',
    ),
    Strategy(
      name: 'Swing Trade VALE3',
      status: 'Ativo',
      isActive: true,
      profit: '+R\$ 1.890,75',
      profitPercent: '+8.9%',
      isPositive: true,
      orders: 23,
      broker: 'Rico Investimentos',
    ),
    Strategy(
      name: 'Scalping ITUB4',
      status: 'Pausado',
      isActive: false,
      profit: '-R\$ 345,20',
      profitPercent: '-2.1%',
      isPositive: false,
      orders: 67,
      broker: 'Clear Corretora',
    ),
    Strategy(
      name: 'Position BBAS3',
      status: 'Ativo',
      isActive: true,
      profit: '+R\$ 3.120,45',
      profitPercent: '+15.8%',
      isPositive: true,
      orders: 12,
      broker: 'BTG Pactual',
    ),
    Strategy(
      name: 'Arbitragem MGLU3',
      status: 'Ativo',
      isActive: true,
      profit: '+R\$ 567,80',
      profitPercent: '+4.2%',
      isPositive: true,
      orders: 89,
      broker: 'Modalmais',
    ),
  ];

  // Dados das ordens
  List<Order> orders = [
    Order(
      date: '08/01/2025 14:32',
      asset: 'PETR4',
      type: 'Compra',
      price: 'R\$ 32,45',
      quantity: 100,
      total: 'R\$ 3.245,00',
      status: 'Executada',
    ),
    Order(
      date: '08/01/2025 14:28',
      asset: 'PETR4',
      type: 'Venda',
      price: 'R\$ 32,78',
      quantity: 100,
      total: 'R\$ 3.278,00',
      status: 'Executada',
    ),
    Order(
      date: '08/01/2025 13:45',
      asset: 'VALE3',
      type: 'Compra',
      price: 'R\$ 65,20',
      quantity: 50,
      total: 'R\$ 3.260,00',
      status: 'Executada',
    ),
    Order(
      date: '08/01/2025 11:22',
      asset: 'ITUB4',
      type: 'Venda',
      price: 'R\$ 28,90',
      quantity: 200,
      total: 'R\$ 5.780,00',
      status: 'Executada',
    ),
    Order(
      date: '08/01/2025 10:15',
      asset: 'BBAS3',
      type: 'Compra',
      price: 'R\$ 45,67',
      quantity: 75,
      total: 'R\$ 3.425,25',
      status: 'Executada',
    ),
  ];

  // Notícias financeiras
  List<NewsItem> news = [
    NewsItem(
      title: 'Petrobras anuncia novo dividendo extraordinário',
      summary: 'Empresa aprova distribuição de R\$ 15 bilhões aos acionistas',
      time: '2h atrás',
      category: 'Dividendos',
      impact: 'positive',
    ),
    NewsItem(
      title: 'Banco Central mantém Selic em 12,25%',
      summary: 'Copom decide por unanimidade manter taxa básica de juros',
      time: '4h atrás',
      category: 'Política Monetária',
      impact: 'neutral',
    ),
    NewsItem(
      title: 'Vale registra alta de 3,2% após resultado',
      summary: 'Mineradora supera expectativas no 4º trimestre',
      time: '6h atrás',
      category: 'Resultados',
      impact: 'positive',
    ),
    NewsItem(
      title: 'Dólar fecha em queda de 0,8%',
      summary: 'Moeda americana cotada a R\$ 5,85 no fechamento',
      time: '8h atrás',
      category: 'Câmbio',
      impact: 'positive',
    ),
  ];

  // Dados de notas fiscais
  List<Invoice> invoices = [
    Invoice(
      id: 1,
      broker: 'XP Investimentos',
      invoiceNumber: 'NF-2025-001',
      client: 'João Silva Santos',
      account: '12345-6',
      value: 'R\$ 1.250,00',
      date: '2025-01-08',
    ),
    Invoice(
      id: 2,
      broker: 'Rico Investimentos',
      invoiceNumber: 'NF-2025-002',
      client: 'João Silva Santos',
      account: '55555-5',
      value: 'R\$ 890,50',
      date: '2025-01-07',
    ),
    Invoice(
      id: 3,
      broker: 'BTG Pactual',
      invoiceNumber: 'NF-2025-003',
      client: 'João Silva Santos',
      account: '99999-9',
      value: 'R\$ 2.100,75',
      date: '2025-01-06',
    ),
  ];

  Wallet? selectedWallet;
  Broker? selectedBroker;
  Strategy? selectedStrategy;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void navigateToWallets() {
    setState(() {
      currentView = 'wallets';
      breadcrumb = ['Dashboard', 'Carteiras'];
    });
  }

  void navigateToAllBrokers() {
    setState(() {
      currentView = 'allBrokers';
      breadcrumb = ['Dashboard', 'Corretoras'];
    });
  }

  void navigateToBrokers(Wallet wallet) {
    setState(() {
      selectedWallet = wallet;
      currentView = 'brokers';
      breadcrumb = ['Dashboard', 'Carteiras', wallet.name];
    });
  }

  void navigateToAccounts(Broker broker) {
    setState(() {
      selectedBroker = broker;
      currentView = 'accounts';
      breadcrumb = ['Dashboard', 'Carteiras', selectedWallet!.name, broker.name];
    });
  }

  void navigateToStrategies() {
    setState(() {
      currentView = 'strategies';
      selectedIndex = 2;
      breadcrumb = ['Dashboard', 'Operações'];
    });
  }

  void navigateToStrategy(Strategy strategy) {
    setState(() {
      selectedStrategy = strategy;
      currentView = 'strategy';
      breadcrumb = [...breadcrumb, strategy.name];
    });
  }

  void navigateToOrders() {
    setState(() {
      currentView = 'orders';
      breadcrumb = [...breadcrumb, 'Ordens'];
    });
  }

  void navigateToNews() {
    setState(() {
      currentView = 'news';
      selectedIndex = 1;
      breadcrumb = ['Dashboard', 'Notícias'];
    });
  }

  void navigateToProfile() {
    setState(() {
      currentView = 'profile';
      selectedIndex = 4;
      breadcrumb = ['Dashboard', 'Perfil'];
    });
  }

  void navigateToInvoices() {
    setState(() {
      currentView = 'invoices';
      selectedIndex = 3;
      breadcrumb = ['Dashboard', 'Nota Fiscal'];
    });
  }

  void navigateToBreadcrumb(int index) {
    setState(() {
      List<String> newBreadcrumb = breadcrumb.sublist(0, index + 1);
      breadcrumb = newBreadcrumb;

      if (newBreadcrumb.length == 1) {
        // Dashboard
        currentView = 'dashboard';
        selectedWallet = null;
        selectedBroker = null;
        selectedStrategy = null;
        selectedIndex = 0;
      } else if (newBreadcrumb.length == 2) {
        // Segundo nível
        String secondLevel = newBreadcrumb[1];
        selectedBroker = null;
        selectedStrategy = null;

        if (secondLevel == 'Carteiras') {
          currentView = 'wallets';
          selectedWallet = null;
        } else if (secondLevel == 'Corretoras') {
          currentView = 'allBrokers';
          selectedWallet = null;
        } else if (secondLevel == 'Operações') {
          currentView = 'strategies';
          selectedIndex = 2;
        } else if (secondLevel == 'Notícias') {
          currentView = 'news';
          selectedIndex = 1;
        } else if (secondLevel == 'Perfil') {
          currentView = 'profile';
          selectedIndex = 4;
        } else if (secondLevel == 'Nota Fiscal') {
          currentView = 'invoices';
          selectedIndex = 3;
        }
      } else if (newBreadcrumb.length == 3) {
        // Terceiro nível
        if (breadcrumb[1] == 'Carteiras') {
          currentView = 'brokers';
          selectedBroker = null;
          selectedStrategy = null;
        }
      } else if (newBreadcrumb.length == 4) {
        // Quarto nível
        currentView = 'accounts';
        selectedStrategy = null;
      }
    });
  }

  void navigateBack() {
    if (breadcrumb.length > 1) {
      setState(() {
        List<String> newBreadcrumb = breadcrumb.sublist(0, breadcrumb.length - 1);
        breadcrumb = newBreadcrumb;

        if (newBreadcrumb.length == 1) {
          currentView = 'dashboard';
          selectedWallet = null;
          selectedBroker = null;
          selectedStrategy = null;
        } else if (newBreadcrumb[newBreadcrumb.length - 1] == 'Carteiras') {
          currentView = 'wallets';
          selectedBroker = null;
          selectedStrategy = null;
        } else if (newBreadcrumb[newBreadcrumb.length - 1] == 'Corretoras') {
          currentView = 'allBrokers';
          selectedBroker = null;
          selectedStrategy = null;
        } else if (newBreadcrumb.length == 3) {
          currentView = 'brokers';
          selectedBroker = null;
          selectedStrategy = null;
        } else if (newBreadcrumb[newBreadcrumb.length - 1] == 'Estratégias') {
          currentView = 'strategies';
          selectedStrategy = null;
        } else if (newBreadcrumb.length == 5) {
          currentView = 'strategy';
        }
      });
    }
  }

  void markNotificationAsRead(int notificationId) {
    setState(() {
      notifications = notifications.map((notif) =>
          notif.id == notificationId ? notif.copyWith(read: true) : notif).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF0F172A) : Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.3)
                : Colors.white.withOpacity(0.6),
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode 
                    ? Color(0xFF334155).withOpacity(0.5)
                    : Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'TC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TechCorp Quantum Systems',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        'Quantum Capital Manager',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _buildHeaderButton(
                      icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      onPressed: toggleTheme,
                    ),
                    SizedBox(width: 8),
                    _buildHeaderButton(
                      icon: Icons.notifications,
                      onPressed: () {
                        setState(() {
                          showNotifications = !showNotifications;
                        });
                      },
                      hasNotification: notifications.any((n) => !n.read),
                    ),
                    SizedBox(width: 8),
                    _buildHeaderButton(
                      icon: Icons.settings,
                      onPressed: () {
                        setState(() {
                          showSettings = !showSettings;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Breadcrumb
          if (breadcrumb.length > 1) _buildBreadcrumb(),

          // Main Content
          Expanded(
            child: _buildCurrentView(),
          ),

          // Bottom Navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool hasNotification = false,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDarkMode 
          ? Color(0xFF1E293B).withOpacity(0.3)
          : Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode 
            ? Color(0xFF334155).withOpacity(0.5)
            : Colors.white.withOpacity(0.2),
        ),
      ),
      child: Stack(
        children: [
          IconButton(
            icon: Icon(icon, size: 18),
            onPressed: onPressed,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          if (hasNotification)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 16),
            onPressed: navigateBack,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Row(
              children: breadcrumb.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                bool isLast = index == breadcrumb.length - 1;

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => navigateToBreadcrumb(index),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          color: isLast
                              ? (isDarkMode ? Colors.white : Colors.black)
                              : Colors.grey[500],
                          fontWeight: isLast ? FontWeight.w500 : FontWeight.normal,
                          decoration: isLast ? TextDecoration.none : TextDecoration.underline,
                        ),
                      ),
                    ),
                    if (!isLast) ...[
                      SizedBox(width: 8),
                      Text(
                        '>',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      SizedBox(width: 8),
                    ],
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (currentView) {
      case 'wallets':
        return _buildWalletsView();
      case 'allBrokers':
        return _buildAllBrokersView();
      case 'brokers':
        return _buildBrokersView();
      case 'accounts':
        return _buildAccountsView();
      case 'strategies':
        return _buildStrategiesView();
      case 'strategy':
        return _buildStrategyView();
      case 'orders':
        return _buildOrdersView();
      case 'news':
        return _buildNewsView();
      case 'profile':
        return _buildProfileView();
      case 'invoices':
        return _buildInvoicesView();
      default:
        return _buildDashboardView();
    }
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Patrimônio Total com Gráfico
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF3B82F6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patrimônio Total',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'R\$ 373.628,40',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+1,89% hoje',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Performance vs Mercado',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+25%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'SEU CAPITAL 🏆',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Gráfico simplificado
                Container(
                  height: 80,
                  child: CustomPaint(
                    painter: SimpleChartPainter(isDarkMode: false),
                    size: Size.infinite,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Ações Rápidas
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildActionButton(
                title: 'Carteiras',
                icon: Icons.account_balance_wallet,
                count: '3',
                onTap: navigateToWallets,
              ),
              _buildActionButton(
                title: 'Estratégias',
                icon: Icons.trending_up,
                count: '9',
                onTap: navigateToStrategies,
              ),
              _buildActionButton(
                title: 'Corretoras',
                icon: Icons.business,
                count: '5',
                onTap: navigateToAllBrokers,
              ),
              _buildActionButton(
                title: 'Histórico',
                icon: Icons.history,
                count: '',
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: 24),

          // Separador visual
          if (!isDarkMode)
            Container(
              height: 1,
              color: Colors.grey[200]?.withOpacity(0.5),
            ),

          SizedBox(height: 24),

          // Gráfico de Comparação de Carteiras
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Desempenho das Carteiras',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 120,
                  child: CustomPaint(
                    painter: WalletChartPainter(wallets: wallets, isDarkMode: isDarkMode),
                    size: Size.infinite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode 
            ? Color(0xFF1E293B).withOpacity(0.5)
            : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: Color(0xFF10B981),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            if (count.isNotEmpty) ...[
              SizedBox(height: 4),
              Text(
                count,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWalletsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Botão Adicionar Carteira
          GestureDetector(
            onTap: () {
              setState(() {
                showAddWallet = true;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode 
                  ? Color(0xFF1E293B).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF10B981).withOpacity(0.6),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xFF10B981),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Adicionar Nova Carteira',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Lista de Carteiras
          ...wallets.map((wallet) => Container(
            margin: EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () => navigateToBrokers(wallet),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode 
                    ? Color(0xFF1E293B).withOpacity(0.5)
                    : Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF3B82F6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wallet.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            wallet.balance,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            wallet.change,
                            style: TextStyle(
                              fontSize: 14,
                              color: wallet.isPositive ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAllBrokersView() {
    List<BrokerWithWallet> allBrokers = [];
    for (var wallet in wallets) {
      for (var broker in wallet.brokers) {
        allBrokers.add(BrokerWithWallet(
          broker: broker,
          walletName: wallet.name,
          walletColor: wallet.color,
        ));
      }
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: allBrokers.map((brokerWithWallet) => Container(
          margin: EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              // Encontrar a carteira original para navegação
              Wallet? originalWallet = wallets.firstWhere(
                (w) => w.name == brokerWithWallet.walletName,
              );
              selectedWallet = originalWallet;
              navigateToAccounts(brokerWithWallet.broker);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode 
                  ? Color(0xFF1E293B).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        brokerWithWallet.broker.logo,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brokerWithWallet.broker.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Carteira: ${brokerWithWallet.walletName}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          brokerWithWallet.broker.balance,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          brokerWithWallet.broker.change,
                          style: TextStyle(
                            fontSize: 14,
                            color: brokerWithWallet.broker.isPositive ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: brokerWithWallet.walletColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildBrokersView() {
    if (selectedWallet == null) return Container();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: selectedWallet!.brokers.map((broker) => Container(
          margin: EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () => navigateToAccounts(broker),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode 
                  ? Color(0xFF1E293B).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        broker.logo,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          broker.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          broker.balance,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          broker.change,
                          style: TextStyle(
                            fontSize: 14,
                            color: broker.isPositive ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildAccountsView() {
    if (selectedBroker == null) return Container();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Botão Adicionar Conta
          GestureDetector(
            onTap: () {
              setState(() {
                showAddAccount = true;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode 
                  ? Color(0xFF1E293B).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF10B981).withOpacity(0.6),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xFF10B981),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Adicionar Nova Conta',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Lista de Contas
          ...selectedBroker!.accounts.map((account) => Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode 
                  ? Color(0xFF1E293B).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conta ${account.number}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Agência: ${account.agency}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          account.balance,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 16,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Implementar remoção de conta
                    },
                  ),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildStrategiesView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: strategies.map((strategy) => Container(
          margin: EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () => navigateToStrategy(strategy),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode 
                  ? Color(0xFF1E293B).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: strategy.isActive ? Colors.green : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strategy.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              strategy.status,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Resultado',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            strategy.profit,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            strategy.profitPercent,
                            style: TextStyle(
                              fontSize: 14,
                              color: strategy.isPositive ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ordens: ${strategy.orders}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: strategy.isActive 
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          strategy.status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: strategy.isActive ? Colors.green : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildStrategyView() {
    if (selectedStrategy == null) return Container();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Header da Estratégia
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF3B82F6)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedStrategy!.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Status: ${selectedStrategy!.status}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resultado',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            selectedStrategy!.profit,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Percentual',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            selectedStrategy!.profitPercent,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Controles
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedStrategy = selectedStrategy!.copyWith(
                        isActive: !selectedStrategy!.isActive,
                        status: selectedStrategy!.isActive ? 'Pausado' : 'Ativo',
                      );
                      
                      // Atualizar na lista principal
                      strategies = strategies.map((s) =>
                          s.name == selectedStrategy!.name ? selectedStrategy! : s).toList();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selectedStrategy!.isActive ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          selectedStrategy!.isActive ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(height: 4),
                        Text(
                          selectedStrategy!.isActive ? 'Pausar' : 'Ativar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: navigateToOrders,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.list,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ordens',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Informações da Estratégia
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações da Estratégia',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                _buildInfoRow('Corretora', selectedStrategy!.broker),
                _buildInfoRow('Total de Ordens', selectedStrategy!.orders.toString()),
                _buildInfoRow('Resultado', selectedStrategy!.profit),
                _buildInfoRow(
                  'Percentual', 
                  selectedStrategy!.profitPercent,
                  valueColor: selectedStrategy!.isPositive ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: valueColor ?? (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: orders.map((order) => Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.asset,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          order.date,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: order.type == 'Compra' 
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        order.type,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: order.type == 'Compra' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preço',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            order.price,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantidade',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            order.quantity.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            order.total,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildNewsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: news.map((item) => Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(item.category).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _getCategoryColor(item.category),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.summary,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Dividendos':
        return Colors.green;
      case 'Política Monetária':
        return Colors.orange;
      case 'Resultados':
        return Colors.green;
      case 'Câmbio':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Foto e Info Principal
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF3B82F6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: userProfile.photo != null
                          ? ClipOval(
                              child: Image.network(
                                userProfile.photo!,
                                width: 96,
                                height: 96,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  userProfile.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  userProfile.email,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Dados do Usuário
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dados Pessoais',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                        color: Color(0xFF10B981),
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                if (isEditing)
                  _buildProfileEditForm()
                else
                  Column(
                    children: [
                      _buildProfileInfoRow('Nome Completo', userProfile.name),
                      _buildProfileInfoRow('Telefone', userProfile.phone),
                      _buildProfileInfoRow('CPF', userProfile.cpf),
                      _buildProfileInfoRow('E-mail', userProfile.email),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileEditForm() {
    TextEditingController nameController = TextEditingController(text: userProfile.name);
    TextEditingController cpfController = TextEditingController(text: userProfile.cpf);

    return Column(
      children: [
        _buildTextField('Nome Completo', nameController),
        SizedBox(height: 16),
        _buildTextField('CPF', cpfController),
        SizedBox(height: 16),
        _buildTextField('Telefone (não editável)', TextEditingController(text: userProfile.phone), enabled: false),
        SizedBox(height: 16),
        _buildTextField('E-mail (não editável)', TextEditingController(text: userProfile.email), enabled: false),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close, size: 16),
                    SizedBox(width: 8),
                    Text('Cancelar'),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    userProfile = userProfile.copyWith(
                      name: nameController.text,
                      cpf: cpfController.text,
                    );
                    isEditing = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10B981),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, size: 16),
                    SizedBox(width: 8),
                    Text('Salvar'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Color(0xFF334155) : Color(0xFFD1D5DB),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Color(0xFF334155) : Color(0xFFD1D5DB),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xFF10B981),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: enabled 
              ? (isDarkMode ? Color(0xFF334155) : Colors.white)
              : (isDarkMode ? Color(0xFF475569) : Color(0xFFF3F4F6)),
          ),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildInvoicesView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: invoices.map((invoice) => Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Color(0xFF1E293B).withOpacity(0.5)
                : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoice.invoiceNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          invoice.broker,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          invoice.value,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          invoice.date,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cliente',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            invoice.client,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conta',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            invoice.account,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: isDarkMode 
          ? Color(0xFF1E293B).withOpacity(0.3)
          : Colors.white.withOpacity(0.6),
        border: Border(
          top: BorderSide(
            color: isDarkMode 
              ? Color(0xFF334155).withOpacity(0.5)
              : Colors.white.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: 'Início',
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
                currentView = 'dashboard';
                breadcrumb = ['Dashboard'];
              });
            },
          ),
          _buildNavItem(
            icon: Icons.article,
            label: 'Notícias',
            isSelected: selectedIndex == 1,
            onTap: navigateToNews,
          ),
          _buildNavItem(
            icon: Icons.trending_up,
            label: 'Operações',
            isSelected: selectedIndex == 2,
            onTap: navigateToStrategies,
          ),
          _buildNavItem(
            icon: Icons.receipt,
            label: 'Nota Fiscal',
            isSelected: selectedIndex == 3,
            onTap: navigateToInvoices,
          ),
          _buildNavItem(
            icon: Icons.person,
            label: 'Perfil',
            isSelected: selectedIndex == 4,
            onTap: navigateToProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22,
            color: isSelected ? Color(0xFF10B981) : Colors.grey[500],
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Color(0xFF10B981) : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

// Classes de modelo
class Wallet {
  final int id;
  final String name;
  final String balance;
  final String change;
  final bool isPositive;
  final Color color;
  final int performance;
  final List<Broker> brokers;

  Wallet({
    required this.id,
    required this.name,
    required this.balance,
    required this.change,
    required this.isPositive,
    required this.color,
    required this.performance,
    required this.brokers,
  });
}

class Broker {
  final int id;
  final String name;
  final String logo;
  final String balance;
  final String change;
  final bool isPositive;
  final List<Account> accounts;

  Broker({
    required this.id,
    required this.name,
    required this.logo,
    required this.balance,
    required this.change,
    required this.isPositive,
    required this.accounts,
  });
}

class Account {
  final int id;
  final String number;
  final String agency;
  final String balance;

  Account({
    required this.id,
    required this.number,
    required this.agency,
    required this.balance,
  });
}

class UserProfile {
  final String name;
  final String phone;
  final String cpf;
  final String email;
  final String? photo;

  UserProfile({
    required this.name,
    required this.phone,
    required this.cpf,
    required this.email,
    this.photo,
  });

  UserProfile copyWith({
    String? name,
    String? phone,
    String? cpf,
    String? email,
    String? photo,
  }) {
    return UserProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      photo: photo ?? this.photo,
    );
  }
}

class NotificationItem {
  final int id;
  final String title;
  final String message;
  final String date;
  final bool read;
  final String type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.read,
    required this.type,
  });

  NotificationItem copyWith({
    int? id,
    String? title,
    String? message,
    String? date,
    bool? read,
    String? type,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      read: read ?? this.read,
      type: type ?? this.type,
    );
  }
}

class Strategy {
  final String name;
  final String status;
  final bool isActive;
  final String profit;
  final String profitPercent;
  final bool isPositive;
  final int orders;
  final String broker;

  Strategy({
    required this.name,
    required this.status,
    required this.isActive,
    required this.profit,
    required this.profitPercent,
    required this.isPositive,
    required this.orders,
    required this.broker,
  });

  Strategy copyWith({
    String? name,
    String? status,
    bool? isActive,
    String? profit,
    String? profitPercent,
    bool? isPositive,
    int? orders,
    String? broker,
  }) {
    return Strategy(
      name: name ?? this.name,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      profit: profit ?? this.profit,
      profitPercent: profitPercent ?? this.profitPercent,
      isPositive: isPositive ?? this.isPositive,
      orders: orders ?? this.orders,
      broker: broker ?? this.broker,
    );
  }
}

class Order {
  final String date;
  final String asset;
  final String type;
  final String price;
  final int quantity;
  final String total;
  final String status;

  Order({
    required this.date,
    required this.asset,
    required this.type,
    required this.price,
    required this.quantity,
    required this.total,
    required this.status,
  });
}

class NewsItem {
  final String title;
  final String summary;
  final String time;
  final String category;
  final String impact;

  NewsItem({
    required this.title,
    required this.summary,
    required this.time,
    required this.category,
    required this.impact,
  });
}

class Invoice {
  final int id;
  final String broker;
  final String invoiceNumber;
  final String client;
  final String account;
  final String value;
  final String date;

  Invoice({
    required this.id,
    required this.broker,
    required this.invoiceNumber,
    required this.client,
    required this.account,
    required this.value,
    required this.date,
  });
}

class BrokerWithWallet {
  final Broker broker;
  final String walletName;
  final Color walletColor;

  BrokerWithWallet({
    required this.broker,
    required this.walletName,
    required this.walletColor,
  });
}

// Painters para gráficos customizados
class SimpleChartPainter extends CustomPainter {
  final bool isDarkMode;

  SimpleChartPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    // Dados simulados para o gráfico
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.1),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Desenhar pontos
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WalletChartPainter extends CustomPainter {
  final List<Wallet> wallets;
  final bool isDarkMode;

  WalletChartPainter({required this.wallets, required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (wallets.length * 2);
    final maxHeight = size.height * 0.8;

    for (int i = 0; i < wallets.length; i++) {
      final wallet = wallets[i];
      final barHeight = (wallet.performance / 100) * maxHeight;
      final x = (i * 2 + 1) * barWidth;
      final y = size.height - barHeight;

      // Desenhar barra
      final barPaint = Paint()
        ..color = wallet.color.withOpacity(0.8)
        ..style = PaintingStyle.fill;

      final barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x - barWidth * 0.4, y, barWidth * 0.8, barHeight),
        Radius.circular(4),
      );

      canvas.drawRRect(barRect, barPaint);

      // Desenhar borda
      final borderPaint = Paint()
        ..color = wallet.color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawRRect(barRect, borderPaint);

      // Desenhar texto do percentual
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${wallet.performance}%',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - 20),
      );

      // Desenhar nome da carteira
      final namePainter = TextPainter(
        text: TextSpan(
          text: wallet.name.split(' ')[1], // Pegar apenas a segunda palavra
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      namePainter.layout();
      namePainter.paint(
        canvas,
        Offset(x - namePainter.width / 2, size.height - 15),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

