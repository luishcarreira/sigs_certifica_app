import 'package:signals/signals.dart';
import 'package:sigs_certifica_app/data/services/auth/api_auth_service.dart';
import 'package:sigs_certifica_app/data/services/auth/dtos/token_dto.dart';

class LoginViewModel {
  final ApiAuthService _apiAuthService;

  final isLoading = Signal<bool>(false, debugLabel: "isLoading");
  final errorMessage = Signal<String?>(null, debugLabel: "errorMessage");
  final token = Signal<TokenDTO?>(null, debugLabel: "token");

  LoginViewModel(this._apiAuthService);

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _apiAuthService.getToken(username, password);

      if (response != null) {
        token.value = response;
      } else {
        errorMessage.value = "Erro ao tentar fazer login";
      }
    } catch (e) {
      errorMessage.value = "Erro durante o login: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
