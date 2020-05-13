const String DATABASE_NAME = "date.db";
const String TABLE_TAREFAS = "tarefas";
const String CREATE_TAREFAS_TABLE_SCRIP =
    "CREATE TABLE tarefas(  id TEXT, categoria INT, [nome] TEXT,  detalhes TEXT,  [status] TEXT,  dataEntrega DATE, dataCriacao DATE)";

class Settings {
  static String theme = "light";
}
