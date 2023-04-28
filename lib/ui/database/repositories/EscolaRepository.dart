

import 'package:tell_your_pain_v2/ui/models/escola.dart';

import '../data_model/escola_data_model.dart';
import 'interfaces/IEscolaRepository.dart';

class EscolaRepository  implements IEscolaRepository {

  var _db;

  EscolaRepository(var db) {
    _db = db;
  }

  @override
  Future<int> add(Escola escola) async {
    return await _db.insert(EscolaDataModel.getTabela(), escola.toMap());
  }

  @override
  Future<int> deleteAll() async {
    return await _db.rawDelete(EscolaDataModel.zerarTabela());
  }

  @override
  Future<List> getAll() async {
    var escolas = await _db.query(
        EscolaDataModel.getTabela(), orderBy: EscolaDataModel.nome);
    return escolas.toList();
  }

  @override
  Future<Escola?>getById(String id) async {
    var res = await _db.rawQuery('''SELECT * FROM ${EscolaDataModel.getTabela()} e 
                                    WHERE e.${EscolaDataModel.id} = '$id' ''');
    if(res.isNotEmpty) {
      return Escola.fromMap(res.first);
    }else {
      return null;

    }
  }
}