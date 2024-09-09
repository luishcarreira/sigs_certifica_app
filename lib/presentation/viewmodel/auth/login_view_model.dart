import 'dart:io';

import 'package:signals/signals.dart';
import 'package:sigs_certifica_app/data/services/auth/api_auth_service.dart';
import 'package:sigs_certifica_app/data/services/auth/dtos/token_dto.dart';

class LoginViewModel {
  final ApiAuthService _apiAuthService;

  // Estados observáveis para a UI
  final isLoading = Signal<bool>(false, debugLabel: "isLoading");
  final errorMessage = Signal<String?>(null, debugLabel: "errorMessage");
  final token = Signal<TokenDTO?>(null, debugLabel: "token");

  LoginViewModel(this._apiAuthService);

  // Método de login
  Future<void> login(String username, String password) async {
    // Inicia o estado de carregamento e limpa mensagens de erro anteriores
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Chama o serviço de autenticação
      final response = await _apiAuthService.getToken(username, password);

      if (response != null) {
        // Se a resposta for válida, atualiza o token
        token.value = response;
      } else {
        // Caso a resposta não seja válida, define a mensagem de erro
        errorMessage.value = "Erro ao tentar fazer login";
      }
    } catch (e) {
      // Lida com erros específicos
      if (e is SocketException) {
        errorMessage.value = "Erro de conexão. Verifique sua internet.";
      } else if (e is HttpException) {
        errorMessage.value = "Erro no servidor: ${e.message}";
      } else {
        errorMessage.value = "Erro inesperado: $e";
      }
    } finally {
      // Finaliza o carregamento
      isLoading.value = false;
    }
  }

  // Método para resetar os estados
  void resetState() {
    errorMessage.value = null;
    isLoading.value = false;
    token.value = null;
  }

  // Método para verificar se o usuário está logado
  bool isLogged() => token.value != null;
}

