import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tell_your_pain_v2/ui/database/data_model/usuario_data_model.dart';

import 'data_model/resposta_data_model.dart';

class DBHelper{

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();

  _initDB () async {
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();
    String caminho = join(documentoDiretorio.path, "db_tell_your_pain.db");// home://directory/files/db_gastos.db

    return  await  openDatabase(
        caminho,
        version: 1,
        onCreate: _onCreate);

  }

  void _onCreate(Database db, int version) async{

    await db.execute(UsuarioDataModel.criarTabela());
    await db.execute(RespostaDataModel.criarTabela());

  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }


}





















