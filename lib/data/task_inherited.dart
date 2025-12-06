import 'package:flutter/material.dart';
import 'package:meu_primeiro_projeto/components/task.dart';

class TaskInherited  extends InheritedWidget {
   TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash (1).png', 3),
    Task('Andar de bike', 'assets/images/bike (1).webp', 5),
    Task('Meditar', 'assets/images/meditar (1).jpeg', 5),
    Task('Ler', 'assets/images/livro (1).jpg', 4),
    Task('Jogar', 'assets/images/jogar (1).jpg', 1),
  ];

  void newTask(String name,String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited ? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify( TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length ;
  }
}
