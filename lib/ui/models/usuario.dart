

class Usuario {

  String id;
  String nome;
  String cpf;
  String email;
  String senha;
  String dataNascimento;
  String escolaId;
  String turmaId;
  String foto;
  String telefone;

  Usuario({
    required this.id, required this.nome, required this.cpf, required this.email,
    required this.senha, required this.dataNascimento, required this.escolaId,
    required this.turmaId, required this.foto, required this.telefone});

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(

      id: json['id']  ?? 0,
      nome: json['nome'] ?? '',
      cpf: json['cpf'],
      email: json['email'],
      senha:  (json['senha']),
      dataNascimento: json['dataNascimento'],
      escolaId: json['escolaId'],
      turmaId: json['turmaId'],
      foto: json['foto'],
      telefone: json['telefone']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'senha':  senha,
      'dataNascimento': dataNascimento,
      'escolaId': escolaId,
      'turmaId': turmaId,
      'foto': foto,
      'telefone': telefone
    };
  }
}