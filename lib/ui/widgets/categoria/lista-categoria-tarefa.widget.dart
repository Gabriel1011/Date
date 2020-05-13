import 'package:date/blocs/enum-categoria.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/widgets/categoria/categoria-tarefa.widget.dart';
import 'package:flutter/material.dart';

class ListaCategoriaTarefa extends StatelessWidget {
  final TarefaModel tarefa;

  ListaCategoriaTarefa({this.tarefa});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        CategoriaTarefa(
          categoria: Categoria.educacao,
          icone: Icons.edit,
          nomeCategoria: "educacao",
          tarefa: tarefa,
        ),
        CategoriaTarefa(
          categoria: Categoria.tarefa,
          nomeCategoria: "tarefas",
          icone: Icons.format_list_numbered,
          tarefa: tarefa,
        ),
        CategoriaTarefa(
          categoria: Categoria.cursoOline,
          nomeCategoria: "cursoOnline",
          icone: Icons.offline_bolt,
          tarefa: tarefa,
        ),
        CategoriaTarefa(
          categoria: Categoria.compromisso,
          nomeCategoria: "compromisso",
          icone: Icons.calendar_today,
          tarefa: tarefa,
        ),
      ],
    );
  }
}
