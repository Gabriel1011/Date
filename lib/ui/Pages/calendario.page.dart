import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/Pages/cadastro-tarefa.page.dart';
import 'package:date/ui/widgets/appBarDate.dart';
import 'package:date/ui/widgets/tarefa/lista-tarefa.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  CalendarController _controller;
  DateTime dataSelecionada;

  @override
  void initState() {
    super.initState();
    _controller = new CalendarController();
    dataSelecionada = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);

    gerarTarefasDia() {
      return bloc.tarefas
          .where((p) =>
              p.dataEntrega == DateFormat('dd/MM/yyyy').format(dataSelecionada))
          .toList();
    }

    return Scaffold(
      appBar: AppBarDate(context, "Datas Tarefas"),
      body: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TableCalendar(
              onDayLongPressed: (data, list) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroTarefaPage(
                      tarefa: TarefaModel(),
                      dataTarefa: data,
                    ),
                  ),
                );
              },
              onDaySelected: (data, list) {
                setState(() {
                  dataSelecionada = data;
                });
              },
              events: bloc.tarefasEventos,
              locale: 'pt_BR',
              calendarController: _controller,
              calendarStyle: CalendarStyle(
                markersColor: Theme.of(context).primaryColor,
                outsideWeekendStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                weekendStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
                outsideStyle: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.5)),
                selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                selectedStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                todayColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                centerHeaderTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListaTarefa(
                  tarefas: gerarTarefasDia(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
