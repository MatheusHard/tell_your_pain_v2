
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/usuario.dart';
import '../pages/utils/metods/utils.dart';

class UsuarioApi{

  BuildContext? _context;

  UsuarioApi(BuildContext context){
    _context = context;
  }
  final URL_API_USUARIO = "usuario";
  final URL_API_CIDADES_POST = "cidade/add";
  final URL_LOGIN = "/login";


  //Future<int> getJson(BuildContext context) async{
  Future<int> getJson() async{

    String url_ = Platform.isAndroid ? 'http://192.168.0.6:5000/api/usuario' : 'https://localhost:5001/api/usuario';

    Uri url = Uri.parse(url_);
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
      //print(d);

      //return json.decode(response.body);
      return response.statusCode;

    }else{
      return response.statusCode;

    }
  }
/************ENVIAR***************/

loginUsuario(Map login) async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_USUARIO$URL_LOGIN''');
    //Uri url = Uri.parse(url_);
    http.Response response = await http.post(
      url,
      headers: {
       //"Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
        "Content-type": "application/json; charset=UTF-8"
       },
      body:  jsonEncode( login)

    );

    if(response.statusCode == 200){
      var usuario = jsonDecode(response.body);
      Navigator.pushNamed(_context!, '/home_page', arguments: null);

    }else{
      Utils.showDefaultSnackbar(_context!, response.body);
    }

  }
}

