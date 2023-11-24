import 'package:flutter_test/flutter_test.dart';
import 'package:aplicativo_de_tarefas/main.dart';

void main() {
  group('Tarefa Model Test', () {
    test('Tarefa deve iniciar não concluída', () {
      final tarefa = Tarefa(id: 1, titulo: 'Teste');
      expect(tarefa.concluida, false);
    });

    test('Toggle de Tarefa deve alternar o estado de concluída', () {
      final tarefa = Tarefa(id: 1, titulo: 'Teste');
      tarefa.toggleConcluida();
      expect(tarefa.concluida, true);
      tarefa.toggleConcluida();
      expect(tarefa.concluida, false);
    });
  });
}
