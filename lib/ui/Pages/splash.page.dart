import 'package:date/ui/Pages/tabs.page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  Future delay(context) async {
    await new Future.delayed(
        new Duration(
          milliseconds: 2600,
        ), () {
      Navigator.pushReplacementNamed(context, '/TabsPage'
          // MaterialPageRoute(builder: (context) => TabsPage()),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    delay(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: FlareActor(
              "assets/animacoes/Success Check.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              isPaused: false,
              animation: 'Untitled',
            ),
          ),
          Text(
            "Date",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
