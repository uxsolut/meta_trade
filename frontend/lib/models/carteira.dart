class Carteira {
  final int id;
  final String nome;

  Carteira({
    required this.id,
    required this.nome,
  });

  factory Carteira.fromJson(Map<String, dynamic> json) {
    return Carteira(
      id: json['id'],
      nome: json['nome'],
    );
  }
}
