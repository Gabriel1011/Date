import 'dart:async';

import 'package:date/blocs/enum-categoria.dart';
import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/Pages/cadastro-tarefa.page.dart';
import 'package:date/ui/widgets/appBarDate.dart';
import 'package:date/ui/widgets/tarefa/lista-tarefa.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final routeObserver = RouteObserver<PageRoute>();
final duration = const Duration(milliseconds: 200);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  GlobalKey _fabKey = GlobalKey();
  bool _fabVisible = true;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  didPopNext() {
    // Show back the FAB on transition back ended
    Timer(duration, () {
      setState(() => _fabVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppBarDate(context, "Tarefas"),
            Expanded(
              child: ListaTarefa(tarefas: bloc.tarefas),
            ),
          ],
        ),
      ),
      floatingActionButton:
          flatButtonAction(), // _buildFAB(context, key: _fabKey),
    );
  }

  Widget flatButtonAction() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CadastroTarefaPage(
              tarefa: new TarefaModel(),
            ),
          ),
        );
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).accentColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildFAB(context, {key}) => FloatingActionButton(
        key: key,
        onPressed: () => _onFabTap(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );

  _onFabTap(BuildContext context) {
    // Hide the FAB on transition start
    setState(() => _fabVisible = false);

    final RenderBox fabRenderBox = _fabKey.currentContext.findRenderObject();
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          CadastroTarefaPage(
        tarefa: TarefaModel(),
      ),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          _buildTransition(child, animation, fabSize, fabOffset),
    ));
  }

  Widget _buildTransition(
    Widget page,
    Animation<double> animation,
    Size fabSize,
    Offset fabOffset,
  ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(fabSize.width / 2),
      end: BorderRadius.circular(0.0),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    final easeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    );

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeAnimation.value,
      child: _buildFAB(context),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
        width: size.width,
        height: size.height,
        left: offset.dx,
        top: offset.dy,
        child: ClipRRect(
          borderRadius: radius,
          child: child,
        ));

    return Stack(
      children: [
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
  }
}
