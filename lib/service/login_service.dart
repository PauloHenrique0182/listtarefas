import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/login_model.dart';
import 'package:projsabado/repository/login_repository.dart';

class LoginService extends StateNotifier<LoginModel> {
  Ref ref;
  LoginRepository loginRepository;

  LoginService(
      {required this.ref,
      required this.loginRepository,
      required LoginModel loginModel})
      : super(loginModel);

  Future<bool> login(String userName, String password) async {
    bool isLogged = false;
    LoginModel login = await loginRepository.getAuth(userName, password);
    if (login.nome == userName && login.senha == password) {
      isLogged = true;
    }
    return isLogged;
  }
}

final loginServiceProvider =
    StateNotifierProvider<LoginService, LoginModel>((ref) {
  return LoginService(
    ref: ref,
    loginRepository: ref.watch(loginRepositoryProvider),
    loginModel: LoginModel(nome: '', senha: ''),
  );
});
