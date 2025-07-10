// lib/models/robo.dart

import 'dart:convert';
import 'dart:typed_data';

class Robo {
  final int id;
  final String nome;
  final Uint8List arquivo;
  final String symbol;
  final DateTime criadoEm;
  final List<String>? performance;

  Robo({
    required this.id,
    required this.nome,
    required this.arquivo,
    required this.symbol,
    required this.criadoEm,
    this.performance,
  });

  factory Robo.fromJson(Map<String, dynamic> json) {
    return Robo(
      id: json['id'] as int,
      nome: json['nome'] as String,
      // espera Base64 vindo do backend
      arquivo: base64Decode(json['arquivo'] as String),
      symbol: json['symbol'] as String,
      criadoEm: DateTime.parse(json['criado_em'] as String),
      performance: json['performance'] != null
          ? List<String>.from((json['performance'] as List<dynamic>))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'arquivo': base64Encode(arquivo),
      'symbol': symbol,
      'criado_em': criadoEm.toIso8601String(),
      'performance': performance,
    };
  }
}
