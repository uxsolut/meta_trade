// lib/models/corretora.dart

class Corretora {
  final int id;
  final int? idRoboUser;
  final String? contaMetaTrader;

  Corretora({
    required this.id,
    this.idRoboUser,
    this.contaMetaTrader,
  });

  factory Corretora.fromJson(Map<String, dynamic> json) {
    return Corretora(
      id: json['id'] as int,
      idRoboUser: json['id_robo_user'] != null ? json['id_robo_user'] as int : null,
      contaMetaTrader: json['conta_meta_trader'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_robo_user': idRoboUser,
      'conta_meta_trader': contaMetaTrader,
    };
  }
}
