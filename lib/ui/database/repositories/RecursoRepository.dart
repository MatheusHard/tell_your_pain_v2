import '../../models/recurso.dart';
import '../data_model/recurso_data_model.dart';
import '../data_model/turma_data_model.dart';
import 'interfaces/IRecursoRepository.dart';

class RecursoRepository  implements IRecursoRepository {

  var _db;

  RecursoRepository(var db) {
    _db = db;
  }

  @override
  Future<int> add(Recurso recurso) async{
    return await _db.insert(RecursoDataModel.getTabela(), recurso.toMap());

  }

  @override
  Future<int> deleteAll() async {
    return await _db.rawDelete(RecursoDataModel.zerarTabela());
  }

  @override
  Future<List> getAll() async {
    var recursos = await _db.query(
        TurmaDataModel.getTabela(), orderBy: RecursoDataModel.dataAlteracao);
    return recursos.toList();
  }

  @override
  Future<Recurso?>getById(String id) async {
    var res = await _db.rawQuery('''SELECT * FROM ${RecursoDataModel.getTabela()} t 
                                    WHERE t.${RecursoDataModel.id} = '$id' ''');
    if(res.isNotEmpty) {
      return Recurso.fromMap(res.first);
    }else {
      return null;

    }
  }
}