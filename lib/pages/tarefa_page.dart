import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projsabado/controller/tarefas_controller.dart';
import 'package:projsabado/enums/prioridade_enum.dart';
import 'package:projsabado/model/tarefa_model.dart';

// Alterei o ConsumerWidget para ConsumerStatefulWidget, para ao iniciar a tela fazer o getTarefaById

class TarefaPage extends ConsumerStatefulWidget {
  final String? id;

  const TarefaPage({super.key, this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TarefaPageState();
}

class _TarefaPageState extends ConsumerState<TarefaPage> {
  @override
  void initState() {
    super.initState();
    ref.read(tarefaPageControllerProvider.notifier).getTarefaById(
          int.parse(widget.id!),
        );
  }

  @override
  Widget build(BuildContext context) {
    final tarefa = ref.watch(tarefaPageControllerProvider).tarefaToEdit;
    // Se você trabalha com um controller que tem um estado você não precisa usar o TextEditingController
    final tituloController = TextEditingController(text: tarefa.titulo);
    final descricaoController = TextEditingController(text: tarefa.descricao);

    // Antes tinha um outro Consumer aqui, mas não precisa, pois o TarefaPage extende de ConsumerWidget
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
                    onChanged: (value) => {
                      ref
                          .read(tarefaPageControllerProvider.notifier)
                          .updateTarefaTitulo(value)
                    },
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
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Prioridade',
                    ),
                    // Estava faltando o value
                    value: tarefa.prioridade,
                    items: listDrop,
                    onChanged: (value) => {
                      ref
                          .read(tarefaPageControllerProvider.notifier)
                          .updateTarefaPriority(
                            value!,
                          ),
                    },
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
                      // não é necessario passar uma tarefa aqui, pois ja atualizamos ela no controller
                      _tarefaUpdatedAlert(context, tarefa);

                      // Para voltar para a tela anterior utilizamos o pop, se fizer um push vai criar uma nova tela na pilha
                      //context.push('/home');
                      context.pop();
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
  }

  void _tarefaUpdatedAlert(BuildContext context, Tarefa tarefa) {
    final snackBar = SnackBar(
      content: Text('Tarefa: ${tarefa.titulo} salva com sucesso'),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Outras formas de criar o listDrop, eu acho que assim fica mais legível
  List<DropdownMenuItem<String>> get listDrop =>
      PrioridadeEnum.values.map<DropdownMenuItem<String>>((element) {
        return DropdownMenuItem(
          value: element.value,
          child: Text(element.value),
        );
      }).toList();

  List<DropdownMenuItem<String>> listDrop2() {
    List<DropdownMenuItem<String>> list = [];
    for (var element in PrioridadeEnum.values) {
      DropdownMenuItem<String> drop = DropdownMenuItem(
        value: element.value,
        child: Text(element.value),
      );
      list.add(drop);
    }
    return list;
  }
}
