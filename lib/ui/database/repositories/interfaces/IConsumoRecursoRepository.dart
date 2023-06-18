import '../../../models/consumo_recurso.dart';

abstract class IConsumoRecursoRepository {

Future<List> getAll();
Future<ConsumoRecurso?> getById(String id);
Future<int> add(ConsumoRecurso consumoRecurso);
Future<int> deleteAll();

}