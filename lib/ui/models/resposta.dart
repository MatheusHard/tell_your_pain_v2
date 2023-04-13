

class Resposta {

  String id;
  String turmaId;
  String alunoId;
  int statusEnvio;
  String erros;
  int  respostaCodigo;
  String dataCadastro;
  String latitude;
  String longitude;
  String enderecoIp;
  int perguntaTipo;


  Resposta({
    required this.id, required this.turmaId, required this.alunoId, required this.statusEnvio,
    required this.erros, required this.respostaCodigo, required this.dataCadastro,
    required this.latitude, required this.longitude, required this.enderecoIp, required this.perguntaTipo});

  factory Resposta.fromMap(Map<String, dynamic> json) => Resposta(

      id: json['id']  ?? '',
      turmaId: json['turmaId'] ?? '',
      alunoId: json['alunoId'],
      statusEnvio: json['statusEnvio'],
      erros:  json['erros'],
      respostaCodigo: json['respostaCodigo'],
      dataCadastro: json['dataCadastro'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      enderecoIp: json['enderecoIp'],
      perguntaTipo: json['perguntaTipo']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'turmaId': turmaId,
      'alunoId': alunoId,
      'statusEnvio': statusEnvio,
      'erros':  erros,
      'respostaCodigo': respostaCodigo,
      'dataCadastro': dataCadastro,
      'latitude': latitude,
      'longitude': longitude,
      'enderecoIp': enderecoIp,
      'perguntaTipo': perguntaTipo
    };
  }
}