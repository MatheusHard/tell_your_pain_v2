import 'package:tell_your_pain_v2/ui/models/turma.dart';

abstract class ITurmaRepository {

  Future<List> getAll();
  Future<Turma?> getById(String id);
  Future<int> add(Turma turma);
  Future<int> deleteAll();

}