import 'package:path/path.dart';
import 'package:utilidades/src/models/person_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  // internal faz o controle de fluxo, garante que só vai ser criado uma unica vez
  // ou seja, se não existir ele cria. Se tem, ele não cria e mantem o fluxo com o banco.
  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal();

  static Database? _db;

  Future<Database> get db async {
    //se nao foi iniciado o banco de dados, cria o db e retorna ele
    _db ??= await _initDB('app.db');
    return _db!;
  }

  Future<Database> _initDB(String name) async {
    final path = join(await getDatabasesPath(), name);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE pessoas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL, 
            idade INTEGER NOT NULL
        )
    ''');
  }

  Future<int> insertPerson(PersonModel person) async {
    final database = await db;
    // pega os dados do model e converte-os p map
    return database.insert('pessoas', person.toMap());
  }

  Future<List<PersonModel>> getAllPersons() async {
    final database = await db;
    final result = await database.query('pessoas');
    return result.map((e) => PersonModel.fromMap(e)).toList();
  }

  Future<void> deletePerson(int id) async {
    final database = await db;
    await database.delete('pessoas', where: 'id = ?', whereArgs: [id]);
  }
}
