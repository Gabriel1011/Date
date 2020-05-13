import 'package:date/models/tarefa.model.dart';
import 'package:date/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TarefasRepository {
  Future<Database> _getDataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_TAREFAS_TABLE_SCRIP);
      },
      version: 2,
    );
  }

  Future<TarefaModel> criar(TarefaModel tarefa) async {
    try {
      final Database db = await _getDataBase();

      db.insert(
        TABLE_TAREFAS,
        tarefa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return tarefa;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TarefaModel> atualizar(TarefaModel tarefa) async {
    try {
      final Database db = await _getDataBase();

      db.update(
        TABLE_TAREFAS,
        tarefa.toMap(),
        where: "id = ?",
        whereArgs: [tarefa.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return tarefa;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<bool> deletar(String id) async {
    try {
      final Database db = await _getDataBase();

      db.delete(
        TABLE_TAREFAS,
        where: "id = ?",
        whereArgs: [id],
      );
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<List<TarefaModel>> listarTarefas() async {
    try {
      final Database db = await _getDataBase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_TAREFAS);

      return List.generate(
        maps.length,
        (i) {
          return TarefaModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<TarefaModel>();
    }
  }

  Future<List<TarefaModel>> obterTarefa(String filtro) async {
    try {
      final Database db = await _getDataBase();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_TAREFAS, where: filtro);

      return List.generate(
        maps.length,
        (i) {
          return TarefaModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<TarefaModel>();
    }
  }
}
