import 'package:flutter/material.dart';

//criando um widget personalizado para ser o item da lista de tarefas
class TodoListIten extends StatelessWidget {
  const TodoListIten({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Container(
        color: Colors.grey,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('data'),
              Text(
                'tarefa 1',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
