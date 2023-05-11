import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/controller/tarefas_controller.dart';
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
        ),
        body: SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listTarefas.length,
                itemBuilder: (context, index) {
                  Tarefa tarefa = listTarefas[index];
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFFFFF),
                          foregroundColor:
                              const Color.fromARGB(255, 142, 21, 158),
                          elevation: 5),
                      onPressed: () {
                        context.push('/tarefa/${tarefa.id}');
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
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      );
    });
  }
}
