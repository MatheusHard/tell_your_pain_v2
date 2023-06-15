

class Escola {

  String id;
  String nome;
  String cnpj;
  String telefone;
  String dataCadastro;
  String dataAlteracao;
  String poloId;
  String email;
  String enderecoId;
  bool ativo;

  Escola({ required this.id, required this.nome, required this.cnpj, required this.telefone, required this.dataCadastro,
    required this.dataAlteracao, required this.poloId, required this.enderecoId, required this.ativo, required this.email});

  factory Escola.fromMap(Map<String, dynamic> json) => Escola(

      id: json['id']  ?? '',
      nome: json['nome'] ?? '',
      cnpj: json['cnpj'],
      telefone: json['telefone'],
      dataCadastro: json['dataCadastro'],
      dataAlteracao: json['dataAlteracao'],
      poloId: json['poloId'],
      ativo:  json['ativo'] == 1 ? true : false,
      enderecoId: json['enderecoId'],
      email: json['email']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'dataCadastro': dataCadastro,
      'dataAlteracao': dataAlteracao,
      'poloId': poloId,
      'ativo':  ativo == true ? 1 : 0,
      'email': email,
      'enderecoId':enderecoId
  };
  }
}