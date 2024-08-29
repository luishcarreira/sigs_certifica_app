import 'package:sigs_certifica_app/domain/enums/eassinatura_status_enum.dart';
import 'package:sigs_certifica_app/domain/models/base_model.dart';

class Assinatura implements BaseModel {
  @override
  int? id;
  @override
  int? usuarioInclusao;
  @override
  DateTime? inclusao;
  @override
  DateTime? alteracao;
  @override
  int? usuarioAlteracao;

  final int idDocumento;
  final int idTipoParte;
  final int idParte;
  final String? parteNome;
  final int idTipoPapel;
  final int idAssinante;
  final String? assinanteNome;
  final bool obrigatorio;
  final EAssinaturaStatus status;
  final bool conjunto;
  final String? arquivoPKCS7;
  final String? motivoRejeicao;
  final DateTime dataAssinatura;
  final int fonteAssinatura;
  final String? tipoCertificado;
  final int idCliente;
  final int idOperacao;
  final bool cifrado;
  final String? pinAssinatura;
  final int idDispositivo;
  final int idContratante;
  final int idHistoricoToken;

  Assinatura({
    required this.id,
    this.alteracao,
    this.usuarioAlteracao,
    required this.inclusao,
    this.usuarioInclusao,
    required this.idDocumento,
    required this.idTipoParte,
    required this.idParte,
    this.parteNome,
    required this.idTipoPapel,
    required this.idAssinante,
    this.assinanteNome,
    required this.obrigatorio,
    required this.status,
    required this.conjunto,
    this.arquivoPKCS7,
    this.motivoRejeicao,
    required this.dataAssinatura,
    required this.fonteAssinatura,
    this.tipoCertificado,
    required this.idCliente,
    required this.idOperacao,
    required this.cifrado,
    this.pinAssinatura,
    required this.idDispositivo,
    required this.idContratante,
    required this.idHistoricoToken,
  });

  factory Assinatura.newAssinatura({
    required int idDocumento,
    required int idTipoParte,
    required int idParte,
    required int idTipoPapel,
    required int idAssinante,
    bool obrigatorio = false,
    EAssinaturaStatus status = EAssinaturaStatus.emProcessoCriacao,
    bool conjunto = false,
    required DateTime dataAssinatura,
    required int fonteAssinatura,
    required int idCliente,
    required int idOperacao,
    required bool cifrado,
    required int idDispositivo,
    required int idContratante,
    required int idHistoricoToken,
    DateTime? alteracao,
    int? usuarioAlteracao,
    DateTime? inclusao,
    int? usuarioInclusao,
    String? parteNome,
    String? assinanteNome,
    String? arquivoPKCS7,
    String? motivoRejeicao,
    String? tipoCertificado,
    String? pinAssinatura,
  }) {
    return Assinatura(
      id: -1,
      alteracao: alteracao,
      usuarioAlteracao: usuarioAlteracao,
      inclusao: inclusao ?? DateTime.now(),
      usuarioInclusao: usuarioInclusao,
      idDocumento: idDocumento,
      idTipoParte: idTipoParte,
      idParte: idParte,
      parteNome: parteNome,
      idTipoPapel: idTipoPapel,
      idAssinante: idAssinante,
      assinanteNome: assinanteNome,
      obrigatorio: obrigatorio,
      status: status,
      conjunto: conjunto,
      arquivoPKCS7: arquivoPKCS7,
      motivoRejeicao: motivoRejeicao,
      dataAssinatura: dataAssinatura,
      fonteAssinatura: fonteAssinatura,
      tipoCertificado: tipoCertificado,
      idCliente: idCliente,
      idOperacao: idOperacao,
      cifrado: cifrado,
      pinAssinatura: pinAssinatura,
      idDispositivo: idDispositivo,
      idContratante: idContratante,
      idHistoricoToken: idHistoricoToken,
    );
  }

