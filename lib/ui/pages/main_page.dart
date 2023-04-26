import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/RespostaRepository.dart';
import 'package:tell_your_pain_v2/ui/models/usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_colors.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

import '../api/resposta_api.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  List _mediaGeral = [];
  double mediaGeral = 0;
  double media = 0;


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
      Navigator.of(context).pushNamed('/charts_page', arguments: ScreenArgumentsUsuario(usuarioLogado));
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

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    _getMediaGeral(usuarioLogado?.data.id);

    return Padding(
      padding: const EdgeInsets.only( left:8.0, right: 8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.white,
              //height: width + 20,
              width: width,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Utils.getIconSemaforo(mediaGeral),
                            Text('''$mediaGeral ''', style: TextStyle(color: Utils.getColorSemaforo(mediaGeral)),),
                          ],
                        ),
                        Text('''$mediaGeral ''',
                          style: AppTextStyles.titleCardBlack(10, context),),
                        const SizedBox( width: 10),
                        mediaGeral > 0 && !mediaGeral.isNaN ?
                        Image.asset(_getUrl(mediaGeral), height: width / 10, width: width / 10,):
                        Container()
                      ]
                  ),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text("média dos ultimos relatórios", style: AppTextStyles.titleCardBlack(28, context),),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  botao(width, usuarioLogado)
                ],
              ) /*GridView.builder(

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
              ),*/
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.levelButtonTextFacil,
              width: width,

              child: Text("dddd"),
            ),
          )
        ],
      ),
    );
  }


   botao(var width, var usuarioLogado) {

    return GestureDetector(

       onTap: () {
         Navigator.pushNamed(context,'/pergunta_page', arguments: ScreenArgumentsUsuario(usuarioLogado.data));

       },
       child: Padding(
         padding: EdgeInsets.only(left: width / 5, right: width / 5),
         child: Container(

           height: 60,
           decoration: BoxDecoration(
               gradient: AppGradients.buttonSentimento,
               borderRadius: const BorderRadius.all(
                 Radius.circular(25.0),
               ),
               boxShadow: [
                 BoxShadow(
                   color: Colors.pink.withOpacity(0.2),
                   spreadRadius: 4,
                   blurRadius: 10,
                   offset: const Offset(0, 3),
                 )

               ]

           ),

           child: Center(
             child: Text(
                        'Como está se sentindo hoje?', textAlign: TextAlign.left,
                        style:AppTextStyles.textoSentimentoNegritoWhite(28, context)
             ),
           ),
         ),
       ),
     );
   }

  void _getMediaGeral(String id) async {

    _mediaGeral = [];
    var respostaRepository =  RespostaRepository(await DBHelper.instance.database);
    List lista = await respostaRepository.getCountDistinctByUsuarioId(id);

    _mediaGeral = lista;
    setState(() {
      _mediaGeral;
      double cont = 0;
      mediaGeral = 0;
      media = 0;

      for(var item in _mediaGeral){
        var total = item['media'];
        media += total;
        cont ++;
      }
      var mediaFomatada = (media / cont).toStringAsFixed(1);
      mediaGeral  = double.parse(mediaFomatada);

    });

  }

  _getUrl(var media){
   return Utils.respostaEmoji(media);
  }
  }


