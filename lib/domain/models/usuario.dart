class Usuario {
  final String username;
  final int uInclusao;
  final int uAlteracao;
  final List<int> senha; // varbinary
  final String pin;
  final bool naoRecebeEmail;
  final DateTime inclusao;
  final int idUsuario;
  final int idUsuVisualizacao;
  final DateTime? emailValidado;
  final String email;
  final DateTime? celularValidado;
  final String celular;
  final bool assinaturaAutomatica;
  final bool assinaEletronicamente;
  final DateTime alteracao;

  Usuario({
    required this.username,
    required this.uInclusao,
    required this.uAlteracao,
    required this.senha,
    required this.pin,
    required this.naoRecebeEmail,
    required this.inclusao,
    required this.idUsuario,
    required this.idUsuVisualizacao,
    this.emailValidado,
    required this.email,
    this.celularValidado,
    required this.celular,
    required this.assinaturaAutomatica,
    required this.assinaEletronicamente,
    required this.alteracao,
  });

  factory Usuario.newUsuario({
    required String username,
    required List<int> senha,
    required String pin,
    required String email,
    required String celular,
    int uInclusao = -1,
    int uAlteracao = -1,
    bool naoRecebeEmail = false,
    bool assinaturaAutomatica = false,
    bool assinaEletronicamente = false,
    DateTime? emailValidado,
    DateTime? celularValidado,
    DateTime? inclusao,
    int idUsuario = -1,
    int idUsuVisualizacao = -1,
    DateTime? alteracao,
  }) {
    return Usuario(
      username: username,
      senha: senha,
      pin: pin,
      email: email,
      celular: celular,
      uInclusao: uInclusao,
      uAlteracao: uAlteracao,
      naoRecebeEmail: naoRecebeEmail,
      inclusao: inclusao ?? DateTime.now(),
      idUsuario: idUsuario,
      idUsuVisualizacao: idUsuVisualizacao,
      emailValidado: emailValidado,
      celularValidado: celularValidado,
      assinaturaAutomatica: assinaturaAutomatica,
      assinaEletronicamente: assinaEletronicamente,
      alteracao: alteracao ?? DateTime.now(),
    );
  }

  Usuario copyWith({
    String? username,
    int? uInclusao,
    int? uAlteracao,
    List<int>? senha,
    String? pin,
    bool? naoRecebeEmail,
    DateTime? inclusao,
    int? idUsuario,
    int? idUsuVisualizacao,
    DateTime? emailValidado,
    String? email,
    DateTime? celularValidado,
    String? celular,
    bool? assinaturaAutomatica,
    bool? assinaEletronicamente,
    DateTime? alteracao,
  }) {
    return Usuario(
      username: username ?? this.username,
      uInclusao: uInclusao ?? this.uInclusao,
      uAlteracao: uAlteracao ?? this.uAlteracao,
      senha: senha ?? this.senha,
      pin: pin ?? this.pin,
      naoRecebeEmail: naoRecebeEmail ?? this.naoRecebeEmail,
      inclusao: inclusao ?? this.inclusao,
      idUsuario: idUsuario ?? this.idUsuario,
      idUsuVisualizacao: idUsuVisualizacao ?? this.idUsuVisualizacao,
      emailValidado: emailValidado ?? this.emailValidado,
      email: email ?? this.email,
      celularValidado: celularValidado ?? this.celularValidado,
      celular: celular ?? this.celular,
      assinaturaAutomatica: assinaturaAutomatica ?? this.assinaturaAutomatica,
      assinaEletronicamente:
          assinaEletronicamente ?? this.assinaEletronicamente,
      alteracao: alteracao ?? this.alteracao,
    );
  }

  @override
  String toString() =>
      'Usuario username: $username, email: $email, celular: $celular, idUsuario: $idUsuario';

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        username: json['username'] as String,
        uInclusao: json['uInclusao'] as int,
        uAlteracao: json['uAlteracao'] as int,
        senha: List<int>.from(json['senha'] as List),
        pin: json['pin'] as String,
        naoRecebeEmail: json['naoRecebeEmail'] as bool,
        inclusao: DateTime.parse(json['inclusao'] as String),
        idUsuario: json['idUsuario'] as int,
        idUsuVisualizacao: json['idUsuVisualizacao'] as int,
        emailValidado: json['emailValidado'] != null
            ? DateTime.parse(json['emailValidado'])
            : null,
        email: json['email'] as String,
        celularValidado: json['celularValidado'] != null
            ? DateTime.parse(json['celularValidado'])
            : null,
        celular: json['celular'] as String,
        assinaturaAutomatica: json['assinaturaAutomatica'] as bool,
        assinaEletronicamente: json['assinaEletronicamente'] as bool,
        alteracao: DateTime.parse(json['alteracao'] as String),
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'uInclusao': uInclusao,
        'uAlteracao': uAlteracao,
        'senha': senha,
        'pin': pin,
        'naoRecebeEmail': naoRecebeEmail,
        'inclusao': inclusao.toIso8601String(),
        'idUsuario': idUsuario,
        'idUsuVisualizacao': idUsuVisualizacao,
        'emailValidado': emailValidado?.toIso8601String(),
        'email': email,
        'celularValidado': celularValidado?.toIso8601String(),
        'celular': celular,
        'assinaturaAutomatica': assinaturaAutomatica,
        'assinaEletronicamente': assinaEletronicamente,
        'alteracao': alteracao.toIso8601String(),
      };
}
