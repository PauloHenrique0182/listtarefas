import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/controller/tarefas_controller.dart';
import 'package:projsabado/enums/path_enum.dart';
import 'package:projsabado/model/tarefa_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(tarefaPageControllerProvider.notifier).findTarefaList();
    List<Tarefa> listTarefas =
        ref.watch(tarefaPageControllerProvider).tarefaList;

    return Consumer(builder: (context, watch, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas'),
          actions: [
            Row(
              children: [
                const Text('Adicionar Tarefa'),
                IconButton(
                  onPressed: () {
                    // Não devemos chamar o getTarefaById aqui isso é responsabilidade do TarefaPage
                    //ref
                    //    .watch(tarefaPageControllerProvider.notifier)
                    //    .getTarefaById(0);
                    context.push(
                      PathEnum.tarefa.value.replaceAll(
                        ':id',
                        '0',
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
        // Antes tinha um SingleChildScrollView aqui, mas quando temos apenas o ListView.builder não precisamos
        // pois ele já tem um SingleChildScrollView
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: listTarefas.length,
            itemBuilder: (context, index) {
              Tarefa tarefa = listTarefas[index];
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  // Não é uma boa pratica trabalhar com cores direto no ElevatedButton, devemos criar um tema
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFFFFF),
                      foregroundColor: const Color.fromARGB(255, 142, 21, 158),
                      elevation: 5),
                  onPressed: () {
                    // Não devemos chamar o getTarefaById aqui isso é responsabilidade do TarefaPage
                    //ref
                    //    .watch(tarefaPageControllerProvider.notifier)
                    //    .getTarefaById(tarefa.id);
                    context.push(
                      PathEnum.tarefa.value.replaceAll(
                        ':id',
                        tarefa.id.toString(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Text('Tarefa: '),
                              Text(
                                tarefa.titulo,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Text('Prioridade: '),
                              Text(tarefa.prioridade),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref
                                .read(tarefaPageControllerProvider.notifier)
                                .removerTarefa(tarefa);
                            _showNotification(context, tarefa);
                          },
                          icon: const Icon(Icons.delete),
                          // Não é uma boa pratica trabalhar com cores direto no ElevatedButton, devemos criar um tema
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  void _showNotification(BuildContext context, Tarefa tarefa) {
    final snackBar = SnackBar(
      content: Text('Tarefa: ${tarefa.titulo} excluida com sucesso'),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
