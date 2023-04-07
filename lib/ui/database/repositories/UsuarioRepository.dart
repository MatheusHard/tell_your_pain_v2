import 'package:tell_your_pain_v2/ui/database/data_model/usuario_data_model.dart';

import '../../models/usuario.dart';
import '../db_helper.dart';
import 'interfaces/IUsuarioRepository.dart';

class UsuarioRepository  implements IUsuarioRepository{

  @override
  Future<List<Usuario>>getAll() async {
    var db = await DBHelper.instance.database;
    var usuarios = await db.query(UsuarioDataModel.getTabela(), orderBy: UsuarioDataModel.nome);
    List<Usuario> list = usuarios.isNotEmpty
        ? usuarios.map((u) => Usuario.fromMap(u)).toList()
        : [];
    return list;
  }

  @override
  Future<int> add(Usuario usuario) async {
    var db = await DBHelper.instance.database;
    return await db.insert(UsuarioDataModel.getTabela(), usuario.toMap());
  }

}