  Assinatura copyWith({
    int? id,
    DateTime? alteracao,
    int? usuarioAlteracao,
    DateTime? inclusao,
    int? usuarioInclusao,
    int? idDocumento,
    int? idTipoParte,
    int? idParte,
    String? parteNome,
    int? idTipoPapel,
    int? idAssinante,
    String? assinanteNome,
    bool? obrigatorio,
    EAssinaturaStatus? status,
    bool? conjunto,
    String? arquivoPKCS7,
    String? motivoRejeicao,
    DateTime? dataAssinatura,
    int? fonteAssinatura,
    String? tipoCertificado,
    int? idCliente,
    int? idOperacao,
    bool? cifrado,
    String? pinAssinatura,
    int? idDispositivo,
    int? idContratante,
    int? idHistoricoToken,
  }) {
    return Assinatura(
      id: id ?? this.id,
      alteracao: alteracao ?? this.alteracao,
      usuarioAlteracao: usuarioAlteracao ?? this.usuarioAlteracao,
      inclusao: inclusao ?? this.inclusao,
      usuarioInclusao: usuarioInclusao ?? this.usuarioInclusao,
      idDocumento: idDocumento ?? this.idDocumento,
      idTipoParte: idTipoParte ?? this.idTipoParte,
      idParte: idParte ?? this.idParte,
      parteNome: parteNome ?? this.parteNome,
      idTipoPapel: idTipoPapel ?? this.idTipoPapel,
      idAssinante: idAssinante ?? this.idAssinante,
      assinanteNome: assinanteNome ?? this.assinanteNome,
      obrigatorio: obrigatorio ?? this.obrigatorio,
      status: status ?? this.status,
      conjunto: conjunto ?? this.conjunto,
      arquivoPKCS7: arquivoPKCS7 ?? this.arquivoPKCS7,
      motivoRejeicao: motivoRejeicao ?? this.motivoRejeicao,
      dataAssinatura: dataAssinatura ?? this.dataAssinatura,
      fonteAssinatura: fonteAssinatura ?? this.fonteAssinatura,
      tipoCertificado: tipoCertificado ?? this.tipoCertificado,
      idCliente: idCliente ?? this.idCliente,
      idOperacao: idOperacao ?? this.idOperacao,
      cifrado: cifrado ?? this.cifrado,
      pinAssinatura: pinAssinatura ?? this.pinAssinatura,
      idDispositivo: idDispositivo ?? this.idDispositivo,
      idContratante: idContratante ?? this.idContratante,
      idHistoricoToken: idHistoricoToken ?? this.idHistoricoToken,
    );
  }

  factory Assinatura.fromJson(Map<String, dynamic> json) => Assinatura(
        id: json['id'] as int,
        alteracao: json['alteracao'] != null
            ? DateTime.parse(json['alteracao'])
            : null,
        usuarioAlteracao: json['usuarioAlteracao'] as int?,
        inclusao: DateTime.parse(json['inclusao'] as String),
        usuarioInclusao: json['usuarioInclusao'] as int?,
        idDocumento: json['idDocumento'] as int,
        idTipoParte: json['idTipoParte'] as int,
        idParte: json['idParte'] as int,
        parteNome: json['parteNome'] as String?,
        idTipoPapel: json['idTipoPapel'] as int,
        idAssinante: json['idAssinante'] as int,
        assinanteNome: json['assinanteNome'] as String?,
        obrigatorio: json['obrigatorio'] as bool,
        status: EAssinaturaStatus.values[json['status'] as int],
        conjunto: json['conjunto'] as bool,
        arquivoPKCS7: json['arquivoPKCS7'] as String?,
        motivoRejeicao: json['motivoRejeicao'] as String?,
        dataAssinatura: DateTime.parse(json['dataAssinatura'] as String),
        fonteAssinatura: json['fonteAssinatura'] as int,
        tipoCertificado: json['tipoCertificado'] as String?,
        idCliente: json['idCliente'] as int,
        idOperacao: json['idOperacao'] as int,
        cifrado: json['cifrado'] as bool,
        pinAssinatura: json['pinAssinatura'] as String?,
        idDispositivo: json['idDispositivo'] as int,
        idContratante: json['idContratante'] as int,
        idHistoricoToken: json['idHistoricoToken'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'alteracao': alteracao?.toIso8601String(),
        'usuarioAlteracao': usuarioAlteracao,
        'inclusao': inclusao!.toIso8601String(),
        'usuarioInclusao': usuarioInclusao,
        'idDocumento': idDocumento,
        'idTipoParte': idTipoParte,
        'idParte': idParte,
        'parteNome': parteNome,
        'idTipoPapel': idTipoPapel,
        'idAssinante': idAssinante,
        'assinanteNome': assinanteNome,
        'obrigatorio': obrigatorio,
        'status': status.index,
        'conjunto': conjunto,
        'arquivoPKCS7': arquivoPKCS7,
        'motivoRejeicao': motivoRejeicao,
        'dataAssinatura': dataAssinatura.toIso8601String(),
        'fonteAssinatura': fonteAssinatura,
        'tipoCertificado': tipoCertificado,
        'idCliente': idCliente,
        'idOperacao': idOperacao,
        'cifrado': cifrado,
        'pinAssinatura': pinAssinatura,
        'idDispositivo': idDispositivo,
        'idContratante': idContratante,
        'idHistoricoToken': idHistoricoToken,
      };
}
