
import '../../../models/resposta.dart';

abstract class IRespostaRepository {

  Future<List> getAll();
  Future<List> getCountDistinctByUsuarioId(String id);
  Future<int> add(Resposta resposta);
  Future<int> deleteAll();
  Future<List> getCountSentimentoByDimensao(int dimensao);
  Future<List> getMediaGeralRespostaByUsuarioId(String id);
  Future<List> getRespostaByDimensao(int dimensao);
  Future<List> getAllAEnviar(int status);
  Future<int> updateStatus(int status, String erros, String id);


}