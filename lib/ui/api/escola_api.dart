import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/EscolaRepository.dart';
import 'dart:convert';

import '../models/escola.dart';
import '../pages/utils/metods/utils.dart';

class EscolaApi{

  BuildContext? _context;

  EscolaApi(BuildContext context){
    _context = context;
  }
  final URL_API_ESCOLA = "escola/escola";

  ///Get All Escolas
  Future<int> getAll() async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_ESCOLA''');
    http.Response response = await http.get(url);

    print(response);
    if(response.statusCode == 200) {
//      await db.deletarTabelaCidade();

      //Pegar dados da API:
      List _dados = json.decode(response.body);

      for (int i = 0; i < _dados.length; i++) {
        //Inserir no DB interno dados da API:
        // await db.inserirCidade(new Cidade(_dados[i]["descricao_cidade"], _dados[i]["uf_id"] , null));
      }
      //List d = await DBHelper.instance.getCidadesUfs();
      print(_dados);

      //return json.decode(response.body);
      return response.statusCode;

    }else{
      return response.statusCode;

    }
  }

///Get by Id
Future<Escola?> getById(String id) async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_ESCOLA/$id''');
    http.Response response = await http.get(url);
    Escola? escola;

    ///Escola Repository:
    var escolaRepository = EscolaRepository(await DBHelper.instance.database);

    if(response.statusCode == 200) {
     escola = Escola.fromMap(jsonDecode(response.body));
      ///Deletar escolas:
      int deleteALl = await escolaRepository.deleteAll();
     ///Add escola do ALuno:
      int resultAdd = await escolaRepository.add(escola);
    }else{
      escola = null;
    }
    return escola;

  }
}



