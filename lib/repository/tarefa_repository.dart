import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/tarefa_model.dart';

class TarefaRepository {
  final Dio dio;

  TarefaRepository({required this.dio});

  Future<List<Tarefa>> getTarefaList() async {
    try {
      dio.options.validateStatus = (status) => true;
      final response = await dio.get(
          'https://b2425c80-36d7-4c43-a19f-1408fba865ae.mock.pstmn.io/tarefa');
      print(response.data);
      return ListTarefaModel.fromJson(response.data).tarefas;
    } catch (e) {
      rethrow;
    }
  }
}

final tarefaRepositoryProvider =
    Provider((ref) => TarefaRepository(dio: Dio()));
