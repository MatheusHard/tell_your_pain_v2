import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/UsuarioRepository.dart';
import 'package:tell_your_pain_v2/ui/models/usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/avaliacao_page.dart';
import 'package:tell_your_pain_v2/ui/pages/cadastro_page.dart';
import 'package:tell_your_pain_v2/ui/pages/chat_page.dart';
import 'package:tell_your_pain_v2/ui/pages/home_page.dart';
import 'package:tell_your_pain_v2/ui/pages/login_page.dart';
import 'package:tell_your_pain_v2/ui/pages/pergunta_page.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

//  await dotenv.load(fileName: ".env");

  //Usuario Repositorio:
  var usuarioRepository = UsuarioRepository();

 /* var _add = await usuarioRepository.add(Usuario( nome: "Luana SIlva", dataDeNascimento: Utils.getDataHora().toString(),
                                             password: '2254', id: 'fggg-452gf-ffdd-5241', cpf: '05694641450',
                                             email: 'burumungu@gmail.com', escolaId: '2012-kkjj-kjnjkk', turmaId: '2541'));
*/
  List<Usuario> lista = await usuarioRepository.getAll();

  for (var u in lista) {
    print("--------------DONO---------------------");
    print('''Dono: ${u.nome}''');
    print('''Cpf: ${u.cpf}''');

    print("-----------------------------------------");

  }

  runApp(
      MaterialApp(
        title: 'HAppy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/home_page': (BuildContext context) => HomePage(),
          '/pergunta_page': (BuildContext context) => PerguntaPage(),
          '/login_page': (BuildContext context) =>  LoginPage(),
          '/avaliacao_page': (BuildContext context) =>  AvaliacaoPage(),
          '/cadastro_page': (BuildContext context) =>  CadastroPage(),
          '/chat_page': (BuildContext context) =>  ChatScreen(),


        },initialRoute: '/login_page',
      ));}



