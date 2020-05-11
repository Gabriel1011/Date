import 'package:date/blocs/controle.bloc.dart';
import 'package:date/blocs/tarefa.bloc.dart';
import 'package:date/models/tarefa.model.dart';
import 'package:date/ui/widgets/appBarDate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CadastroTarefaPage extends StatefulWidget {
  final TarefaModel tarefa;
  final DateTime dataTarefa;
  CadastroTarefaPage({this.tarefa, this.dataTarefa});

  @override
  _CadastroTarefaPageState createState() => _CadastroTarefaPageState();
}

class _CadastroTarefaPageState extends State<CadastroTarefaPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TarefaBloc>(context);

    Widget calendario() {
      return FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.date_range,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              widget.tarefa?.dataEntrega ??
                  DateFormat('dd/MM/yyyy')
                      .format(widget.dataTarefa ?? DateTime.now()),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        // color: Theme.of(context).primaryColor,
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateFormat('dd/MM/yyyy').parse(
                widget.tarefa?.dataEntrega ??
                    DateFormat('dd/MM/yyyy').format(DateTime.now())),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030),
          ).then((date) {
            setState(() {
              widget.tarefa.dataEntrega = DateFormat('dd/MM/yyyy').format(date);
            });
          });
        },
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarDate(context,
          widget.tarefa.id == null ? "Cadastro Tarefa" : "Editar Tarefa"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Dados Tarefa",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nome Inválido';
                          }
                          return null;
                        },
                        initialValue: widget.tarefa?.nome,
                        onChanged: (val) {
                          widget.tarefa.nome = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Detalhes",
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        initialValue: widget.tarefa?.detalhes,
                        onChanged: (val) {
                          widget.tarefa.detalhes = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          calendario(),
                          Text(
                            "Data da Entrega",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: FlatButton(
                          child: Text(
                            widget.tarefa?.id == null ? "Cadastrar" : "Salvar",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              criar(context, bloc);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  criar(BuildContext context, TarefaBloc bloc) async {
    final blocControle = Provider.of<ControleBloc>(context, listen: false);

    try {
      widget.tarefa.dataEntrega = widget.tarefa?.dataEntrega ??
          DateFormat('dd/MM/yyyy').format(widget.dataTarefa ?? DateTime.now());

      var res = widget.tarefa?.id == null
          ? await bloc.adicionar(widget.tarefa)
          : await bloc.atualizar(widget.tarefa);

      if (res == null) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('ops! Algo deu errado.')));
      } else {
        blocControle.telaPrincipal.currentState
            .showSnackBar(SnackBar(content: Text('Tarefa salva com sucesso!')));
        Navigator.pop(context);
      }
    } catch (ex) {
      print(ex);
    }
  }
}
