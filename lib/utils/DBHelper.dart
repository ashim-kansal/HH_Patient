
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
          "isFirst INTEGER"
          ")");
    });
  }

  Future<bool> newClient() async {
    Client client = new  Client(isFirst:1);
    final db = await database;
    var res = await db.insert("Client", client.toMap());
    return res>0?true:false ;
  }

  Future<bool> checkIsFirst() async {
    final db = await database;
    var res = await db.query("Client");
    if(res.isNotEmpty)
      return false;
    else
      return true;
    // return list?.last??null;
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
  int isFirst;

  Client({
    this.id,
    this.isFirst,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id: json["id"],
    isFirst: json["isFirst"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "isFirst": isFirst,
  };
}
