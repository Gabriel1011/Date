import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/share/alertDialog.widget.dart';
import 'package:date/ui/widgets/loader.widget.dart';
import 'package:date/ui/widgets/tarefa/tarefa.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTarefa extends StatelessWidget {
  var tarefas = new List<TarefaModel>();
  TarefaBloc bloc;

  ListaTarefa({@required this.tarefas});

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

  verificarStatus(TarefaModel tarefa, BuildContext context,
      [bool deletar = false]) {
    if (tarefa.status != "Feito") {
      AlertOk(
        titulo: "Aviso!",
        texto:
            "Não é possível ${deletar ? "deletar" : "Arquivar"} tarefas incompletas.",
      ).showAlertOk(context);
      bloc.getTarefas();
    }
  }

  Widget fundoDismissible() {
    return Container(
      color: Colors.yellow.withOpacity(0.5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            Icons.archive,
            color: Colors.yellow.withOpacity(1),
            size: 50,
          ),
        ),
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
            String direcao = direction.toString();
            if (direcao.contains("endToStart")) {
              if (tarefas[index].status != "Feito") {
                verificarStatus(tarefas[index], context, true);
                return;
              }
              bloc.delete(tarefas[index].id);
            } else {
              if (tarefas[index].status != "Feito") {
                verificarStatus(tarefas[index], context);
                return;
              }
              bloc.arquivarTarefa(tarefas[index]);
            }
          },
          background: Container(
            color: Colors.yellow.withOpacity(0.5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.archive,
                  color: Colors.yellow.withOpacity(1),
                  size: 50,
                ),
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red.withOpacity(0.5),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.5),
                size: 50,
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
