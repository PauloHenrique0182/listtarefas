import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/controller/tarefas_controller.dart';
import 'package:projsabado/model/tarefa_model.dart';

class TarefaPage extends ConsumerWidget {
  TarefaPage({super.key, this.id});
  String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tarefa = ref.read(tarefaPageControllerProvider).tarefaToEdit;
    final tituloController = TextEditingController(text: tarefa.titulo);
    final descricaoController = TextEditingController(text: tarefa.descricao);
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
                      controller: tituloController,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descrição:',
                        contentPadding: EdgeInsets.all(8),
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      onChanged: (value) {
                        ref
                            .read(tarefaPageControllerProvider.notifier)
                            .updateTarefaDescription(value);
                      },
                      controller: descricaoController,
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
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(tarefaPageControllerProvider.notifier)
                            .updateTarefa(
                              Tarefa(
                                id: tarefa.id,
                                titulo: tituloController.text,
                                descricao: descricaoController.text,
                                prioridade: tarefa.prioridade,
                              ),
                            );
                        _tarefaUpdatedAlert(context, tarefa);
                        context.push('/home');
                      },
                      child: const Text('salvar'),
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

  void _tarefaUpdatedAlert(BuildContext context, Tarefa tarefa) {
    final snackBar = SnackBar(
      content: Text('Tarefa: ${tarefa.titulo} salva com sucesso'),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
