import 'package:tell_your_pain_v2/ui/enums/resposta_codigo.dart';

class ConsumoRecurso {

  String id;
  String usuarioId;
  String recursoId;
  String dataCadastro;
  int respostaCodigo;


  ConsumoRecurso({required this.id, required this.usuarioId, required this.recursoId,
                  required this.dataCadastro, required this.respostaCodigo});

  factory ConsumoRecurso.fromMap(Map<String, dynamic> json) => ConsumoRecurso(

      id: json['id']  ?? '',
      usuarioId: json['usuarioId'] ?? '',
      recursoId: json['recursoId'],
      dataCadastro: json['dataCadastro'],
      respostaCodigo: json['respostaCodigo']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'usuarioId': usuarioId,
      'recursoId': recursoId,
      'dataCadastro': dataCadastro,
      'respostaCodigo': respostaCodigo
    };
  }
}

