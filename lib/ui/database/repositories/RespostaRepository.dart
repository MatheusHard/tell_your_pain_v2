
import 'package:tell_your_pain_v2/ui/models/resposta.dart';

import '../data_model/resposta_data_model.dart';
import 'interfaces/IRespostaRepository.dart';

class RespostaRepository  implements IRespostaRepository{

  var _db;
  RespostaRepository(var db){
    _db = db;
  }

  @override
  Future<int> add(Resposta resposta) async{
    return await _db.insert(RespostaDataModel.getTabela(), resposta.toMap());
  }

  @override
  Future<int> deleteAll() async{
    return await _db.rawDelete(RespostaDataModel.zerarTabela());

  }

  @override
  Future<List> getAll() async {
    var repostas = await _db.query(RespostaDataModel.getTabela(), orderBy: RespostaDataModel.statusEnvio);
    return repostas.toList();

  }

  @override
  Future<List> getAllAEnviar(int status) async{
    var lista = await _db.rawQuery('''SELECT * FROM ${RespostaDataModel.getTabela()} r WHERE r.${RespostaDataModel.statusEnvio} <>  $status''' ,);
    return lista.toList();
  }

  @override
  Future<int> updateStatus(int status, String erros, String id ) async {
    int res =  await _db.rawUpdate('''UPDATE ${RespostaDataModel.getTabela()} SET ${RespostaDataModel.statusEnvio} = ? , ${RespostaDataModel.erros} = ?  
    WHERE ${RespostaDataModel.id} = ? ''', [status, erros, id]);
  return res;
  }



}