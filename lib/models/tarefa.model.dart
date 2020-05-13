import 'package:intl/intl.dart';

class TarefaModel {
  String id;
  String nome;
  String detalhes;
  String status;
  String dataEntrega;
  String dataCriacao;
  int categoria;
  DateTime dataEntregavel;

  TarefaModel(
      {this.id,
      this.nome,
      this.detalhes,
      this.status,
      this.dataEntrega,
      this.dataCriacao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'detalhes': detalhes,
      'status': status,
      'dataEntrega': dataEntrega,
      'dataCriacao': dataCriacao,
      'categoria': categoria,
    };
  }

  TarefaModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    detalhes = json['detalhes'];
    status = json['status'];
    dataEntrega = json['dataEntrega'];
    dataCriacao = json['dataCriacao'];
    categoria = json['categoria'];
    status = obterStatus();
    dataEntregavel = DateFormat("dd/MM/yyyy").parse(dataEntrega);
  }

  String obterStatus() {
    if (status == "Feito" || status == "Arquivado") {
      return status;
    } else {
      return desfazerFeito();
    }
  }

  String desfazerFeito() {
    if (status == null || status != "Feito") {
      var dataEntrega = DateFormat("dd/MM/yyyy").parse(this.dataEntrega);
      var dataAtual = DateFormat("dd/MM/yyyy")
          .parse(DateFormat("dd/MM/yyyy").format(DateTime.now()));
      status = dataEntrega.isBefore(dataAtual) ? "Atrasado" : "Pendente";
      return status;
    } else {
      return "Nada";
    }
  }
}
