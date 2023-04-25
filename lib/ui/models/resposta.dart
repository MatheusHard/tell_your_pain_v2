

class Resposta {

  String id;
  String escolaId;
  String usuarioId;
  int statusEnvio;
  String erros;
  int  respostaCodigo;
  String dataResposta;
  String geoReferenciamento;
  String enderecoIp;
  int dimensaoId;
  String poloId;


  Resposta({
    required this.id, required this.escolaId, required this.usuarioId, required this.statusEnvio,
    required this.erros, required this.respostaCodigo, required this.dataResposta,
    required this.geoReferenciamento, required this.enderecoIp, required this.dimensaoId, required this.poloId});

  factory Resposta.fromMap(Map<String, dynamic> json) => Resposta(

      id: json['id']  ?? '',
      escolaId: json['escolaId'] ?? '',
      usuarioId: json['usuarioId'],
      statusEnvio: json['statusEnvio'],
      erros:  json['erros'],
      respostaCodigo: json['respostaCodigo'],
      dataResposta: json['dataResposta'],
      geoReferenciamento: json['geoReferenciamento'],
      enderecoIp: json['enderecoIp'],
      dimensaoId : json['dimensaoId'],
      poloId: json['poloId']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'escolaId': escolaId,
      'usuarioId': usuarioId,
      'statusEnvio': statusEnvio,
      'erros':  erros,
      'respostaCodigo': respostaCodigo,
      'dataResposta': dataResposta,
      'geoReferenciamento': geoReferenciamento,
      'enderecoIp': enderecoIp,
      'dimensaoId': dimensaoId,
      'poloId' :poloId

    };
  }
}