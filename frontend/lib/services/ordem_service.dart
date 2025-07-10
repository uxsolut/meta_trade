// lib/services/ordem_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ordem.dart';

class OrdemService {
  final String baseUrl;
  final http.Client _client;

  OrdemService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// GET /ordens/  → lista todas as ordens
  Future<List<Ordem>> getOrdens() async {
    final uri = Uri.parse('$baseUrl/ordens/');
    final resp = await _client.get(uri);

    if (resp.statusCode == 200) {
      final List<dynamic> body = json.decode(resp.body);
      return body.map((e) => Ordem.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar ordens (${resp.statusCode})');
    }
  }

  /// POST /ordens/  → cria uma nova ordem
  Future<Ordem> createOrdem(Ordem ordem) async {
    final uri = Uri.parse('$baseUrl/ordens/');
    final resp = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ordem.toJson()),
    );

    if (resp.statusCode == 201) {
      return Ordem.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao criar ordem (${resp.statusCode})');
    }
  }

  /// PUT /ordens/{id}  → atualiza uma ordem existente
  Future<Ordem> updateOrdem(Ordem ordem) async {
    final uri = Uri.parse('$baseUrl/ordens/${ordem.id}/');
    final resp = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ordem.toJson()),
    );

    if (resp.statusCode == 200) {
      return Ordem.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao atualizar ordem (${resp.statusCode})');
    }
  }

  /// DELETE /ordens/{id}  → exclui uma ordem
  Future<void> deleteOrdem(int id) async {
    final uri = Uri.parse('$baseUrl/ordens/$id/');
    final resp = await _client.delete(uri);

    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Erro ao deletar ordem (${resp.statusCode})');
    }
  }
}
