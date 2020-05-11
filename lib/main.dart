import 'package:date/blocs/controle.bloc.dart';
import 'package:date/blocs/theme.bloc.dart';
import 'package:date/ui/Pages/splash.page.dart';
import 'package:date/ui/Pages/tabs.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'blocs/tarefa.bloc.dart';

// void main() =>
//     initializeDateFormatting("pt_BR", null).then((_) => runApp(MyApp()));

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TarefaBloc>.value(
          value: TarefaBloc(),
        ),
        ChangeNotifierProvider<ThemeBloc>.value(
          value: ThemeBloc(),
        ),
        ChangeNotifierProvider<ControleBloc>.value(
          value: ControleBloc(),
        ),
      ],
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ThemeBloc>(context);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: bloc.theme,
      home: SplashPage(),
      routes: {
        '/TabsPage': (context) => new TabsPage(),
      },
    );
  }
}
