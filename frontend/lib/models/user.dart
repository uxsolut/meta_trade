// lib/models/user.dart

class User {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final String cpf;
  final int? idCorretora;

  User({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.cpf,
    this.idCorretora,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      senha: json['senha'] as String,
      cpf: json['cpf'] as String,
      idCorretora: json['id_corretora'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'cpf': cpf,
      'id_corretora': idCorretora,
    };
  }
}
