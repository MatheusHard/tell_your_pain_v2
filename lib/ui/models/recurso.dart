
import '../enums/tipo_recurso.dart';

class Recurso {

  String id;
  String link;
  TipoRecurso tipoRecurso;
  String indicacao;
  num intervaloInicial;
  num intervaloFinal;
  String dataCadastro;
  String dataAlteracao;
  bool ativo;

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
      ativo:  json['ativo'] == 1 ? true : false

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
      'ativo':  ativo == true ? 1 : 0
    };
  }
}

