import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/tarefa_model.dart';
import 'package:projsabado/repository/repository.dart';

// Extends Repository
class TarefaRepository extends Repository {
  TarefaRepository();

  Future<List<Tarefa>> getTarefaList() async {
    try {
      dio.options.validateStatus = (status) => true;
      final response = await dio.get('/tarefa');
      return ListTarefaModel.fromJson(response.data).tarefas;
    } catch (e) {
      rethrow;
    }
  }
}

final tarefaRepositoryProvider = Provider((ref) => TarefaRepository());
