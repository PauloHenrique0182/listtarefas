import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/tarefa_model.dart';
import 'package:projsabado/repository/tarefa_repository.dart';

class TarefaPageState {
  List<Tarefa> tarefaList;
  Tarefa tarefaToEdit;

  TarefaPageState({List<Tarefa>? tarefaList, Tarefa? tarefaToEdit})
      : tarefaList = tarefaList ?? [],
        tarefaToEdit = tarefaToEdit ??
            Tarefa(id: 0, titulo: '', descricao: '', prioridade: '');
// precisa criar o copyWith do Tarefa
  TarefaPageState copyWith({List<Tarefa>? tarefaList, Tarefa? tarefaToEdit}) {
    return TarefaPageState(
        tarefaList: tarefaList ?? this.tarefaList,
        tarefaToEdit: tarefaToEdit ?? this.tarefaToEdit);
  }
}

class TarefaPageController extends StateNotifier<TarefaPageState> {
  final Ref ref;
  TarefaPageController({required this.ref}) : super(TarefaPageState());

  Future<void> findTarefaList() async {
    if (state.tarefaList.isEmpty) {
      //buscar do servico
      state = state.copyWith(
          tarefaList:
              await ref.watch(tarefaRepositoryProvider).getTarefaList());
    }
  }

  Tarefa getTarefaById(int id) {
    Tarefa tarefa = Tarefa(
        descricao: 'Fazer o exercicio',
        id: 1,
        prioridade: 'Alta',
        titulo: 'Fazer o exercicio');
    for (var element in state.tarefaList) {
      if (element.id == id) {
        tarefa = element;
      }
    }
    return tarefa;
  }

  void updateTarefa() {}
}

final tarefaPageControllerProvider =
    StateNotifierProvider<TarefaPageController, TarefaPageState>(
        (ref) => TarefaPageController(ref: ref));
