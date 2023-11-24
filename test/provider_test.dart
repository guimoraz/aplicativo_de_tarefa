import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:aplicativo_de_tarefas/main.dart';
import 'provider_test.mocks.dart';

@GenerateMocks([TarefaProvider])
void main() {
  group("Testes da lista de tarefas", () {
    testWidgets("Exibe duas tarefas com seus títulos na tela inicial", (WidgetTester tester) async {
      MockTarefaProvider tarefaProvider = MockTarefaProvider();
      when(tarefaProvider.tarefas).thenReturn([
        Tarefa(id: 1, titulo: "Tarefa 1"),
        Tarefa(id: 2, titulo: "Tarefa 2"),
      ]);

      Widget app = ChangeNotifierProvider<TarefaProvider>(
        create: (context) => tarefaProvider,
        child: MaterialApp(
          home: TarefasApp(),
        ),
      );

      await tester.pumpWidget(app);

      expect(find.text("Tarefa 1"), findsOneWidget);
      expect(find.text("Tarefa 2"), findsOneWidget);
    });

    testWidgets("Exibe 'nenhuma tarefa encontrada' na tela inicial quando não existir tarefas", (WidgetTester tester) async {
      MockTarefaProvider tarefaProvider = MockTarefaProvider();
      when(tarefaProvider.tarefas).thenReturn([]);

      Widget app = ChangeNotifierProvider<TarefaProvider>(
        create: (context) => tarefaProvider,
        child: MaterialApp(
          home: TarefasApp(),
        ),
      );

      await tester.pumpWidget(app);

      expect(find.text("Tarefa 1"), findsNothing);
      expect(find.text("Tarefa 2"), findsNothing);
    });
  });
}
