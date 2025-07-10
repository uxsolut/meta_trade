// lib/models/robo.dart

import 'dart:convert';
import 'dart:typed_data';

class Robo {
  final int id;
  final String nome;
  final Uint8List arquivo;
  final String symbol;
  final DateTime? criadoEm;

  Robo({
    required this.id,
    required this.nome,
    required this.arquivo,
    required this.symbol,
    this.criadoEm,
  });

  factory Robo.fromJson(Map<String, dynamic> json) {
    return Robo(
      id: json['id'] as int,
      nome: json['nome'] as String,
      // o backend deve enviar o bytea como string Base64
      arquivo: base64Decode(json['arquivo'] as String),
      symbol: json['symbol'] as String,
      criadoEm: json['criado_em'] != null
          ? DateTime.parse(json['criado_em'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      // converte de volta para Base64 ao enviar
      'arquivo': base64Encode(arquivo),
      'symbol': symbol,
      'criado_em': criadoEm?.toIso8601String(),
    };
  }
}
