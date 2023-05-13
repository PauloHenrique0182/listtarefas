// Criei esse arquivo para centralizar a configuração do Dio, para que não seja necessário repetir a configuração em todos os repositórios.

import 'package:dio/dio.dart';

abstract class Repository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://b2425c80-36d7-4c43-a19f-1408fba865ae.mock.pstmn.io',
    ),
  );
}
