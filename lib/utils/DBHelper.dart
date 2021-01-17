
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String table = 'VideoCallData';
final String id = 'id';
final String userId = 'user_id';
final String roomName = 'room_name';
final String accessToken = 'token';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path +"/TestDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ")");
    });
  }

  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert("Client", newClient.toMap());
    return res;
  }

  Future<Client> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list.first??Client();
  }

}


Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String firstName;
  String lastName;
  bool blocked;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.blocked,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    blocked: json["blocked"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "blocked": blocked,
  };
}

class Todo {
  int _Id;
  String _userId;
  String _roomName;
  String _accessToken;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      id: _Id,
      userId: _userId,
      roomName: _roomName,
      accessToken: _accessToken,
    };

    return map;
  }

  Todo();

  Todo.fromMap(Map<String, dynamic> map) {
    _userId = map[userId];
    _Id = map[id];
    _roomName = map[roomName];
    _accessToken = map[accessToken];
  }
}

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $table ( 
  $id integer primary key autoincrement, 
  $userId text not null,
  $roomName text not null,
  $accessToken text not null)
''');
        });
  }

  Future<Todo> insert(Todo todo) async {
    todo._Id = await db.insert(table, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int mId) async {
    List<Map> maps = await db.query(table,
        columns: [id, userId, roomName, accessToken],
        where: '$id = ?',
        whereArgs: [mId]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<Todo> getTodos() async {
    List<Map> maps = await db.query(table);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(table, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(table, todo.toMap(),
        where: '$id = ?', whereArgs: [todo._Id]);
  }

  Future close() async => db.close();
}