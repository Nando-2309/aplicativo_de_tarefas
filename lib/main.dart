import 'package:flutter/material.dart';
import 'package:meu_primeiro_projeto/data/task_inherited.dart';
import 'package:meu_primeiro_projeto/screens/form_screen.dart';
import 'package:meu_primeiro_projeto/screens/initial_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);


 @override
  Widget build(BuildContext context) {
    //o método build ele serve para facilitar a recriação da tela com + facilidade
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskInherited(child: const InitialScreen()),
    );
  }
}



