import 'package:app_task_list/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//criando um widget personalizado para ser o item da lista de tarefas
class TodoListIten extends StatelessWidget {
  const TodoListIten({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffDCDCDC),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('dd/MM/yyyy - HH:mm:ss').format(task.date)),
              Text(
                task.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
