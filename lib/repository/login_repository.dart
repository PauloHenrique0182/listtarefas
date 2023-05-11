import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/login_model.dart';

class LoginRepository {
  final Dio dio;

  LoginRepository({required this.dio});

  Future<bool> getAuth(String nome, String senha) async {
    try {
      final response = await dio.get(
          'https://b2425c80-36d7-4c43-a19f-1408fba865ae.mock.pstmn.io/login/tis/123');
      print(response.data);
      LoginModel resp = LoginModel.fromJson(response.data);
      bool isLogged = false;
      if (resp.nome == nome && resp.senha == senha) {
        isLogged = true;
        print('Usuario: ${nome} Logado');
      }
      return isLogged;
    } catch (e) {
      rethrow;
    }
  }
}

final LoginRepositoryProvider = Provider((ref) => LoginRepository(dio: Dio()));
