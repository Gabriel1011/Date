import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendario extends StatefulWidget {
  String dateTime;
  DateTime dataCalentario;
  Calendario({@required this.dateTime});

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  var now = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    widget.dateTime = DateFormat('dd/MM/yyyy')
        .format(widget.dataCalentario ?? DateTime.now());

    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.date_range),
          Text(widget.dateTime),
        ],
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2019),
          lastDate: DateTime(2030),
        ).then((date) {
          setState(() {
            widget.dataCalentario = date;
          });
        });
      },
    );
  }
}
