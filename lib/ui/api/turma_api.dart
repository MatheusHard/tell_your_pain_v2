import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'dart:convert';
import '../database/repositories/TurmaRepository.dart';
import '../models/turma.dart';
import '../pages/utils/metods/utils.dart';

class TurmaApi{

  final URL_API_TURMA = "turma/turma";
  BuildContext? _context;

  TurmaApi(BuildContext context){
    _context = context;
  }

  ///Get by Id
  Future<Turma?> getById(String id) async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_TURMA/$id''');
    http.Response response = await http.get(url);
    Turma? turma;

    ///Turma Repository:
    var turmaRepository = TurmaRepository(await DBHelper.instance.database);

    if(response.statusCode == 200) {
      turma = Turma.fromMap(jsonDecode(response.body));
      ///Deletar turmas:
      int deleteALl = await turmaRepository.deleteAll();
      ///Add escola do ALuno:
      int resultAdd = await turmaRepository.add(turma);
    }else{
      turma = null;
    }
    return turma;

  }
}



