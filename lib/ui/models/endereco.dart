
class Endereco {

  String id;
  String cep;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String ibge;
  String ddd;

  Endereco({ required this.id, required this.cep, required this.logradouro, required this.numero,
  required this.complemento, required this.bairro, required this.localidade, required this.uf,
  required this.ibge, required this.ddd});

  factory Endereco.fromMap(Map<String, dynamic> json) => Endereco(

      id: json['id']  ?? '',
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento:  json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      ddd: json['ddd']

  );

  Map<String, dynamic> toMap(){
  return {
    'id': id,
    'cep': cep,
    'logradouro': logradouro,
    'numero': numero,
    'complemento':  complemento,
    'bairro': bairro,
    'localidade': localidade,
    'uf': uf,
    'ibge': ibge,
    'ddd': ddd

  };
  }
}