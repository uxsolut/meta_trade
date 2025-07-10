// lib/models/login_response.dart

class LoginResponse {
  final int id;
  final String nome;
  final String email;
  final String token;

  LoginResponse({
    required this.id,
    required this.nome,
    required this.email,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }
}
