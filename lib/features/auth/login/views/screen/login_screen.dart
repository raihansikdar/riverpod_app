import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/auth/login/riverpod/login_provider.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            loginState.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await ref.read(loginProvider.notifier).login(
                            emailController.text,
                            passwordController.text,
                          );
                      final result = ref.read(loginProvider);
                      result.when(
                        data: (success) {
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Success')));
                            // Navigate to next screen
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Failed')));
                          }
                        },
                        loading: () {},
                        error: (e, _) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                        },
                      );
                    },
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
