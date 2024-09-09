import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/presentation/viewmodel/auth/login_view_model.dart';
import 'package:sigs_certifica_app/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginViewModel viewModel = getIt<LoginViewModel>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildLoginForm(context),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  // Construir o formulário de login
  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // Botão de login
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),

              // Exibir mensagem de erro
              Watch.builder(
                builder: (context) {
                  return viewModel.errorMessage.value != null
                      ? Text(
                          viewModel.errorMessage.value!,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox.shrink();
                },
              ),

              // Botão de registro
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

  // Overlay de carregamento
  Widget _buildLoadingOverlay() {
    return Watch.builder(
      builder: (context) {
        if (viewModel.isLoading.value) {
          return Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final username = usernameController.text;
      final password = passwordController.text;

      await viewModel.login(username, password);

      if (viewModel.errorMessage.value == null) {
        routes.go('/home');
      }
    }
  }
}
