
import '../../../models/escola.dart';

abstract class IEscolaRepository {

  Future<List> getAll();
  Future<Escola?> getById(String id);
  Future<int> add(Escola escola);
  Future<int> deleteAll();


}