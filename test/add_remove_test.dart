import 'package:flutter_test/flutter_test.dart';
import 'package:aplicativo_de_tarefas/main.dart';

void main() {
  group('Testes do TarefaProvider', () {
    test('Adicionar e remover tarefa', () {
      final provider = TarefaProvider();

      expect(provider.tarefas.isEmpty, true);

      final tarefa = Tarefa(id: 1, titulo: 'Tarefa Teste');
      provider.adicionarTarefa(tarefa);

      expect(provider.tarefas.length, 1);
      expect(provider.tarefas.contains(tarefa), true);

      provider.removerTarefa(tarefa);

      expect(provider.tarefas.isEmpty, true);
    });
  });
}
