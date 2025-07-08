# Páginas do Projeto

Esta pasta conterá as páginas adicionais do projeto:

## Páginas a Implementar

### 1. login_page.dart
```dart
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acessar')),
      body: const Center(
        child: Text('Página de Login'),
      ),
    );
  }
}
```

### 2. team_page.dart
```dart
import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equipe')),
      body: const Center(
        child: Text('Página da Equipe'),
      ),
    );
  }
}
```

### 3. contract_page.dart
```dart
import 'package:flutter/material.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contratar')),
      body: const Center(
        child: Text('Página de Contratação'),
      ),
    );
  }
}
```

### 4. contact_page.dart
```dart
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contato')),
      body: const Center(
        child: Text('Página de Contato'),
      ),
    );
  }
}
```

## Como Usar

1. Crie os arquivos acima na pasta `lib/pages/`
2. Importe-os no `main.dart`
3. Descomente as linhas de navegação na função `_navigateToPage()`

## Exemplo de Importação no main.dart

```dart
import 'pages/login_page.dart';
import 'pages/team_page.dart';
import 'pages/contract_page.dart';
import 'pages/contact_page.dart';
```

