

class Resposta {

  String id;
  String alunoId;
  int statusEnvio;
  String erros;
  int  respostaCodigo;
  String dataResposta;
  String geoReferenciamento;
  String enderecoIp;
  int dimensaoId;


  Resposta({
    required this.id, required this.alunoId, required this.statusEnvio,
    required this.erros, required this.respostaCodigo, required this.dataResposta,
    required this.geoReferenciamento, required this.enderecoIp, required this.dimensaoId});

  factory Resposta.fromMap(Map<String, dynamic> json) => Resposta(

      id: json['id']  ?? '',
      alunoId: json['alunoId'],
      statusEnvio: json['statusEnvio'],
      erros:  json['erros'],
      respostaCodigo: json['respostaCodigo'],
      dataResposta: json['dataResposta'],
      geoReferenciamento: json['geoReferenciamento'],
      enderecoIp: json['enderecoIp'],
      dimensaoId : json['dimensaoId']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'alunoId': alunoId,
      'statusEnvio': statusEnvio,
      'erros':  erros,
      'respostaCodigo': respostaCodigo,
      'dataResposta': dataResposta,
      'geoReferenciamento': geoReferenciamento,
      'enderecoIp': enderecoIp,
      'dimensaoId': dimensaoId

    };
  }
}