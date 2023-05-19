import 'package:flutter/material.dart';
import '../components/todo_list_iten.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taskController = TextEditingController();
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Lista de Tarefas",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  //colocar textfield dentro do expanded sempre
                  Expanded(
                    child: TextField(
                      controller: taskController,
                      decoration: const InputDecoration(
                        labelText: 'Adicione uma Tarefa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  //botao de adicionar uma nova tarefa
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      //add nova tarefa na lista
                      String text = taskController.text;
                      setState(() {
                        tasks.add(text);
                        taskController.clear();
                      });
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              ),
              //lista de tarefas adicionadas pelo usuario
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    //adicionadando a lista task dentro da lisView em tela
                    for (String task in tasks) TodoListIten(),
                  ],
                ),
              ),
              Row(
                children: [
                  //colocar textfield dentro do expanded sempre
                  Expanded(
                    child: Text("Possui 0 tarefas Pendentes"),
                  ),
                  const SizedBox(width: 6),
                  //botão para apagar todas a tarefas da lista de uma vez
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {},
                    child: const Text("Limpar Tarefas"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
