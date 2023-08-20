import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tell_your_pain_v2/ui/database/data_model/usuario_data_model.dart';

import 'data_model/consumo_recurso_data_model.dart';
import 'data_model/escola_data_model.dart';
import 'data_model/recurso_data_model.dart';
import 'data_model/resposta_data_model.dart';
import 'data_model/turma_data_model.dart';

class DBHelper{

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;
  int versao = 1;

  Future<Database> get database async => _database ??= await _initDB();

  _initDB () async {
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();
    String caminho = join(documentoDiretorio.path, "db_tell_your_pain.db");// home://directory/files/db_gastos.db

    return  await  openDatabase(
        caminho,
        version: versao,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);

  }

  void _onCreate(Database db, int newVersion) async {

    for (int version = 0; version < newVersion; version++) {
      await _performDbOperationsVersionWise(db, version + 1);
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {

    for (int version = oldVersion; version < newVersion; version++) {
      await _performDbOperationsVersionWise(db, version + 1);
    }
  }

  _performDbOperationsVersionWise(Database db, int version) async {

    switch (version) {
      case 1:
        await _databaseVersion1(db);
        break;
      case 2:
        await _databaseVersion2(db);
        break;
      case 3:
        //await _databaseVersion3(db);
        break;
      case 4:
        //await _databaseVersion4(db);
        break;
      case 5:
       // await _databaseVersion5(db);
        break;
    }
  }

  _databaseVersion1(Database db) async {
    print('Database Version: 1');
    await db.execute(UsuarioDataModel.criarTabela());
    await db.execute(RespostaDataModel.criarTabela());
    await db.execute(EscolaDataModel.criarTabela());
    await db.execute(TurmaDataModel.criarTabela());
    await db.execute(RecursoDataModel.criarTabela());
    await db.execute(ConsumoRecursoDataModel.criarTabela());
  }
  _databaseVersion2(Database db) async {
    print('Database Version: 2');

  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }

}

/**
 * import 'package:sqflite/sqflite.dart';
    import 'dart:io';
    import 'package:path/path.dart';
    import 'package:path_provider/path_provider.dart';
    import 'package:tell_your_pain_v2/ui/database/data_model/usuario_data_model.dart';

    import 'data_model/consumo_recurso_data_model.dart';
    import 'data_model/escola_data_model.dart';
    import 'data_model/recurso_data_model.dart';
    import 'data_model/resposta_data_model.dart';
    import 'data_model/turma_data_model.dart';

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
    await db.execute(EscolaDataModel.criarTabela());
    await db.execute(TurmaDataModel.criarTabela());
    await db.execute(RecursoDataModel.criarTabela());
    await db.execute(ConsumoRecursoDataModel.criarTabela());

    }

    Future close() async {
    Database db = await instance.database;
    db.close();
    }


    }
 * */













