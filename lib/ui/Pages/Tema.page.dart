import 'package:date/blocs/theme.bloc.dart';
import 'package:date/settings.dart';
import 'package:date/ui/widgets/appBarDate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc bloc = Provider.of<ThemeBloc>(context);

    return Scaffold(
      appBar: AppBarDate(context, "Temas"),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Text(
            "Tema atual: ${Settings.theme}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
          BotaoThema("Light", "light", bloc, context),
          BotaoThema("Dark", "dark", bloc, context),
          // BotaoThema("Dark Yellow", "dark-yellow", bloc, context),
          BotaoThema("Pink", "pink", bloc, context),
          BotaoThema("Pink Dark", "pink-dark", bloc, context)
        ],
      ),
    );
  }

  FlatButton BotaoThema(String textoBotao, String nomeTema, ThemeBloc bloc,
      BuildContext context) {
    return FlatButton(
        child: Text(
          textoBotao,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        color: Settings.theme == nomeTema
            ? Theme.of(context).primaryColor
            : Colors.transparent,
        onPressed: () {
          bloc.change(nomeTema);
        });
  }
}
