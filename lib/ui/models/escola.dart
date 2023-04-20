

class Escola {

  String id;
  String nome;
  String cnpj;
  int cidadeId;
  int bairroId;
  String rua;
  String  telefone;
  String dataCadastro;
  String dataAlteracao;

  Escola({ required this.id, required this.nome, required this.cnpj, required this.cidadeId,
    required this.bairroId, required this.rua, required this.telefone, required this.dataCadastro,
    required this.dataAlteracao});

  factory Escola.fromMap(Map<String, dynamic> json) => Escola(

      id: json['id']  ?? '',
      nome: json['nome'] ?? '',
      cnpj: json['cnpj'],
      cidadeId: json['cidadeId'],
      bairroId:  json['bairroId'],
      rua: json['rua'],
      telefone: json['telefone'],
      dataCadastro: json['dataCadastro'],
      dataAlteracao: json['dataAlteracao']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'cidadeId': cidadeId,
      'bairroId':  bairroId,
      'rua': rua,
      'telefone': telefone,
      'dataCadastro': dataCadastro,
      'dataAlteracao': dataAlteracao

    };
  }
}