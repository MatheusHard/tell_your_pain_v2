
import '../../../models/resposta.dart';

abstract class IRespostaRepository {

  Future<List> getAll();
  Future<int> add(Resposta resposta);
  Future<int> deleteAll();
  Future<List> getAllAEnviar(int status);
  Future<int> updateStatus(int status, String erros, String id);


}