import 'package:date/ui/Pages/Tema.page.dart';
import 'package:flutter/material.dart';

class AppBarDateHome extends StatelessWidget {
  String titulo;
  bool actionConfig = false;
  AppBarDateHome({@required this.titulo, this.actionConfig});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.usb,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 35,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              child: GestureDetector(
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TemaPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
