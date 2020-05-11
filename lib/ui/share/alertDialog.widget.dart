import 'package:flutter/material.dart';

class AlertOk extends StatelessWidget {
  final String titulo;
  final String texto;

  AlertOk({@required this.titulo, @required this.texto});

  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "OK",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
        ),
      ),
    );

    return AlertDialog(
      title: Text(
        titulo,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(texto),
      actions: <Widget>[
        okButton,
      ],
    );
  }

  Future showAlertOk(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertOk(
          titulo: titulo,
          texto: texto,
        );
      },
    );
  }
}
