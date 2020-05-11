import 'package:date/blocs/controle.bloc.dart';
import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/ui/Pages/calendario.page.dart';
import 'package:date/ui/Pages/home.page.dart';
import 'package:date/ui/Pages/tarefas-arquivadas.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TarefaBloc>(context);

    return DefaultTabController(
      length: 3,
      child: tabsView(context, bloc),
    );
  }

  Widget tabsView(BuildContext context, TarefaBloc bloc) {
    final blocControle = Provider.of<ControleBloc>(context);

    return Scaffold(
      key: blocControle.telaPrincipal,
      body: TabBarView(
        children: [
          HomePage(),
          CalendarioPage(),
          TarefasAquivadasPage(),
        ],
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
            icon: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                    ),
                    tarefasAtrasadas(bloc),
                  ],
                ),
                Text("Tarefas")
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: <Widget>[
                Icon(Icons.date_range),
                Text("Agendas"),
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: <Widget>[
                Icon(Icons.archive),
                Text("Arquivadas"),
              ],
            ),
          ),
        ],
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black38,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget tarefasAtrasadas(TarefaBloc bloc) {
    if (bloc.quantidadeTarefasAtrasadas > 0)
      return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            bloc.quantidadeTarefasAtrasadas.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    else
      return SizedBox();
  }
}
