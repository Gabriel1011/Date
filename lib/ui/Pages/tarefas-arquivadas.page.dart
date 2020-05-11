import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/ui/widgets/appBarDate.dart';
import 'package:date/ui/widgets/tarefa/lista-tarefas-arquivadas.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasAquivadasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppBarDate(context, "Arquivadas", true),
            Expanded(
              child: ListaTarefaArquivadas(
                tarefas: bloc.tarefasArquivadas,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
