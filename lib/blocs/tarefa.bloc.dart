import 'package:date/models/tarefa.model.dart';
import 'package:date/repositories/tarefas.repositoy.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class TarefaBloc extends ChangeNotifier {
  var tarefas = new List<TarefaModel>();
  var tarefasArquivadas = new List<TarefaModel>();
  var repositorioTarefa = new TarefasRepository();
  int quantidadeTarefasAtrasadas = 0;
  Map<DateTime, List<dynamic>> tarefasEventos;

  TarefaBloc() {
    tarefasEventos = {};
    tarefas = null;
    tarefasArquivadas = null;
    getTarefas();
  }

  Future getTarefas() async {
    tarefas = await repositorioTarefa.listarTarefas();
    obterQuantidadeTarefasAtrasadas();
    ordenarTarefas();
    gerarEventos();
    notifyListeners();
  }

  Future<TarefaModel> adicionar(TarefaModel model) async {
    try {
      model.id = Uuid().v1();
      model.dataCriacao = DateTime.now().toString();
      var res = await repositorioTarefa.criar(model);
      getTarefas();
      return res;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TarefaModel> atualizar(TarefaModel tarefa) async {
    try {
      var rest = await repositorioTarefa.atualizar(tarefa);
      getTarefas();
      return rest;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<bool> delete(String id) async {
    try {
      var res = await repositorioTarefa.deletar(id);
      getTarefas();
      return res;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future finalizarTarefa(TarefaModel tarefa) async {
    tarefa.status = "Feito";
    atualizar(tarefa);
  }

  Future desfazerTarefa(TarefaModel tarefa) async {
    tarefa.status = tarefa.desfazerFeito();
    atualizar(tarefa);
  }

  Future arquivarTarefa(TarefaModel tarefa) async {
    tarefa.status = "Arquivado";
    atualizar(tarefa);
  }

  Future alterarIconeTarefa(TarefaModel tarefa, int categoria) async {
    tarefa.categoria = categoria;
    notifyListeners();
  }

  obterQuantidadeTarefasAtrasadas() {
    quantidadeTarefasAtrasadas =
        tarefas.where((p) => p.status == "Atrasado").length;
    notifyListeners();
  }

  ordenarTarefas() {
    gerarTarefasArquivadas();
    tarefas = tarefas.where((p) => p.status != "Arquivado").toList();

    tarefas.sort((a, b) => a.dataEntregavel.compareTo(b.dataEntregavel));

    var tarefasNaoConcluidas =
        tarefas.where((p) => p.status != "Feito").toList();

    var tarefasFeitas = tarefas.where((p) => p.status == "Feito").toList();

    tarefasNaoConcluidas.addAll(tarefasFeitas);

    tarefas = tarefasNaoConcluidas;
    notifyListeners();
  }

  gerarEventos() {
    tarefasEventos = {};
    var diasEventos = tarefas.map((p) => p.dataEntregavel).toList();
    diasEventos.sort();
    diasEventos.forEach((p) => tarefasEventos[p] =
        tarefas.where((t) => t.dataEntregavel == p).toList());

    notifyListeners();
  }

  gerarTarefasArquivadas() {
    tarefasArquivadas = tarefas.where((p) => p.status == "Arquivado").toList();
    notifyListeners();
  }
}
