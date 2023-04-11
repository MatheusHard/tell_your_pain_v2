import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/UsuarioRepository.dart';
import 'dart:convert';

import '../database/repositories/RespostaRepository.dart';
import '../pages/utils/metods/utils.dart';

class RespostaApi{

  BuildContext? _context;

  RespostaApi(BuildContext context){
    _context = context;
  }
  final URL_API_RESPOSTA = "resposta";
  //final URL_LOGIN = "/login";


  //Get All Users
  Future<int> getAll() async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_RESPOSTA''');
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

//Login
enviarRespostas(List respostas) async{

  var respostaRepository =  RespostaRepository(await DBHelper.instance.database);

  List lista = await respostaRepository.getAllAEnviar(1);

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_RESPOSTA''');
    http.Response response = await http.post(
        url,
        headers: {
          //"Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
          "Content-type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(lista)

    );

    if(response.statusCode == 200){

      print(response.body);

      List responseList = jsonDecode(response.body);
      for(var item in responseList){
        if(item['erros'] == ""){
          respostaRepository.updateStatus(item['statusEnvio'], item['erros'], item['id']);
        }
      }

    }else{
      Utils.showDefaultSnackbar(_context!, response.body);
    }

  }
}

