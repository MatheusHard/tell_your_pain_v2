
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tell_your_pain_v2/ui/api/escola_api.dart';
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/UsuarioRepository.dart';
import 'package:tell_your_pain_v2/ui/enums/tipo_usuario.dart';
import 'package:tell_your_pain_v2/ui/models/escola.dart';
import 'dart:convert';

import '../database/repositories/EscolaRepository.dart';
import '../models/usuario.dart';
import '../pages/screen_arguments/screen_arguments_usuario.dart';
import '../pages/utils/metods/utils.dart';

class UsuarioApi{

  BuildContext? _context;

   UsuarioApi(BuildContext context){
    _context = context;
  }
  final URL_API_USUARIO = "usuario";
  final URL_API_AUTH = "auth";

  final URL_LOGIN = "/login";


  //Get All Users
  Future<int> getAll() async{

    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_USUARIO''');
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
//Login DB interno
  loginUsuario2(Map<String, dynamic> user) async{



      //Usuario Repositorio:
      var usuarioRepository = UsuarioRepository(await DBHelper.instance.database);

      Usuario usuario = Usuario.fromMap(user);

      int deleteALl = await usuarioRepository.deleteAll();

      // if(deleteALl == 1) {
      int resultAdd = await usuarioRepository.add(usuario);

      if (resultAdd >= 1) {
        Navigator.popAndPushNamed(_context!, '/home_page', arguments: ScreenArgumentsUsuario(usuario));
      } else {
        Utils.showDefaultSnackbar(_context!, "response.body");
      }



  }
//Login App sem Banco
  loginUsuario3(Map login) async{



    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_USUARIO$URL_LOGIN''');
    http.Response response = await http.post(
      url,
      headers: {
       //"Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
        "Content-type": "application/json; charset=UTF-8"
       },
      body:  jsonEncode(login)

    );

    if(response.statusCode == 200){
      //Usuario Repositorio:
      var usuarioRepository = UsuarioRepository(await DBHelper.instance.database);

      Usuario usuario = Usuario.fromMap(jsonDecode(response.body));

       int deleteALl = await usuarioRepository.deleteAll();

       // if(deleteALl == 1) {
          int resultAdd = await usuarioRepository.add(usuario);
          if (resultAdd == 1) Navigator.pushNamed(_context!, '/home_page', arguments: ScreenArgumentsUsuario(usuario));
      //  }
      //Utils.saveSession("usuarioLogado", usuario);

    }else{
      Utils.showDefaultSnackbar(_context!, response.body);
    }

  }


  //Login
  loginUsuario(Map login) async{

    var id;
    var respostaToken = await getToken(login);

    if(respostaToken['status'] == 200){

      Map<String, dynamic> decodedToken = JwtDecoder.decode(respostaToken['token']);
      id = decodedToken['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

      Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_USUARIO/$id''');
      http.Response response = await http.get(url);
      print('''RESPONSE USUARIO: ${response.body}''');

      ///Usuario CRUD:
      var usuarioRepository = UsuarioRepository(await DBHelper.instance.database);

      var usuarioDecode = jsonDecode(response.body);

      ///Check Escola exists do Response:
      if(usuarioDecode['escola'] == null) {
        Utils.showDefaultSnackbar(_context!, '''Aluno pode está sem Matricula!!!''');
        return;
      }

      ///Check Turma exists do Response:
      if(usuarioDecode['turma'] == null) {
        Utils.showDefaultSnackbar(_context!, '''Aluno pode está sem Turma!!!''');
        return;
      }

      ///CRUD Usuario:
      Usuario usuario = Usuario.fromMap(usuarioDecode);
      int deleteALlUsuarios = await usuarioRepository.deleteAll();
      int resultAdd = await usuarioRepository.add(usuario);

      ///CRUD Escola:
      var escolaRepository = EscolaRepository(await DBHelper.instance.database);
      Escola? escola = usuario.escola;
      int deleteALlEscolas = await escolaRepository.deleteAll();
      await escolaRepository.add(escola!);

      if (resultAdd == 1 && usuario.tipoUsuarioId == TipoUsuario.ALUNO.index) {
           Navigator.pushNamed(_context!, '/home_page', arguments: ScreenArgumentsUsuario(usuario));
      }
    }else{
      Utils.showDefaultSnackbar(_context!, '''Codigo: ${respostaToken['status']} -> ${respostaToken['token']}''');
    }

  }

  Future<dynamic> getToken(Map user) async{

   var retorno ;

    String? token;
    Uri url = Uri.parse('''${Utils.URL_WEB_SERVICE}$URL_API_AUTH$URL_LOGIN''');
    http.Response response = await http.post(
        url,
        headers: {
          "Content-type": "application/json; charset=UTF-8"
        },
        body:  jsonEncode(user)

    );

      token = response.body;
      retorno = {"token": token, "status": response.statusCode};

    return retorno;

  }
}

