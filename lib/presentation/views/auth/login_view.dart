import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/presentation/viewmodel/auth/login_view_model.dart';
import 'package:sigs_certifica_app/routes.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel = getIt<LoginViewModel>();

  // Controladores de texto para capturar username e password
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo_certifica_250x250.png',
                height: 100,
              ),
              const SizedBox(height: 40),

              // Username
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 40),

              // Exibir indicador de carregamento durante o login
              Watch.builder(builder: (context) {
                if (viewModel.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    await viewModel.login(username, password);

                    routes.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Login'),
                );
              }),
              const SizedBox(height: 20),

              // Exibir mensagem de erro
              Watch.builder(builder: (context) {
                if (viewModel.errorMessage.value != null) {
                  return Text(
                    viewModel.errorMessage.value!,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              }),

              // Botão de Registro
              TextButton(
                onPressed: () {
                  // Navegar para a página de registro
                },
                child: const Text("Não tem uma conta? Registre-se"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
