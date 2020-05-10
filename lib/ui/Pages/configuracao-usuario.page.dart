import 'package:date/ui/widgets/appBarDate.dart';
import 'package:flutter/material.dart';

class ConfiguracaoUsuarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarDate(context, "Configurações", true),
      body: ListView(
        children: <Widget>[
          AppBarDate(context, "Configurações", true),
        ],
      ),
    );
  }
}
