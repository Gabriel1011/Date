import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/widgets/loader.widget.dart';
import 'package:date/ui/widgets/tarefa/tarefa.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTarefaArquivadas extends StatelessWidget {
  var tarefas = new List<TarefaModel>();
  TarefaBloc bloc;

  ListaTarefaArquivadas({@required this.tarefas});

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<TarefaBloc>(context);

    return Container(
      height: 700,
      child: Loader(
        object: tarefas,
        callback: list,
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tarefas.length,
      itemBuilder: (context, index) {
        return Dismissible(
          onDismissed: (direction) {
            bloc.delete(tarefas[index].id);
          },
          background: Container(
            color: Colors.red.withOpacity(0.5),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.delete,
                  color: Colors.red.withOpacity(0.5),
                  size: 50,
                ),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Tarefa(
              tarefa: tarefas[index],
            ),
          ),
          key: UniqueKey(),
        );
      },
    );
  }
}
