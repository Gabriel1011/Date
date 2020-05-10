import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/ui/Pages/calendario.page.dart';
import 'package:date/ui/Pages/configuracao-usuario.page.dart';
import 'package:date/ui/Pages/home.page.dart';
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
    return Scaffold(
      body: TabBarView(
        children: [HomePage(), CalendarioPage(), ConfiguracaoUsuarioPage()],
      ),
      bottomNavigationBar: new TabBar(
        tabs: [
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.list,
                ),
                containerTarefasAtrasadas(bloc),
              ],
            ),
          ),
          Tab(
            icon: new Icon(Icons.date_range),
          ),
          Tab(
            icon: new Icon(Icons.perm_identity),
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

  Widget containerTarefasAtrasadas(TarefaBloc bloc) {
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
