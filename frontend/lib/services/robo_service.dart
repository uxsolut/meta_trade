// lib/services/robo_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/robo.dart';

class RoboService {
  final String baseUrl;
  final http.Client _client;

  RoboService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// GET /robos/ → lista todos os robôs
  Future<List<Robo>> getRobos() async {
    final uri = Uri.parse('$baseUrl/robos/');
    final resp = await _client.get(uri);

    if (resp.statusCode == 200) {
      final List<dynamic> body = json.decode(resp.body);
      return body.map((e) => Robo.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar robôs (${resp.statusCode})');
    }
  }

  /// POST /robos/ → cria um novo robô
  Future<Robo> createRobo(Robo robo) async {
    final uri = Uri.parse('$baseUrl/robos/');
    final resp = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(robo.toJson()),
    );

    if (resp.statusCode == 201) {
      return Robo.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao criar robô (${resp.statusCode})');
    }
  }

  /// PUT /robos/{id}/ → atualiza um robô existente
  Future<Robo> updateRobo(Robo robo) async {
    final uri = Uri.parse('$baseUrl/robos/${robo.id}/');
    final resp = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(robo.toJson()),
    );

    if (resp.statusCode == 200) {
      return Robo.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao atualizar robô (${resp.statusCode})');
    }
  }

  /// DELETE /robos/{id}/ → exclui um robô
  Future<void> deleteRobo(int id) async {
    final uri = Uri.parse('$baseUrl/robos/$id/');
    final resp = await _client.delete(uri);

    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Erro ao deletar robô (${resp.statusCode})');
    }
  }
}
