import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TarefaProvider(),
      child: MaterialApp(
        home: TarefasApp(),
      ),
    ),
  );
}

class TarefasApp extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Adicionar Tarefa'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final provider =
                        Provider.of<TarefaProvider>(context, listen: false);
                    final text = _controller.text;
                    if (text.isNotEmpty) {
                      provider.adicionarTarefa(Tarefa(
                        id: DateTime.now().millisecondsSinceEpoch,
                        titulo: text,
                      ));
                      _controller.clear();
                    }
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
          Consumer<TarefaProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: provider.tarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = provider.tarefas[index];
                    return ListTile(
                      title: Text(tarefa.titulo),
                      leading: Checkbox(
                        value: tarefa.concluida,
                        onChanged: (value) {
                          tarefa.toggleConcluida();
                          provider.notifyListeners();
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.removerTarefa(tarefa);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Tarefa {
  final int id;
  final String titulo;
  bool concluida;

  Tarefa({required this.id, required this.titulo, this.concluida = false});

  void toggleConcluida() {
    concluida = !concluida;
  }
}

class TarefaProvider with ChangeNotifier {
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas => _tarefas;

  void adicionarTarefa(Tarefa tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  void removerTarefa(Tarefa tarefa) {
    _tarefas.remove(tarefa);
    notifyListeners();
  }
}
