import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tell_your_pain_v2/ui/models/usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

import '../api/resposta_api.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  var textos = [
    "Como se Sente",
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

  click(int index, context, usuarioLogado) {
    if (index == 0) {
      Navigator.of(context).pushNamed('/pergunta_page', arguments: ScreenArgumentsUsuario(usuarioLogado));
    } else if (index == 1) {
      Navigator.of(context).pushNamed('/avaliacao_page', arguments: ScreenArgumentsUsuario(usuarioLogado));
    } else if (index == 2) {
      Navigator.of(context).pushNamed('/chat_page', arguments: ScreenArgumentsUsuario(usuarioLogado));
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
              //testeEnvio();
              click(index, context, usuarioLogado?.data);

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

  Future<void>  testeEnvio() async {

    //RespostaApi(context).getAll();

    var lista = [
      {
        "codigo": 1,
        "perguntaId": "c1bf252f-2b6b-4adb-848a-bd50b8963c32",
        "alunoId": "0f8fad5b-d9cb-469f-a165-70867728950e",
        "id": "0d8d15be-6396-4541-a1a2-9323f66d0db7",
        "dataCadastro": "0001-01-01T00:00:00",
        "ativo": false,
        "latitude": "ddds",
        "longitude": "15224",
        "enderecoIp": "192.66.5.3",
        "erros": "",
        "respostaCodigo": 0
      },
      {
        "codigo": 1,
        "perguntaId": "2427adad-4f64-40c4-b4d5-313a1044619f",
        "alunoId": "0f8fad5b-d9cb-469f-a165-70867728950e",
        "id": "dddf4386-054d-4b27-bf1e-f7c174f034e5",
        "dataCadastro": "0001-01-01T00:00:00",
        "ativo": false,
        "latitude": "ddds",
        "longitude": "15224",
        "enderecoIp": "192.66.5.3",
        "erros": "",
        "respostaCodigo": 0
      }
    ];
    Future<int> res = RespostaApi(context).enviarRespostas(lista);

    if(await res == 0){
      Utils.showDefaultSnackbar(context, "Sem dados à enviar");
    }

  }
  }

