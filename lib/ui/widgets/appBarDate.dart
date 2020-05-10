import 'package:date/ui/Pages/Tema.page.dart';
import 'package:flutter/material.dart';

// class AppBarDate extends StatelessWidget {
//   String titulo;
//   AppBarDate({@required this.titulo});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(titulo),
//       backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
//       elevation: 0,
//     );
//   }
// }

AppBar AppBarDate(BuildContext context, String titulo,
    [bool actionsSettings = false]) {
  return AppBar(
    centerTitle: true,
    actions: actionsSettings
        ? <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TemaPage(),
                  ),
                );
              },
              child: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
            ),
          ]
        : null,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.usb,
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            titulo,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
    elevation: 0,
  );
}
