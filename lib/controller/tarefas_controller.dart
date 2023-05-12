import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/model/tarefa_model.dart';
import 'package:projsabado/repository/tarefa_repository.dart';

class TarefaPageState {
  List<Tarefa> tarefaList;
  Tarefa tarefaToEdit;

  TarefaPageState({
    List<Tarefa>? tarefaList,
    Tarefa? tarefaToEdit,
  })  : tarefaList = tarefaList ?? [],
        tarefaToEdit = tarefaToEdit ??
            Tarefa(id: 0, titulo: '', descricao: '', prioridade: 'alta');

  TarefaPageState copyWith({
    List<Tarefa>? tarefaList,
    Tarefa? tarefaToEdit,
  }) {
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
        descricao: '', id: getSequence(), prioridade: 'alta', titulo: '');
    if (id != 0) {
      for (var element in state.tarefaList) {
        if (element.id == id) {
          tarefa = element;
        }
      }
    }

    state.tarefaToEdit = state.tarefaToEdit.copyWith(
      descricao: tarefa.descricao,
      prioridade: tarefa.prioridade,
      titulo: tarefa.titulo,
      id: tarefa.id,
    );

    return tarefa;
  }

  void removerTarefa(Tarefa tarefa) {
    state = state.copyWith(
      tarefaList: List.from(state.tarefaList)..remove(tarefa),
    );
  }

  int getSequence() {
    int maiorId = 0;
    for (Tarefa tarefa in state.tarefaList) {
      if (tarefa.id > maiorId) {
        maiorId = tarefa.id;
      }
    }
    return maiorId + 1;
  }

  void updateTarefaDescription(String desc) {
    state.tarefaToEdit = state.tarefaToEdit.copyWith(descricao: desc);
  }

  void updateTarefaTitulo(String desc) {
    state.tarefaToEdit = state.tarefaToEdit.copyWith(titulo: desc);
  }

  void updateTarefaPriority(String desc) {
    state.tarefaToEdit = state.tarefaToEdit.copyWith(prioridade: desc);
  }

  void updateTarefa(Tarefa tarefa) {
    if (isTarefaExist(tarefa.id)) {
      for (var i = 0; i < state.tarefaList.length; i++) {
        var element = state.tarefaList[i];
        if (element.id == tarefa.id) {
          state.tarefaList[i] = element.copyWith(
            descricao: tarefa.descricao,
            prioridade: tarefa.prioridade,
            titulo: tarefa.titulo,
          );
        }
      }
    } else {
      state = state.copyWith(tarefaList: [...state.tarefaList, tarefa]);
    }
  }

  bool isTarefaExist(int id) {
    bool isExist = false;
    for (var element in state.tarefaList) {
      if (element.id == id) {
        isExist = true;
      }
    }
    return isExist;
  }
}

final tarefaPageControllerProvider =
    StateNotifierProvider<TarefaPageController, TarefaPageState>(
        (ref) => TarefaPageController(ref: ref));
