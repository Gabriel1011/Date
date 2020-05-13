import 'package:date/models/tarefa.model.dart';
import 'package:flutter/material.dart';

class IconeTarefa extends StatelessWidget {
  final TarefaModel tarefa;

  IconeTarefa({@required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('assets/grey/${iconeTarefa()}.png'),
      ),
    );
  }

  String iconeTarefa() {
    switch (tarefa.categoria) {
      case 0:
        return "educacao";
        break;
      case 1:
        return "tarefas";
        break;
      case 2:
        return "compromisso";
        break;
      case 3:
        return "cursoOnline";
        break;
      default:
        return "";
    }
  }
}
