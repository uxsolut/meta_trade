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
    final user = json['user'] ?? {};

    return LoginResponse(
      id: user['id'] ?? 0,
      nome: user['nome'] ?? '',
      email: user['email'] ?? '',
      token: json['access_token'] ?? '',
    );
  }
}
