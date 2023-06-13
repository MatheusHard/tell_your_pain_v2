

import 'package:tell_your_pain_v2/ui/enums/tipo_usuario.dart';
import 'package:tell_your_pain_v2/ui/models/turma.dart';

import 'endereco.dart';
import 'escola.dart';

class Usuario {

  String id;
  String nome;
  String cpf;
  String email;
  String responsavelId;
  String turmaId;
  String dataNascimento;
  String enderecoId;
  String? matricula;
  String foto;
  String telefone;
  Escola? escola;
  Turma? turma;
  Endereco? endereco;

  Usuario({
    required this.id, required this.nome, required this.cpf, required this.email,
    required this.enderecoId, required this.dataNascimento, required this.foto,
    required this.telefone, required this.endereco, required this.responsavelId, required this.turmaId});

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(

      id: json['id']  ?? 0,
      nome: json['nome'] ?? '',
      cpf: json['cpf'],
      email: json['email'],
      dataNascimento: json['dataNascimento'],
      foto: json['foto'],
      telefone: json['telefone'],
      enderecoId: json['enderecoId'],
      responsavelId: json['responsavelId'],
      turmaId: json['turmaId'],
      endereco: Endereco.fromMap(json['endereco']),
      // escola: Escola.fromMap(json['escola']),
      // turma: Turma.fromMap(json['turma'])

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'dataNascimento': dataNascimento,
      'foto': foto,
      'telefone': telefone,
      'responsavelId': responsavelId,
      'turmaId': turmaId,
      'enderecoId': enderecoId

    };
  }
}