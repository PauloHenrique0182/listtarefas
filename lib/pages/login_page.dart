import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/controller/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(loginPageController);
    final nameController = TextEditingController(text: pageController.userName);
    final passController = TextEditingController(text: pageController.password);
    login() {
      // if (pageController.formKey.currentState!.validate()) {
      ref.read(loginPageController.notifier).changeUserLogged();
      // }
    }

    return Consumer(builder: (context, watch, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
          child: Form(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Login'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    onChanged: (value) => ref
                        .read(loginPageController.notifier)
                        .changeName(value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.abc,
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Informe o usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Password'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passController,
                    onChanged: (value) => ref
                        .read(loginPageController.notifier)
                        .changePassword(value),
                    obscureText: !pageController.showPassword,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Checkbox(
                    value: pageController.showPassword,
                    onChanged: (value) {
                      ref
                          .read(loginPageController.notifier)
                          .changeShowPassword();
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () => login(), child: const Text('Logar')),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
