import '../api/api_service.dart';
import 'dtos/token_dto.dart';

class ApiAuthService {
  final ApiService apiService;
  String? _authToken;

  ApiAuthService({required this.apiService});

  Future<TokenDTO?> getToken(String username, String password) async {
    // Cria o payload para enviar ao servidor
    final data = {
      'username': username,
      'password': password,
    };

    try {
      final response = await apiService.getToken('/auth/token', data);

      if (response != null) {
        // Mapeia a resposta para o TokenDTO
        TokenDTO token = TokenDTO.fromJson(response);
        _authToken = token.accessToken;
        return token;
      }
    } catch (e) {
      // Tratar erros específicos se necessário
      print("Erro durante o login: $e");
    }

    return null;
  }

  bool isLogged() {
    // Verifica se o token está presente e válido
    return _authToken != null && _authToken!.isNotEmpty;
  }

  void logout() {
    // Método para deslogar e limpar o token
    _authToken = null;
  }
}
