// Cria um enum para as rotas, para centralizar as rotas da aplicação
enum PathEnum {
  login(value: '/'),
  home(value: '/home'),
  tarefa(value: '/tarefa/:id');

  final String value;
  const PathEnum({required this.value});
}
