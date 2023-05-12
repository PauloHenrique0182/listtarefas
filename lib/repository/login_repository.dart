import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/login_model.dart';

class LoginRepository {
  final Dio dio;

  LoginRepository({required this.dio});

  Future<LoginModel> getAuth(String nome, String senha) async {
    try {
      final response = await dio.get(
          'https://b2425c80-36d7-4c43-a19f-1408fba865ae.mock.pstmn.io/login/tis/123');
      LoginModel resp = LoginModel.fromJson(response.data);
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}

final loginRepositoryProvider = Provider((ref) => LoginRepository(dio: Dio()));
