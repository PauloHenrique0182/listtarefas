import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/controller/login_controller.dart';
import 'package:projsabado/enums/path_enum.dart';
import 'package:projsabado/pages/page.dart';

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
      initialLocation: PathEnum.login.value,
      redirect: (BuildContext bc, GoRouterState state) {
        final isLoginRoute = state.subloc == PathEnum.login.value;
        if (isLoginRoute && ref.watch(loginPageController).userLogged) {
          return PathEnum.home.value;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: PathEnum.login.value,
          pageBuilder: (context, state) => const MaterialPage(
            child: LoginPage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: PathEnum.home.value,
          pageBuilder: (context, state) => const MaterialPage(
            child: HomePage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: PathEnum.tarefa.value,
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
