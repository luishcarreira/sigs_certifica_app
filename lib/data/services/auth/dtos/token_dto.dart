class TokenDTO {
  final String accessToken;
  final String tokenType;

  TokenDTO({required this.accessToken, required this.tokenType});

  factory TokenDTO.fromJson(Map<String, dynamic> json) {
    return TokenDTO(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}
