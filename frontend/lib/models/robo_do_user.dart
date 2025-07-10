// lib/models/robo_do_user.dart

import 'dart:convert';
import 'dart:typed_data';

class RoboDoUser {
  final int id;
  final int? idUser;
  final int? idRobo;
  final Uint8List? arquivoCliente;
  final bool ligado;
  final bool ativo;
  final bool temRequisicao;
  final int? idOrdem;
  final int? idCarteira;
  final int? idCorretora;

  RoboDoUser({
    required this.id,
    this.idUser,
    this.idRobo,
    this.arquivoCliente,
    this.ligado = false,
    this.ativo = false,
    this.temRequisicao = false,
    this.idOrdem,
    this.idCarteira,
    this.idCorretora,
  });

  factory RoboDoUser.fromJson(Map<String, dynamic> json) {
    return RoboDoUser(
      id: json['id'] as int,
      idUser: json['id_user'] as int?,
      idRobo: json['id_robo'] as int?,
      // espera que o backend envie o campo arquivo_cliente como Base64 string
      arquivoCliente: json['arquivo_cliente'] != null
          ? base64Decode(json['arquivo_cliente'] as String)
          : null,
      ligado: json['ligado'] as bool? ?? false,
      ativo: json['ativo'] as bool? ?? false,
      temRequisicao: json['tem_requisicao'] as bool? ?? false,
      idOrdem: json['id_ordem'] as int?,
      idCarteira: json['id_carteira'] as int?,
      idCorretora: json['id_corretora'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'id_robo': idRobo,
      // envia como Base64 para o backend
      'arquivo_cliente': arquivoCliente != null ? base64Encode(arquivoCliente!) : null,
      'ligado': ligado,
      'ativo': ativo,
      'tem_requisicao': temRequisicao,
      'id_ordem': idOrdem,
      'id_carteira': idCarteira,
      'id_corretora': idCorretora,
    };
  }
}
