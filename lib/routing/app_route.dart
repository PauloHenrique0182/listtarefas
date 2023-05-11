import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/pages/home.dart';
import 'package:projsabado/pages/login_page.dart';
import 'package:projsabado/pages/page.dart';

import '../controller/login_controller.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref ref;
  RouterNotifier(this.ref) {
    ref.listen<LoginPageState?>(
      loginPageController.select((value) => value),
      (LoginPageState? previous, LoginPageState? next) {
        notifyListeners();
      },
    );
  }
}

final routerProvider = Provider<GoRouter>(
  (ref) {
    final router = RouterNotifier(ref);

    return GoRouter(
      refreshListenable: router,
      initialLocation: '/',
      // redirect: (BuildContext bc, GoRouterState state) {
      // final isLoginRoute = state.subloc == '/';
      //if (isLoginRoute && ref.watch(loginPageController).userLogged) {
      //return '/home';
      //}
      //return null;
      //},
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            child: LoginPage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const MaterialPage(
            child: HomePage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: '/tarefa/:id',
          pageBuilder: (context, state) => MaterialPage(
            child: TarefaPage(
              id: state.params['id'],
            ),
            fullscreenDialog: false,
          ),
        ),
      ],
    );
  },
);
