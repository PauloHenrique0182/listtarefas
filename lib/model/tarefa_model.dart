// To parse this JSON data, do
//
//     final tarefa = tarefaFromJson(jsonString);

import 'dart:convert';

class Tarefa {
  int id;
  String titulo;
  String descricao;
  String prioridade;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
  });

  Tarefa copyWith({
    int? id,
    String? titulo,
    String? descricao,
    String? prioridade,
  }) {
    return Tarefa(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      prioridade: prioridade ?? this.prioridade,
    );
  }

  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa(
        id: json["id"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        prioridade: json["prioridade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descricao": descricao,
        "prioridade": prioridade,
      };
}

Tarefa tarefaFromJson(String str) => Tarefa.fromJson(json.decode(str));
String tarefaToJson(Tarefa data) => json.encode(data.toJson());
ListTarefaModel listTarefaModelFromJson(String str) =>
    ListTarefaModel.fromJson(json.decode(str));
String listTarefaModelToJson(ListTarefaModel data) =>
    json.encode(data.toJson());

class ListTarefaModel {
  List<Tarefa> tarefas;

  ListTarefaModel({
    required this.tarefas,
  });

  factory ListTarefaModel.fromJson(Map<String, dynamic> json) =>
      ListTarefaModel(
        tarefas:
            List<Tarefa>.from(json["tarefas"].map((x) => Tarefa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tarefas": List<dynamic>.from(tarefas.map((x) => x.toJson())),
      };
}
