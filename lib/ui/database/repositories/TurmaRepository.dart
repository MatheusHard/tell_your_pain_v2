
import 'package:tell_your_pain_v2/ui/models/turma.dart';

import '../data_model/turma_data_model.dart';
import 'interfaces/ITurmaRepository.dart';

class TurmaRepository  implements ITurmaRepository {

  var _db;

  TurmaRepository(var db) {
    _db = db;
  }

  @override
  Future<int> add(Turma turma) async{
    return await _db.insert(TurmaDataModel.getTabela(), turma.toMap());

  }

  @override
  Future<int> deleteAll() async {
    return await _db.rawDelete(TurmaDataModel.zerarTabela());
  }

  @override
  Future<List> getAll() async {
    var turmas = await _db.query(
        TurmaDataModel.getTabela(), orderBy: TurmaDataModel.descricao);
    return turmas.toList();
  }

  @override
  Future<Turma?>getById(String id) async {
    var res = await _db.rawQuery('''SELECT * FROM ${TurmaDataModel.getTabela()} t 
                                    WHERE t.${TurmaDataModel.id} = '$id' ''');
    if(res.isNotEmpty) {
      return Turma.fromMap(res.first);
    }else {
      return null;

    }
  }
}