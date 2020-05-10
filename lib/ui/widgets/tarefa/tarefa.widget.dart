import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/Pages/cadastro-tarefa.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tarefa extends StatelessWidget {
  TarefaModel tarefa;

  Tarefa({@required this.tarefa});
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);

    return Container(
      padding: EdgeInsets.all(5),
      child: tarefaListTitle(context, bloc),
      // child: tarefaLinha(context, bloc),
    );
  }

  Widget tarefaLinha(BuildContext context, TarefaBloc bloc) {
    return Container(
      width: double.infinity,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Teste"),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Teste2kdjaskldjlaskjdlkasjdlaks"),
            ],
          ),
        ],
      ),
    );
  }

  Widget tarefaListTitle(BuildContext context, TarefaBloc bloc) {
    // var status = bloc.obterStatusTarefa(tarefa.id);
    return ListTile(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CadastroTarefaPage(
              tarefa: tarefa,
            ),
          ),
        );
      },
      isThreeLine: true,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(0.3),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Icon(
          Icons.book,
        ),
      ),
      title: Text(
        tarefa.nome,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(gerarTextoDetalheTarefa(tarefa.detalhes)),
          Text("Status: ${tarefa.status ?? "-"} | ${tarefa.dataEntrega}"),
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          if (tarefa.status == "Feito")
            bloc.desfazerTarefa(tarefa);
          else
            bloc.finalizarTarefa(tarefa);
        },
        child: iconeStatusTarefa(context),
      ),
    );
  }

  Widget iconeStatusTarefa(BuildContext context) {
    return Icon(
      tarefa.status == "Atrasado" ? Icons.error : Icons.check_box,
      color: tarefa.status == "Atrasado"
          ? Colors.red
          : tarefa.status == "Feito"
              ? Theme.of(context).primaryColor
              : Colors.grey,
      size: 35,
    );
  }

  String gerarTextoDetalheTarefa(String detalhes) {
    return detalhes == null
        ? ""
        : detalhes.length > 0
            ? detalhes.length <= 50
                ? detalhes
                : detalhes.substring(
                        0,
                        tarefa.detalhes.length < 50
                            ? tarefa.detalhes.length
                            : 50) +
                    "..."
            : "";
  }
}
