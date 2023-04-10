import 'package:tell_your_pain_v2/ui/models/usuario.dart';

abstract class IUsuarioRepository {

  Future<List> getAll();
  Future<int> add(Usuario usuario);
  Future<int> deleteAll();

}