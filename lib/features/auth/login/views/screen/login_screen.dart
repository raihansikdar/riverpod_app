import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/config/app_routing/routes_path.dart';
import 'package:riverpod_app/features/auth/login/riverpod/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});


  final TextEditingController emailTEController = TextEditingController(text: 'r007@gmail.com');
  final TextEditingController passwordTEController = TextEditingController(text: '12345');

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer(
          builder: (context,ref,child) {
            final loginState = ref.watch(loginProvider);
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailTEController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordTEController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            await ref.read(loginProvider.notifier).login(
                                emailTEController.text.trim(),
                                passwordTEController.text.trim()
                            );
                            final newState = ref.read(loginProvider);

                            newState.when(
                              data: (success) {
                                if (success) {
                                  context.go(RoutesPath.homeScreen);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Login successful")),
                                  );

                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Login failed")),
                                  );
                                }
                              },
                              error: (err, _) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $err")),
                                );
                              },
                              loading: () {},
                            );
                          },
                          child: loginState.isLoading ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()) :  Text("Login"),
                        ),
                      )

                ],
              );
          }
        ),

      ),
    );
  }

}