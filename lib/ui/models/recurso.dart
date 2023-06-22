
import '../enums/tipo_recurso.dart';

class Recurso {

  String id;
  String link;
  int tipoRecurso;
  String indicacao;
  num intervaloInicial;
  num intervaloFinal;
  String dataCadastro;
  String dataAlteracao;
  int ativo;

  Recurso({required this.id, required this.link, required this.tipoRecurso, required this.indicacao, required this.intervaloFinal,
          required this.intervaloInicial, required this.dataCadastro, required this.dataAlteracao, required this.ativo});

  factory Recurso.fromMap(Map<String, dynamic> json) => Recurso(

      id: json['id']  ?? '',
      link: json['link'] ?? '',
      tipoRecurso: json['tipoRecurso'],
      indicacao: json['indicacao'],
      intervaloInicial: json['intervaloInicial'],
      intervaloFinal: json['intervaloFinal'],
      dataCadastro: json['dataCadastro'],
      dataAlteracao:  json['dataAlteracao'],
      ativo:  json['ativo']

  );
  factory Recurso.fromMapApi(Map<String, dynamic> json) => Recurso(

      id: json['id']  ?? '',
      link: json['link'] ?? '',
      tipoRecurso: json['tipoRecurso'],
      indicacao: json['indicacao'],
      intervaloInicial: json['intervaloInicial'],
      intervaloFinal: json['intervaloFinal'],
      dataCadastro: json['dataCadastro'],
      dataAlteracao:  json['dataAlteracao'],
      ativo:  json['ativo'] == true ? 1 : 0

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'link': link,
      'tipoRecurso': tipoRecurso,
      'indicacao': indicacao,
      'intervaloInicial': intervaloInicial,
      'intervaloFinal': intervaloFinal,
      'dataCadastro': dataCadastro,
      'dataAlteracao':  dataAlteracao,
      'ativo':  ativo
    };
  }
}

