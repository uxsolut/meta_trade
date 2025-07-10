// lib/models/ordem.dart

class Ordem {
  final int id;
  final String? comentarioOrdem;
  final int? idRoboUser;
  final String? numeroUnico;
  final int? quantidade;
  final double? preco;
  final int? idUser;
  final String? contaMetaTrader;
  final String? tipo;
  final DateTime? criadoEm;

  Ordem({
    required this.id,
    this.comentarioOrdem,
    this.idRoboUser,
    this.numeroUnico,
    this.quantidade,
    this.preco,
    this.idUser,
    this.contaMetaTrader,
    this.tipo,
    this.criadoEm,
  });

  factory Ordem.fromJson(Map<String, dynamic> json) {
    return Ordem(
      id: json['id'] as int,
      comentarioOrdem: json['comentario_ordem'] as String?,
      idRoboUser: json['id_robo_user'] as int?,
      numeroUnico: json['numero_unico'] as String?,
      quantidade: json['quantidade'] as int?,
      preco: json['preco'] != null
          ? (json['preco'] as num).toDouble()
          : null,
      idUser: json['id_user'] as int?,
      contaMetaTrader: json['conta_meta_trader'] as String?,
      tipo: json['tipo'] as String?,
      criadoEm: json['criado_em'] != null
          ? DateTime.parse(json['criado_em'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comentario_ordem': comentarioOrdem,
      'id_robo_user': idRoboUser,
      'numero_unico': numeroUnico,
      'quantidade': quantidade,
      'preco': preco,
      'id_user': idUser,
      'conta_meta_trader': contaMetaTrader,
      'tipo': tipo,
      'criado_em': criadoEm?.toIso8601String(),
    };
  }
}
