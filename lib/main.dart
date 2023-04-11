import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/api/resposta_api.dart';
import 'package:tell_your_pain_v2/ui/api/usuario_api.dart';
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/RespostaRepository.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/UsuarioRepository.dart';
import 'package:tell_your_pain_v2/ui/models/resposta.dart';
import 'package:tell_your_pain_v2/ui/models/usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/avaliacao_page.dart';
import 'package:tell_your_pain_v2/ui/pages/cadastro_page.dart';
import 'package:tell_your_pain_v2/ui/pages/chat_page.dart';
import 'package:tell_your_pain_v2/ui/pages/home_page.dart';
import 'package:tell_your_pain_v2/ui/pages/login_page.dart';
import 'package:tell_your_pain_v2/ui/pages/pergunta_page.dart';
import 'package:tell_your_pain_v2/ui/pages/pergunta_page_v2.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

//  await dotenv.load(fileName: ".env");

  //Usuario Repositorio:
  //var usuarioRepository = UsuarioRepository(await DBHelper.instance.database);
var respRepo =  RespostaRepository(await DBHelper.instance.database);

Resposta resposta = Resposta(id: "24943f43-ff2e-4309-a3c2-12f154751ebf", turma: 1, alunoId: "0f8fad5b-d9cb-469f-a165-70867728950e",
    statusEnvio: 1, erros: "", respostaCodigo: 3, dataCadastro: Utils.getDataHoraDotNet(), latitude: "2541.332",
    longitude: "65584,33221", enderecoIp: "192.168.2.6", perguntaTipo: 2);

//int res = await respRepo.add(resposta);



 /* var _add = await usuarioRepository.add(Usuario(nome: "Luana SIlva", dataDeNascimento: Utils.getDataHora().toString(),
                                             password: '2254', id: 'fggg-452gf-ffdd-5241', cpf: '05694641450',
                                             email: 'burumungu@gmail.com', escolaId: '2012-kkjj-kjnjkk', turmaId: '2541'));
*/

  List lista = await respRepo.getAll();
  //List lista = await respRepo.getAllAEnviar(1);

  for (var u in lista) {
    print("--------------DONO---------------------");
    print('''Id: ${u['id']}''');
    print('''alunoId: ${u['alunoId']}''');
    print('''dataCadastro: ${u['dataCadastro']}''');
    print('''statusEnvio: ${u['statusEnvio']}''');


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
          //'/pergunta_page': (BuildContext context) => PerguntaPage(),
          '/pergunta_page': (BuildContext context) => PerguntaPage2(),
          '/login_page': (BuildContext context) =>  LoginPage(),
          '/avaliacao_page': (BuildContext context) =>  AvaliacaoPage(),
          '/cadastro_page': (BuildContext context) =>  CadastroPage(),
          '/chat_page': (BuildContext context) =>  ChatScreen(),


        },initialRoute: '/login_page',
      ));}



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
