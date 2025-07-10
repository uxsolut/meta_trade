// lib/services/corretora_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/corretora.dart';

class CorretoraService {
  final String baseUrl;
  final http.Client _client;

  CorretoraService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// GET /corretoras/  → lista todas as corretoras
  Future<List<Corretora>> getCorretoras() async {
    final uri = Uri.parse('$baseUrl/corretoras/');
    final resp = await _client.get(uri);

    if (resp.statusCode == 200) {
      final List<dynamic> body = json.decode(resp.body);
      return body.map((e) => Corretora.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar corretoras (${resp.statusCode})');
    }
  }

  /// POST /corretoras/  → cria uma nova corretora
  Future<Corretora> createCorretora(Corretora corretora) async {
    final uri = Uri.parse('$baseUrl/corretoras/');
    final resp = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(corretora.toJson()),
    );

    if (resp.statusCode == 201) {
      return Corretora.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao criar corretora (${resp.statusCode})');
    }
  }

  /// PUT /corretoras/{id}  → atualiza uma corretora existente
  Future<Corretora> updateCorretora(Corretora corretora) async {
    final uri = Uri.parse('$baseUrl/corretoras/${corretora.id}/');
    final resp = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(corretora.toJson()),
    );

    if (resp.statusCode == 200) {
      return Corretora.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao atualizar corretora (${resp.statusCode})');
    }
  }

  /// DELETE /corretoras/{id}  → exclui uma corretora
  Future<void> deleteCorretora(int id) async {
    final uri = Uri.parse('$baseUrl/corretoras/$id/');
    final resp = await _client.delete(uri);

    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Erro ao deletar corretora (${resp.statusCode})');
    }
  }
}
