import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projsabado/controller/tarefas_controller.dart';
import 'package:projsabado/model/tarefa_model.dart';

class TarefaPage extends ConsumerWidget {
  TarefaPage({super.key, this.id});
  String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Tarefa tarefa = ref
        .read(tarefaPageControllerProvider.notifier)
        .getTarefaById(int.parse(id!));

    return Consumer(builder: (context, watch, _) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tarefa')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tarefa',
                        contentPadding: EdgeInsets.all(8),
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      controller: TextEditingController(
                        text: tarefa.titulo,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descrição:',
                        contentPadding: EdgeInsets.all(8),
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      controller: TextEditingController(
                        text: tarefa.descricao,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Text('Prioridade: '),
                          Text(
                            tarefa.prioridade,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
