// lib/models/carteira.dart

class Carteira {
  final int id;
  final String nome;
  final int idUser;

  Carteira({
    required this.id,
    required this.nome,
    required this.idUser,
  });

  factory Carteira.fromJson(Map<String, dynamic> json) {
    return Carteira(
      id: json['id'] as int,
      nome: json['nome'] as String,
      idUser: json['id_user'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'id_user': idUser,
    };
  }
}
