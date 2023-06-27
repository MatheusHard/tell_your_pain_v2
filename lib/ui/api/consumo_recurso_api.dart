import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/ConsumoRecursoRepository.dart';
import 'package:tell_your_pain_v2/ui/models/recurso.dart';
import 'dart:convert';
import '../database/repositories/RecursoRepository.dart';
import '../enums/ativo.dart';
import '../models/consumo_recurso.dart';
import '../models/usuario.dart';
import '../pages/screen_arguments/screen_arguments_usuario.dart';
import '../pages/utils/metods/utils.dart';

class ConsumoRecursoApi{

  BuildContext? _context;

  ConsumoRecursoApi(BuildContext context){
    _context = context;
  }
  final URL_API_CONSUMO_RECURSO = "consumorecurso";
  final URL_INSERIR_CONSUMO_RECURSO = "/adicionar";


  //Get All Users
  Future<int> getAll() async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_CONSUMO_RECURSO''');
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

  ///Inserir ConsumoRecurso
  enviarConsumoRecurso(ConsumoRecurso? consumoRecurso, Usuario usuario) async{

    if(consumoRecurso == null) {
      return 0;
    }

    ///Send ConsumoRecurso
    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_CONSUMO_RECURSO$URL_INSERIR_CONSUMO_RECURSO''');
    http.Response response = await http.post(
        url,
        headers: {
          "Content-type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(consumoRecurso.toMap())

    );

    if(response.statusCode == 200){
      ///Add CosumoRecuro DB:
      var consumoRecursoRepository =  ConsumoRecursoRepository(await DBHelper.instance.database);
      var consumoRecursoExists = await consumoRecursoRepository.getById(consumoRecurso.id);

      if(consumoRecursoExists == null) {
      var add = await consumoRecursoRepository.add(consumoRecurso);

      Recurso? newRecurso = await desativarAndNewRecurso(Ativo.FALSE.index, consumoRecurso.recursoId);

      Navigator.popAndPushNamed(_context!, '/home_page', arguments: ScreenArgumentsUsuario(usuario, newRecurso));

      }

    }else{
      Utils.showDefaultSnackbar(_context!, response.body);
    }
  }

  Future<Recurso?> desativarAndNewRecurso(int ativo, recursoId) async {

    ///Desativar Recurso:
    var recursoRepository =  RecursoRepository(await DBHelper.instance.database);

    await recursoRepository.updateAtivo(ativo, recursoId);

    Recurso? newRecurso = await recursoRepository.getRecursoAtivo(Ativo.TRUE.index);

    newRecurso ??= await Utils.getRecursoPadrao();

    return newRecurso;
  }


}

