import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/login_model.dart';
import 'package:projsabado/repository/repository.dart';

// Extende de Repository
class LoginRepository extends Repository {
  LoginRepository();

  Future<LoginModel> getAuth(String nome, String senha) async {
    try {
      final response = await dio.get('/login/tis/123');
      LoginModel resp = LoginModel.fromJson(response.data);
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}

final loginRepositoryProvider = Provider((ref) => LoginRepository());
