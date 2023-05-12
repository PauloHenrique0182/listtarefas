import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/service/login_service.dart';

class LoginPageState {
  final GlobalKey<FormState> formKey;
  String userName;
  String password;
  bool showPassword;
  bool userLogged;

  LoginPageState({
    GlobalKey<FormState>? formKey,
    String? userName,
    String? password,
    bool? showPassword,
    bool? userLogged,
  })  : formKey = formKey ?? GlobalKey<FormState>(),
        userName = userName ?? '',
        password = password ?? '',
        showPassword = showPassword ?? false,
        userLogged = userLogged ?? false;

  LoginPageState copyWith({
    GlobalKey<FormState>? formKey,
    String? userName,
    String? password,
    bool? showPassword,
    bool? userLogged,
  }) {
    return LoginPageState(
        formKey: formKey ?? this.formKey,
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
        .watch(loginServiceProvider.notifier)
        .login(state.userName, state.password);
    state = state.copyWith(userLogged: log);
  }
}

final loginPageController =
    StateNotifierProvider<LoginController, LoginPageState>(
        (ref) => LoginController(ref: ref));
