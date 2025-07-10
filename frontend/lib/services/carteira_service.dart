// lib/services/carteira_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/carteira.dart';

class CarteiraService {
  final String baseUrl;
  final http.Client _client;

  CarteiraService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// GET /carteiras/  → lista todas as carteiras
  Future<List<Carteira>> getCarteiras() async {
    final uri = Uri.parse('$baseUrl/carteiras/');
    final resp = await _client.get(uri);

    if (resp.statusCode == 200) {
      final List<dynamic> body = json.decode(resp.body);
      return body.map((e) => Carteira.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar carteiras (${resp.statusCode})');
    }
  }

  /// POST /carteiras/  → cria uma nova carteira
  Future<Carteira> createCarteira(Carteira carteira) async {
    final uri = Uri.parse('$baseUrl/carteiras/');
    final resp = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(carteira.toJson()),
    );

    if (resp.statusCode == 201) {
      return Carteira.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao criar carteira (${resp.statusCode})');
    }
  }

  /// PUT /carteiras/{id}  → atualiza uma carteira existente
  Future<Carteira> updateCarteira(Carteira carteira) async {
    final uri = Uri.parse('$baseUrl/carteiras/${carteira.id}/');
    final resp = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(carteira.toJson()),
    );

    if (resp.statusCode == 200) {
      return Carteira.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao atualizar carteira (${resp.statusCode})');
    }
  }

  /// DELETE /carteiras/{id}  → exclui uma carteira
  Future<void> deleteCarteira(int id) async {
    final uri = Uri.parse('$baseUrl/carteiras/$id/');
    final resp = await _client.delete(uri);

    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Erro ao deletar carteira (${resp.statusCode})');
    }
  }
}
