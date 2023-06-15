import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/api/escola_api.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

import '../api/turma_api.dart';
import '../database/db_helper.dart';
import '../database/repositories/EscolaRepository.dart';
import '../database/repositories/TurmaRepository.dart';
import '../models/escola.dart';
import '../models/turma.dart';

class PerfilPage extends StatefulWidget {
  final ScreenArgumentsUsuario? usuarioLogado;

  const PerfilPage(this.usuarioLogado, {Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  ScreenArgumentsUsuario? usuarioLogado;
  Turma? turma;
  Escola? escola;

  @override
  void initState() {
    usuarioLogado = widget.usuarioLogado;
    _getTurma();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: _appBar(width, usuarioLogado, "como se sente?"),
      body: Center(
        child: Container(
          height: height / 1.5,
          width: width / 1.2,
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
          child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Utils.sizedBox(20, 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:  Image.asset(
                ///TODO Imagem do usuario
                'assets/images/usuario.png',
                height: MediaQuery.of(context).size.width / 5,
                //   width: MediaQuery.of(context).size.width / 10,
              ),
            ),
            Utils.sizedBox(20, 20),
            Text('''${usuarioLogado?.data.nome}''', style: AppTextStyles.titleCardBlack(15, context),),
            Utils.sizedBox(20, 20),
            Text('''Cpf: ${usuarioLogado?.data.cpf}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''E-mail: ${usuarioLogado?.data.email}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Nascido: ${Utils.formatarData(usuarioLogado?.data.dataNascimento, true) }''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Fone: ${usuarioLogado?.data.telefone}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Escola: ${escola != null ? escola?.nome : ""}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Turma: ${turma?.descricao}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),

          ],
        ),
      ),
     )
    )
    ;
  }
  void _getTurma() async {

    ///Buscar a turma DB interno:
    var turmaRepository = TurmaRepository(await DBHelper.instance.database);
    turma = await turmaRepository.getById(usuarioLogado?.data.turmaId);
    ///Se turma não existir:

    if(turma == null && mounted){
      if(await Utils.isConnected()){
        Turma? turmaApi  = await TurmaApi(context).getById(usuarioLogado?.data.turmaId);

        if(turmaApi != null && mounted){
          turma = await turmaRepository.getById(usuarioLogado?.data.turmaId);
          _getEscola(turmaApi.escolaId);
          }
        }
      }else{
      _getEscola(turma!.escolaId);
       }
        setState(() {
          turma;
        });
      }

  _getEscola(String escolaId) async{

    ///Buscar a escola DB interno:
    var escolaRepository = EscolaRepository(await DBHelper.instance.database);
    escola = await escolaRepository.getById(escolaId);

    ///Caso vazio, buscar na API:
    if(escola == null && mounted){
      if(await Utils.isConnected()){
         await EscolaApi(context).getById(escolaId);
      }
      escola = await escolaRepository.getById(escolaId);

    }
    setState(() {
      escola;
    });
  }
  _appBar(double width, ScreenArgumentsUsuario? usuarioLogado, String texto){

    return AppBar(
      toolbarHeight: 70,
      elevation: 0.0,
      flexibleSpace: Container(
        height: width / 3.5,
        decoration:  const BoxDecoration(
          gradient: AppGradients.petMacho,
          color: Colors.orange,
          boxShadow:  [
            BoxShadow(blurRadius: 50.0)
          ],

        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(width: width /10,),
            ///Foto:
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:  Image.asset(
                ///TODO Imagem do usuario
                'assets/images/usuario.png',
                height: MediaQuery.of(context).size.width / 10,
                //   width: MediaQuery.of(context).size.width / 10,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            ///NOme
            SizedBox(
              height: (MediaQuery.of(context).size.width / 10) - 17,
              // width: MediaQuery.of(context).size.width / 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('''Perfil''' , style: AppTextStyles.titleAppBarUsuario(25, context),),

                ],),
            )

          ],
        ),
        _sizedBox(10)
      ],
      //leadingWidth: 220,

    );
  }
  _sizedBox(double width){
    return SizedBox(
      width: width,
    );
  }
}
