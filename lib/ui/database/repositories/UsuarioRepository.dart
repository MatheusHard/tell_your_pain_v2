import 'package:tell_your_pain_v2/ui/database/data_model/usuario_data_model.dart';

import '../../models/usuario.dart';
import '../db_helper.dart';
import 'interfaces/IUsuarioRepository.dart';

class UsuarioRepository  implements IUsuarioRepository{

  var _db;
  UsuarioRepository(var db){
    _db = db;
  }

  @override
  Future<List>getAll() async {
    //var db = await DBHelper.instance.database;
    var usuarios = await _db.query(UsuarioDataModel.getTabela(), orderBy: UsuarioDataModel.nome);
    return usuarios.toList();
  }

  @override
  Future<int> add(Usuario usuario) async {
    //var _db = await DBHelper.instance.database;
    return await _db.insert(UsuarioDataModel.getTabela(), usuario.toMap());
  }

  Future<int> deleteAll() async{
    return await _db.rawDelete(UsuarioDataModel.zerarTabela());
  }

}