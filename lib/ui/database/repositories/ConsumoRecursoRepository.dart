
import '../../models/consumo_recurso.dart';
import '../data_model/consumo_recurso_data_model.dart';
import 'interfaces/IConsumoRecursoRepository.dart';

class ConsumoRecursoRepository  implements IConsumoRecursoRepository {

  var _db;

  ConsumoRecursoRepository(var db) {
    _db = db;
  }

  @override
  Future<int> add(ConsumoRecurso consumoRecurso) async{
    return await _db.insert(ConsumoRecursoDataModel.getTabela(), consumoRecurso.toMap());

  }

  @override
  Future<int> deleteAll() async {
    return await _db.rawDelete(ConsumoRecursoDataModel.zerarTabela());
  }

  @override
  Future<List> getAll() async {
    var consumoRecursos = await _db.query(
        ConsumoRecursoDataModel.getTabela(), orderBy: ConsumoRecursoDataModel.dataCadastro);
    return consumoRecursos.toList();
  }

  @override
  Future<ConsumoRecurso?>getById(String id) async {
    var res = await _db.rawQuery('''SELECT * FROM ${ConsumoRecursoDataModel.getTabela()} t 
                                    WHERE t.${ConsumoRecursoDataModel.id} = '$id' ''');
    if(res.isNotEmpty) {
      return ConsumoRecurso.fromMap(res.first);
    }else {
      return null;

    }
  }
}