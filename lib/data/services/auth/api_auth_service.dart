import '../api/api_service.dart';
import 'dtos/token_dto.dart';

class ApiAuthService {
  final ApiService apiService;
  String? _authToken;

  ApiAuthService({required this.apiService});

  Future<TokenDTO?> getToken(String username, String password) async {
    final data = {
      'username': username,
      'password': password,
    };

    try {
      final response = await apiService.getToken('/auth/token', data);

      if (response != null) {
        // Mapeia a resposta para o TokenDTO diretamente aqui
        final token = TokenDTO.fromJson(response);
        _authToken = token.accessToken; // Salva o token para uso futuro
        return token;
      }
    } catch (e) {
      print("Erro durante o login: $e");
      rethrow; // Deixe a ViewModel lidar com erros
    }

    return null;
  }

  bool isLogged() {
    return _authToken != null && _authToken!.isNotEmpty;
  }

  void logout() {
    _authToken = null;
  }
}
