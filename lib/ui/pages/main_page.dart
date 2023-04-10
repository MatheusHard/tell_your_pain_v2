import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  var textos = [
    "Questionário Diário",
    "Avaliação Do Dia",
    "Chat Da Turma",
    "Sair"
  ];

  var images = [
    'assets/images/icones_home/questionario.png',
    'assets/images/icones_home/estado.png',
    'assets/images/icones_home/chat.png',
    'assets/images/icones_home/deslogar.png'
  ];

  click(int index, context) {
    if (index == 0) {
      Navigator.of(context).pushNamed('/pergunta_page');
    } else if (index == 1) {
      Navigator.of(context).pushNamed('/avaliacao_page');
    } else if (index == 2) {
      Navigator.of(context).pushNamed('/chat_page');
    } else if (index == 3) {
      //FirebaseAuth.instance.signOut().then((user) {
        exit(0);
      //});
    }
  }
  @override
  void initState (){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return GridView.builder(
      itemCount: textos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.6),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: () async {
              click(index, context);

            },
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  images[index],
                  width: 40,
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    textos[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void>  getSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usuario = prefs.getString('usuarioLogado');
    var usuarioLogado = jsonDecode(usuario!);

    return usuarioLogado;
    }
  }

