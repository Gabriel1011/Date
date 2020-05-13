import 'package:date/blocs/enum-categoria.dart';
import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/blocs/theme.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaTarefa extends StatelessWidget {
  final Categoria categoria;
  final TarefaModel tarefa;
  final IconData icone;
  final String nomeCategoria;

  CategoriaTarefa(
      {@required this.categoria,
      @required this.icone,
      @required this.nomeCategoria,
      this.tarefa});

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);
    var blocTema = Provider.of<ThemeBloc>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: categoria.index == tarefa.categoria
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                if (tarefa != null)
                  bloc.alterarIconeTarefa(tarefa, categoria.index);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Image(
                  image: AssetImage(
                    'assets/${blocTema.theme.toString().contains('dark') ? "dark" : "light"}/$nomeCategoria.png',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
