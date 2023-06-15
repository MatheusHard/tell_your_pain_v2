
class Turma {

  String id;
  String escolaId;
  String descricao;
  String dataCadastro;
  String dataAlteracao;
  bool ativo;

Turma({required this.ativo, required this.id, required this.escolaId, required this.descricao, required this.dataCadastro, required this.dataAlteracao});

  factory Turma.fromMap(Map<String, dynamic> json) => Turma(

      id: json['id']  ?? '',
      escolaId: json['escolaId'] ?? '',
      descricao: json['descricao'],
      dataCadastro: json['dataCadastro'],
      dataAlteracao:  json['dataAlteracao'],
      ativo:  json['ativo'] == 1 ? true : false

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'escolaId': escolaId,
      'descricao': descricao,
      'dataCadastro': dataCadastro,
      'dataAlteracao':  dataAlteracao,
      'ativo':  ativo == true ? 1 : 0
      };
  }
}

