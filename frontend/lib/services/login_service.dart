// lib/services/login_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request.dart';
import '../models/login_response.dart';

class LoginService {
  final String baseUrl;
  final http.Client _client;

  LoginService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// POST /login/ → autentica o usuário e retorna dados + token JWT
  Future<LoginResponse> login(LoginRequest request) async {
    final uri = Uri.parse('$baseUrl/login/');
    final resp = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (resp.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Erro ao autenticar (${resp.statusCode}): ${resp.body}');
    }
  }
}
