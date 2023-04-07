

class Usuario {

  String id;
  String nome;
  String? cpf;
  String email;
  String password;
  String dataDeNascimento;
  String escolaId;
  String turmaId;
  String? foto;
  String? fone;

  Usuario({
    required this.id, required this.nome, required this.cpf, required this.email,
    required this.password, required this.dataDeNascimento, required this.escolaId,
    required this.turmaId, this.foto, this.fone});

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(

      id: json['id']  ?? 0,
      nome: json['nome'] ?? '',
      cpf: json['cpf'],
      email: json['email'],
      password:  (json['password']),
      dataDeNascimento: json['dataDeNascimento'],
      escolaId: json['escolaId'],
      turmaId: json['turmaId'],
      foto: json['foto'],
      fone: json['fone']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'password':  password,
      'dataDeNascimento': dataDeNascimento,
      'escolaId': escolaId,
      'turmaId': turmaId,
      'foto': foto,
      'fone': fone
    };
  }
}