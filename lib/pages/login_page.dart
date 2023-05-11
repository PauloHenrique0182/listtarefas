import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/controller/login_controller.dart';
import 'package:projsabado/repository/login_repository.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final loginRep = LoginRepository(dio: Dio());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(loginPageController);
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
                    onSaved: (value) => ref
                        .read(loginPageController.notifier)
                        .changeName(value!),
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
                      onPressed: () async => {
                            ref
                                .read(loginPageController.notifier)
                                .changeUserLogged(),
                            print('Nome: ${pageController.userName}'),
                            print(pageController.password),
                            print('show pass: ${pageController.showPassword}'),
                            print(
                                'User esta logado: ${pageController.userLogged}'),
                            context.push('/home'),
                          },
                      child: Text('Logar')),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
