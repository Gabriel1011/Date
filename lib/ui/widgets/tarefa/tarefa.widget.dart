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
    );
  }

  Widget tarefaListTitle(BuildContext context, TarefaBloc bloc) {
    return ListTile(
      onLongPress: () {
        if (tarefa.status == "Arquivado") return;
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
          Text(
            gerarTextoDetalheTarefa(tarefa.detalhes),
          ),
          Text("Status: ${tarefa.status ?? "-"} | ${tarefa.dataEntrega}"),
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          definirAcao(bloc);
        },
        child: iconeStatusTarefa(context),
      ),
    );
  }

  void definirAcao(TarefaBloc bloc) {
    if (tarefa.status == "Arquivado") return;
    if (tarefa.status == "Feito")
      bloc.desfazerTarefa(tarefa);
    else
      bloc.finalizarTarefa(tarefa);
  }

  Widget iconeStatusTarefa(BuildContext context) {
    return tarefa.status == "Arquivado"
        ? iconeTarefa(
            Icons.archive,
            Color(0xFFFFCC00),
          )
        : tarefa.status == "Feito"
            ? iconeTarefa(
                Icons.check_box,
                Color(0xFF00C569),
              )
            : tarefa.status == "Pendente"
                ? iconeTarefa(
                    Icons.check_box,
                    Colors.grey,
                  )
                : iconeTarefa(
                    Icons.error,
                    Colors.red,
                  );
  }

  Icon iconeTarefa(IconData icone, Color cor) {
    return Icon(
      icone,
      color: cor,
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
