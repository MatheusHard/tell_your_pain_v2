import '../../../models/recurso.dart';

abstract class IRecursoRepository {

Future<List> getAll();
Future<Recurso?> getById(String id);
Future<Recurso?> getRecursoAtivo(int ativo);
Future<int> add(Recurso recurso);
Future<int> deleteAll();
Future<int> updateAtivo(int ativo);


}