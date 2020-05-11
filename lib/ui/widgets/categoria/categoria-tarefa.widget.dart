import 'package:date/blocs/tarefa.bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaTarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }
}
