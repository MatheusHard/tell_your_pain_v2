

import 'package:tell_your_pain_v2/ui/enums/tipo_usuario.dart';
import 'package:tell_your_pain_v2/ui/models/turma.dart';

import 'escola.dart';

class Usuario {

  String id;
  String nome;
  String cpf;
  String email;
  //String senhaHash;
  String dataNascimento;
  String escolaId;
  String turmaId;
  String foto;
  String telefone;
  Escola? escola;
  Turma? turma;
  int tipoUsuarioId;

  Usuario({
    required this.id, required this.nome, required this.cpf, required this.email,
    required this.dataNascimento, required this.escolaId, required this.tipoUsuarioId,
    required this.turmaId, required this.foto, required this.telefone, required this.escola, required this.turma });

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(

      id: json['id']  ?? 0,
      nome: json['nome'] ?? '',
      cpf: json['cpf'],
      email: json['email'],
     // senhaHash:  (json['senhaHash']),
      dataNascimento: json['dataNascimento'],
      escolaId: json['escolaId'],
      turmaId: json['turmaId'],
      foto: json['foto'],
      telefone: json['telefone'],
      tipoUsuarioId: json['tipoUsuarioId'],
      escola: Escola.fromMap(json['escola']),
      turma: Turma.fromMap(json['turma'])

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
     // 'senhaHash':  senhaHash,
      'dataNascimento': dataNascimento,
      'escolaId': escolaId,
      'turmaId': turmaId,
      'foto': foto,
      'telefone': telefone
    };
  }
}