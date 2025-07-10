// lib/services/robo_do_user_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/robo_do_user.dart';

class RoboDoUserService {
  final String baseUrl;
  final http.Client _client;

  RoboDoUserService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// GET /robos_do_user/ → lista todas as relações robô-usuário
  Future<List<RoboDoUser>> getRobosDoUser() async {
    final uri = Uri.parse('$baseUrl/robos_do_user/');
    final resp = await _client.get(uri);

    if (resp.statusCode == 200) {
      final List<dynamic> body = json.decode(resp.body);
      return body.map((e) => RoboDoUser.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar robos_do_user (${resp.statusCode})');
    }
  }

  /// POST /robos_do_user/ → cria uma nova relação robô-usuário
  Future<RoboDoUser> createRoboDoUser(RoboDoUser item) async {
    final uri = Uri.parse('$baseUrl/robos_do_user/');
    final resp = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (resp.statusCode == 201) {
      return RoboDoUser.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao criar robos_do_user (${resp.statusCode})');
    }
  }

  /// PUT /robos_do_user/{id}/ → atualiza uma relação existente
  Future<RoboDoUser> updateRoboDoUser(RoboDoUser item) async {
    final uri = Uri.parse('$baseUrl/robos_do_user/${item.id}/');
    final resp = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (resp.statusCode == 200) {
      return RoboDoUser.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao atualizar robos_do_user (${resp.statusCode})');
    }
  }

  /// DELETE /robos_do_user/{id}/ → exclui uma relação robô-usuário
  Future<void> deleteRoboDoUser(int id) async {
    final uri = Uri.parse('$baseUrl/robos_do_user/$id/');
    final resp = await _client.delete(uri);

    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Erro ao deletar robos_do_user (${resp.statusCode})');
    }
  }
}
