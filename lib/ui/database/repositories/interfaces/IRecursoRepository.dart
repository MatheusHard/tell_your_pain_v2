import '../../../models/recurso.dart';

abstract class IRecursoRepository {

Future<List> getAll();
Future<Recurso?> getById(String id);
Future<int> add(Recurso recurso);
Future<int> deleteAll();

}