import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/avaliacao_page.dart';
import 'package:tell_your_pain_v2/ui/pages/cadastro_page.dart';
import 'package:tell_your_pain_v2/ui/pages/chat_page.dart';
import 'package:tell_your_pain_v2/ui/pages/home_page.dart';
import 'package:tell_your_pain_v2/ui/pages/login_page.dart';
import 'package:tell_your_pain_v2/ui/pages/pergunta_page.dart';


void main() async{
//  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

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



