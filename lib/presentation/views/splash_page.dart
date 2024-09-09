import 'package:flutter/material.dart';
import 'package:sigs_certifica_app/data/services/auth/api_auth_service.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final ApiAuthService _authService = getIt<ApiAuthService>();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simula um delay (tempo para inicialização de serviços como SharedPreferences, Firebase etc.)
    await Future.delayed(const Duration(seconds: 2));

    // Verifica se o usuário está logado
    final bool isLogged = _authService.isLogged();

    // Redireciona para a rota correta
    if (isLogged) {
      routes.go('/home');
    } else {
      routes.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou animação de splash
            Image.asset(
              'assets/images/logo_certifica_250x250.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            // Indicador de carregamento
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
