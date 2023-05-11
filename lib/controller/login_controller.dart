import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/repository/login_repository.dart';

class LoginPageState {
  String userName;
  String password;
  bool showPassword;
  bool userLogged;

  LoginPageState({
    String? userName,
    String? password,
    bool? showPassword,
    bool? userLogged,
  })  : userName = userName ?? '',
        password = password ?? '',
        showPassword = showPassword ?? false,
        userLogged = userLogged ?? false;

  LoginPageState copyWith({
    String? userName,
    String? password,
    bool? showPassword,
    bool? userLogged,
  }) {
    return LoginPageState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        showPassword: showPassword ?? this.showPassword,
        userLogged: userLogged ?? this.userLogged);
  }
}

class LoginController extends StateNotifier<LoginPageState> {
  final Ref ref;
  LoginController({required this.ref}) : super(LoginPageState());

  void changeName(String name) {
    state = state.copyWith(userName: name);
  }

  void changePassword(String pass) {
    state = state.copyWith(password: pass);
  }

  void changeShowPassword() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  Future<void> changeUserLogged() async {
    bool log = await ref
        .watch(LoginRepositoryProvider)
        .getAuth(state.userName, state.password)
        .then((value) => value);
    state = state.copyWith(userLogged: log);
  }
}

final loginPageController =
    StateNotifierProvider<LoginController, LoginPageState>(
        (ref) => LoginController(ref: ref));
