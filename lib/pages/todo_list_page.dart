import 'package:app_task_list/models/task.dart';
import 'package:app_task_list/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import '../components/todo_list_iten.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taskController = TextEditingController();
  final TaskRepository taskRepository = TaskRepository();
  //lista de obj task
  List<Task> tasks = [];
  Task? deletedTask;
  int? deletedPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskRepository.getTaskList().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  void onDelete(Task task) {
    deletedTask = task;
    deletedPosition = tasks.indexOf(task);
    setState(() {
      tasks.remove(task);
    });

    //snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarefa ${task.title} foi removida com sucesso"),
        //desfaendo o delete armazenando a posição e o item da lista
        action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              setState(() {
                tasks.insert(deletedPosition!, deletedTask!);
              });
            }),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                        //verificação de vazio
                        if (text.isEmpty) {
                          setState(() {
                            Task newtask =
                                Task(title: text, date: DateTime.now());
                            //adicionando uma nova tarefa
                            tasks.add(newtask);
                            taskController.clear();
                            //salvando no dispositovo
                            taskRepository.saveTaskList(tasks);
                            //hide keyboard
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        }
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
                      //adicionadando a lista task dentro da lisView em tela passando via paramentro
                      for (Task task in tasks)
                        TodoListIten(
                          task: task,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    //colocar textfield dentro do expanded sempre
                    Expanded(
                      child: Text(
                        "Possui ${tasks.length} tarefas Pendentes",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 6),
                    //botão para apagar todas a tarefas da lista de uma vez
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        showDeleteDialog();
                      },
                      child: const Text("Limpar Tarefas"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//funcão para chamar dialog confimar exclusão em serie
  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar Tudo"),
        content: const Text("Confirma limpar todas as tarefas ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTasks();
            },
            child: const Text(
              'Limpar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  //funcção para deletar todoas as tarefas
  void deleteAllTasks() {
    setState(() {
      tasks.clear();
    });
  }
}
